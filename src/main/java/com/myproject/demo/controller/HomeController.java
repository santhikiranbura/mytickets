package com.myproject.demo.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.myproject.demo.dao.BookingsRepo;
import com.myproject.demo.dao.LocationsRepo;
import com.myproject.demo.dao.MovieInfoRepo;
import com.myproject.demo.dao.Movie_TheatreRepo;
import com.myproject.demo.dao.RatingsRepo;
import com.myproject.demo.dao.TheatresRepo;
import com.myproject.demo.dao.TicketsRepo;
import com.myproject.demo.dao.TimingsRepo;
import com.myproject.demo.dao.auth_user_repo;
import com.myproject.demo.dao.moviesRepo;
import com.myproject.demo.model.Bookings;
import com.myproject.demo.model.MovieInfo;
import com.myproject.demo.model.Movie_Theatre;
import com.myproject.demo.model.Ratings;
import com.myproject.demo.model.Theatres;
import com.myproject.demo.model.Tickets;
import com.myproject.demo.model.Timings;
import com.myproject.demo.model.auth_user;
import com.myproject.demo.model.movies;

@Controller
public class HomeController {

	@Autowired
	moviesRepo movierepo;
	
	@Autowired
	auth_user_repo user_repo;
	
	@Autowired
	MovieInfoRepo movieinforepo;
	
	@Autowired
	TheatresRepo theatresrepo;
	
	@Autowired
	TimingsRepo timingsrepo;
	
	@Autowired
	Movie_TheatreRepo movie_theatrerepo;
	
	@Autowired
	LocationsRepo locationsrepo;
	
	@Autowired
	BookingsRepo bookingsrepo;
	
	@Autowired
	TicketsRepo ticketsrepo;
	
	@Autowired
	RatingsRepo ratingsrepo;

	public Set<Integer> filterbyloc(String loc) {
		List<Integer> ts=locationsrepo.findTheatresByLocation(loc);
		Set<Integer> a = new HashSet<Integer>(); 
		for(Integer id: ts) {
			List<Integer> ids=movie_theatrerepo.findMoviesByTid(id);
			for(Integer i :ids) {
				a.add(i); 
			}
		}
		return a;
	}
	public List<String> findbookedtickets(int mid,int tid,String date,String time){
		List<String> books=bookingsrepo.findAllTrans(mid,tid,date,time);
		List<String> booked=new ArrayList<String>();
		for(String trans_id :books) {
			List<String> tickets=ticketsrepo.findTicketByTrans(trans_id);
			for(String ticket:tickets) {
				booked.add(ticket);
			}
		}
		return booked;
	}
	public Date get_date(int num) {
		
		Calendar calendar = Calendar.getInstance();
		Date date = calendar.getTime();
		calendar.add(Calendar.DATE, num);
		date = calendar.getTime();
		return date;
	}

	@RequestMapping("/")
	public ModelAndView Home() throws AddressException, MessagingException, IOException {

		ModelAndView mv= new ModelAndView("home.jsp");
		List<String> lans= movieinforepo.findLans();
		mv.addObject("lans",lans);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String location="";
		if(auth.getName()!="anonymousUser") {
			mv.addObject("location",user_repo.findLocationByEmail(auth.getName()));
			mv.addObject("username",user_repo.findNameByEmail(auth.getName()));
			location=user_repo.findLocationByEmail(auth.getName());
		}
		else {
			mv.addObject("location","Warangal");
			location="Warangal";
		}
		List <movies> movie =new ArrayList<movies> ();
		Set<Integer> a=filterbyloc(location);
		for(Integer id : a) {
			movie.add(movierepo.findById(id).orElse(null));
		}
		mv.addObject("movie", movie);
		mv.addObject("alllocations",locationsrepo.findAllLocations());
		mv.addObject("current_lan","All languages");
		return mv;
	}
	@RequestMapping(value="/movie", method = RequestMethod.POST)
	public ModelAndView Movie(@RequestParam("movie_id") int movie_id) throws ParseException{
		
		ModelAndView mv= new ModelAndView("movie.jsp");
		MovieInfo mi=movieinforepo.findById(movie_id).orElse(null);
		movies movie=movierepo.findById(movie_id).orElse(null);
		mv.addObject("movie",movie);
		mv.addObject("movie_info",mi);
		List<String> lans= movieinforepo.findLans();
		mv.addObject("lans",lans);
		Iterable<movies> movielist = movierepo.findAll();
		mv.addObject("movielist",movielist);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth.getName()!="anonymousUser") {
			mv.addObject("location",user_repo.findLocationByEmail(auth.getName()));
			mv.addObject("username",user_repo.findNameByEmail(auth.getName()));
			Integer rating_id=ratingsrepo.findRatingById(user_repo.findIdByEmail(auth.getName()), movie_id);
			if(rating_id!=null) {
				mv.addObject("user_rating", (ratingsrepo.findById(rating_id).orElse(null)).getRating());
			}
			else {
				mv.addObject("user_rating",0);
			}
			
		}
		else {
			mv.addObject("location","Warangal");
		}
		if((ratingsrepo.findAllByMid(movie_id)).size() !=0) {
			mv.addObject("avgrating",ratingsrepo.findAverageByMid(movie_id));
		}
		else
		{
			mv.addObject("avgrating",0);
		}
		
		mv.addObject("alllocations",locationsrepo.findAllLocations());
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		List<String> dates = new ArrayList<String>();
		for(int i=0;i<4;i++) {
			dates.add(formatter.format(get_date(i)));
		}
		mv.addObject("dates",dates);
		return mv;
	}
	@RequestMapping("/filter")
	public ModelAndView filter(@RequestParam("language") String lan,@RequestParam("location") String loc) {
		ModelAndView mv= new ModelAndView("filter.jsp");
		List <movies> movie =new ArrayList<movies> ();
		Set<Integer> a = filterbyloc(loc);
		if(lan.equals("All languages")==false) {
			List<Integer> lids=movieinforepo.findByLan(lan);
			for(Integer id : a) {
				if(lids.contains(id)) {
				movie.add(movierepo.findById(id).orElse(null));
				}
			}
		}
		else {
			for(Integer id : a) {
				movie.add(movierepo.findById(id).orElse(null));
			}
		}
		mv.addObject("movie_list",movie);
		return mv;
	}
	@RequestMapping("/filter_theatres")
	public ModelAndView filter_theatres(@RequestParam("date") String date,@RequestParam("location") String loc,@RequestParam("movie_id") int mid) throws ParseException {
		ModelAndView mv= new ModelAndView("filter_theatres.jsp");
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		List<Integer> ts=locationsrepo.findTheatresByLocation(loc);
		List<Theatres> thes=new ArrayList<Theatres>();
		List<Timings> times=new ArrayList<Timings>();
		LinkedHashMap<Integer,String> hm=new LinkedHashMap<Integer,String>();  
		for(Integer id: ts) {
			Movie_Theatre temp = new Movie_Theatre();
			temp=movie_theatrerepo.findMovieByTid(id, mid);
			if(temp!=null) {
				Date current_date=formatter.parse(date);
				if(current_date.compareTo(formatter.parse(temp.getEnd_date())) < 0 && current_date.compareTo(formatter.parse(temp.getStart_date())) >= 0 ){
					
					thes.add(theatresrepo.findById(temp.getTid()).orElse(null));
					List<Timings> temp_times=timingsrepo.findAllByTid(id);
					for(Timings temp_time:temp_times) {
						boolean isadded=false;
						if(date.equals(formatter.format(get_date(0)))){
							int hours=LocalDateTime.now().getHour();
							int minutes=LocalDateTime.now().getMinute();
							String show_time=temp_time.getTime();
							int show_hours=Integer.parseInt(show_time.substring(0, 2));
							int show_minutes=Integer.parseInt(show_time.substring(3,5));
							if(show_time.substring(6, 8).equals("AM")) {
								if(hours<=12) {
									if(hours<show_hours) {
										times.add(temp_time);
										isadded=true;
									}
									else if(hours==show_hours&&minutes<show_minutes) {
										times.add(temp_time);
										isadded=true;
									}
								}
							}
							else {
								if(hours<12) {
									
										times.add(temp_time);
										isadded=true;
								}
								else if(hours==12&&hours==show_hours&&minutes<show_minutes) {
									times.add(temp_time);
									isadded=true;
								}
								else {
									if((hours-12)<show_hours) {
										times.add(temp_time);
										isadded=true;
									}
									else if((hours-12)==show_hours&&minutes<show_minutes) {
										times.add(temp_time);
										isadded=true;
									}
								}
							}
						}
						else {
							times.add(temp_time);
							isadded=true;
						}
						if(isadded) {
							List<String> Booked=findbookedtickets(mid,id,date,temp_time.getTime());
							int x=Booked.size();
							int y=(theatresrepo.findById(id).orElse(null)).getSeats();
							if((x*100/y) < 60) {
								hm.put(temp_time.getId(),"success");
							}
							else if((x* 100/y) < 80) {
								hm.put(temp_time.getId(),"warning");
							}
							else if((x* 100/y) < 100) {
								hm.put(temp_time.getId(),"danger");
							}
							else {
								hm.put(temp_time.getId(),"default");
							}
						}
					}
				}
			}
		}
		mv.addObject("hm",hm);
		mv.addObject("times", times);
		mv.addObject("theatres",thes);
		mv.addObject("bookingdate",date);
		mv.addObject("mid",mid);
		return mv;
	}
	@RequestMapping(value="/seatingplan",method=RequestMethod.POST)
	public ModelAndView seating_plan(@RequestParam("plan") String plan,@RequestParam(value="tid") int tid,@RequestParam("time") String time,@RequestParam("date") String date,@RequestParam("mid") int mid) {
		ModelAndView mv= new ModelAndView(plan+".jsp");
		mv.addObject("bookingdate",date);
		mv.addObject("mid",mid);
		mv.addObject("time", time);
		mv.addObject("tid",tid);
		List<String> booked = findbookedtickets(mid,tid,date,time);
		String json = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(booked);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("booked", json);
		return mv;
	}
	@RequestMapping("/bookticket")
	public ModelAndView bookticket(@RequestParam("amount") String amount,@RequestParam("date") String date,@RequestParam("tid") int tid,@RequestParam("mid") int mid,@RequestParam("time") String time,@RequestParam("seq") String seq) {
		ModelAndView mv= new ModelAndView("book.jsp");
		mv.addObject("bookingdate",date);
		mv.addObject("mid",mid);
		mv.addObject("time", time);
		mv.addObject("movie_name",(movierepo.findById(mid).orElse(null)).getMovie_name());
		mv.addObject("tid",tid);
		mv.addObject("tname",(theatresrepo.findById(tid).orElse(null)).getTname());
		mv.addObject("image",(movierepo.findById(mid).orElse(null)).getImg());
		mv.addObject("ticket", seq);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth.getName()!="anonymousUser") {
			mv.addObject("email",auth.getName());
		}
		else {
			mv.addObject("email","");
		}
		mv.addObject("amount",amount);
		return mv;
	}
	@RequestMapping(value="/success",method=RequestMethod.GET)
	public ModelAndView TicketReceipt(@RequestParam("id") String id) {
		ModelAndView mv= new ModelAndView("success.jsp");
		Bookings b=bookingsrepo.findByTransId(id);
		List<String> seq = ticketsrepo.findTicketByTrans(id);
		mv.addObject("image",(movierepo.findById(b.getMid()).orElse(null)).getImg());
		mv.addObject("movie_name",(movierepo.findById(b.getMid()).orElse(null)).getMovie_name());
		mv.addObject("tname",(theatresrepo.findById(b.getTid()).orElse(null)).getTname());
		mv.addObject("b",b);
		mv.addObject("seq",seq);
		return mv;
	}
	@RequestMapping(value="/success",method=RequestMethod.POST)
	public ModelAndView confirmbooking(@RequestParam("email") String email,@RequestParam("amount") String amount,@RequestParam("date") String date,@RequestParam("tid") int tid,@RequestParam("mid") int mid,@RequestParam("time") String time,@RequestParam("seq") String seq) throws AddressException, MessagingException,IOException {
		List<String> booked = findbookedtickets(mid,tid,date,time);
		String[]  ticket_list= seq.split(",");
		boolean check=false;
		for(int k=0;k<ticket_list.length;k++) {
			if(booked.contains(ticket_list[k])) {
				check=true;
			}
		}
		if(!check) {
			ModelAndView mv= new ModelAndView("success.jsp");
			Bookings b=new Bookings();
			b.setAmount(amount);
			b.setDate(date);
			b.setEmail(email);
			b.setMid(mid);
			b.setTid(tid);
			b.setTime(time);
		    String id = UUID.randomUUID().toString();
			b.setTrans_id(id);
			bookingsrepo.save(b);
			Tickets tickets[]=new Tickets[ticket_list.length];
			for (int j=0;j<ticket_list.length;j++) 
			{
				tickets[j]=new Tickets();
				tickets[j].setTrans_id(id);
				tickets[j].setTicket(ticket_list[j]);
				ticketsrepo.save(tickets[j]);
			}
			mv.addObject("image",(movierepo.findById(mid).orElse(null)).getImg());
			mv.addObject("movie_name",(movierepo.findById(mid).orElse(null)).getMovie_name());
			mv.addObject("tname",(theatresrepo.findById(tid).orElse(null)).getTname());
			mv.addObject("b",b);
			mv.addObject("seq",seq);
			return mv;
		}
		else {
			ModelAndView mv= new ModelAndView("failure.jsp");
			return mv;
		}
	}
	@RequestMapping("/ratemovie")
	public String ratemovie(@RequestParam("rating") int rating,@RequestParam("movie_id") int mid)
	{
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Integer auth_user_id=user_repo.findIdByEmail(auth.getName());
		Integer rating_id=ratingsrepo.findRatingById(auth_user_id, mid);
		if(rating_id ==null) {
			Ratings ratings = new Ratings();
			ratings.setAuth_user_id(auth_user_id);
			ratings.setMid(mid);
			ratings.setRating(rating);
			ratingsrepo.save(ratings);
		}
		else {
			Ratings ratings = ratingsrepo.findById(rating_id).orElse(null);
			ratings.setRating(rating);
			ratingsrepo.save(ratings);
		}
		return "Ratings Submitted Successfully";
	}
	@RequestMapping("/Account")
	public ModelAndView Account() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth.getName()!="anonymousUser") {
			ModelAndView mv = new ModelAndView("account.jsp");
			return mv;
		}
		else {
			ModelAndView mv = new ModelAndView("login.jsp");
			return mv;
		}
	}
	@RequestMapping(value="/updateprofile",method = RequestMethod.GET)
	public ModelAndView profile() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth.getName()!="anonymousUser") {
			ModelAndView mv = new ModelAndView("profile.jsp");
			auth_user user=user_repo.findById(user_repo.findIdByEmail(auth.getName())).orElse(null);
			List<String> locations =locationsrepo.findAllLocations();
			mv.addObject("user",user);
			mv.addObject("locations", locations);
			return mv;
		}
		else {
			ModelAndView mv = new ModelAndView("login.jsp");
			return mv;
		}
	}
	@RequestMapping(value="/updateprofile",method = RequestMethod.POST)
	public ModelAndView updateprofile(@RequestParam("full_name") String full_name,@RequestParam("location") String location,@RequestParam("email") String email) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth.getName()!="anonymousUser") {
			ModelAndView mv = new ModelAndView("account.jsp");
			auth_user user=user_repo.findById(user_repo.findIdByEmail(email)).orElse(null);
			if(user!=null) {
				user.setFull_name(full_name);
				user.setLocation(location);
				user_repo.save(user);
			}
			return mv;
		}
		else {
			ModelAndView mv = new ModelAndView("login.jsp");
			return mv;
		}	
	}
	@RequestMapping("/trans")
	public ModelAndView trans() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth.getName()!="anonymousUser") {
			ModelAndView mv = new ModelAndView("trans.jsp");
			List<Bookings> books=bookingsrepo.findAllByEmail(auth.getName());
			LinkedHashMap<String,String> ticket_list=new LinkedHashMap<String,String>();  
			LinkedHashMap<String,String> movie_list=new LinkedHashMap<String,String>();
			LinkedHashMap<String,String> theatre_list=new LinkedHashMap<String,String>();
			for(Bookings b:books) {
				List<String> tickets=ticketsrepo.findTicketByTrans(b.getTrans_id());
				String str = String.join(" ", tickets);
				ticket_list.put(b.getTrans_id(), str);
				movie_list.put(b.getTrans_id(),(movierepo.findById(b.getMid()).orElse(null)).getMovie_name());
				theatre_list.put(b.getTrans_id(),(theatresrepo.findById(b.getTid()).orElse(null)).getTname());
			}
			mv.addObject("bookings",books);
			mv.addObject("movies",movie_list);
			mv.addObject("theatres",theatre_list);
			mv.addObject("tickets",ticket_list);
			return mv;
		}
		else {
			ModelAndView mv = new ModelAndView("login.jsp");
			return mv;
		}
	}
	
}
