package com.myproject.demo.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.myproject.demo.model.*;
import com.myproject.demo.dao.*;
@Controller
public class Admin {
	
	public static String uploadDirectory=System.getProperty("user.dir")+"/src/main/resources/static/images";
	@Autowired
	admin_repo admin_repo;
	
	@Autowired
	auth_user_repo user_repo;
	
	@Autowired
	moviesRepo moviesRepo;
	
	@Autowired
	LocationsRepo locationsrepo;
	
	@Autowired
	TheatresRepo theatresrepo;
	
	@Autowired
	TimingsRepo timingsrepo;
	
	@Autowired
	Movie_TheatreRepo movie_theatresrepo;
	
	@Autowired
	MovieInfoRepo movieinforepo;
	
	@Autowired
	BookingsRepo bookingsrepo;
	
	@Autowired
	TicketsRepo ticketsrepo;
	
	
	public boolean isAdmin() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth.getName()!="anonymousUser") {
			auth_user user=user_repo.findById(user_repo.findIdByEmail(auth.getName())).orElse(null);
			admin adminuser = admin_repo.findById(user.getAuth_user_id()).orElse(null);
			if(adminuser!=null) {
				
				return true;
			}
			else {
				return false;
			}

		}
		else {
			return false;
		}

	}
	@RequestMapping("/admin")
	public ModelAndView Dashboard() {
		if(isAdmin()) {
			ModelAndView mv = new ModelAndView("dashboard.jsp");
			mv.addObject("movies",moviesRepo.findAll());
			return mv;
		}
		else {
			return new ModelAndView("redirect:"+"/");
		}

	}
	
	@RequestMapping(value="/addmovie",method=RequestMethod.GET)
	public ModelAndView AddMovie() {
		if(isAdmin()) {
			return new ModelAndView("addmovie.jsp");
		}
		else {
			return new ModelAndView("redirect:"+"/");
		}
	}
	
	@RequestMapping("/managetheatres")
	public ModelAndView ManageTheatres() {
		if(isAdmin()) {
			ModelAndView mv = new ModelAndView("locations.jsp");
			List<String> locations = locationsrepo.findAllLocations();
			String defaultlocation="none";
			if(locations.size()==0)
				defaultlocation="none";
			else
				defaultlocation=locations.get(0);
			mv.addObject("defaultlocation",defaultlocation);
			mv.addObject("locations",locations);
			return mv;
		}
		else {
			return new ModelAndView("redirect:"+"/");
		}
	}
	@RequestMapping("/adminfiltertheatres")
	public ModelAndView AdminFilterTheatres(@RequestParam("location") String location) {
		ModelAndView mv =new ModelAndView("theatres.jsp");
		List<Integer> tids = locationsrepo.findTheatresByLocation(location);
		List<Theatres> theatres = new ArrayList<Theatres>();
		for(Integer tid: tids) {
			theatres.add(theatresrepo.findById(tid).orElse(null));
		}
		mv.addObject("theatres",theatres);
		mv.addObject("location", location);
		return mv;
		
	}
	@RequestMapping("/theatre")
	public ModelAndView TheatreView(@RequestParam("tid") int tid,@RequestParam("location") String location) {
		if(isAdmin()) {  
			ModelAndView mv = new ModelAndView("theatre.jsp");
			Theatres theatre = theatresrepo.findById(tid).orElse(null);
			if(theatre!=null) {
				mv.addObject("allmovies", moviesRepo.findAll());
				mv.addObject("theatre",theatresrepo.findById(tid).orElse(null));
				mv.addObject("timings",timingsrepo.findAllByTid(tid));
				List<Movie_Theatre> movies = movie_theatresrepo.findAllMoviesByTid(tid);
				List<movies> moviesinfo = new ArrayList<movies>();
				for(Movie_Theatre mt:movies) {
					moviesinfo.add(moviesRepo.findById(mt.getMovie_id()).orElse(null));
				}
				mv.addObject("movies",movies);
				mv.addObject("moviesinfo",moviesinfo);
				List<Integer> tids = locationsrepo.findTheatresByLocation(location);
				List<Theatres> theatres = new ArrayList<Theatres>();
				for(Integer ltid: tids) {
					theatres.add(theatresrepo.findById(ltid).orElse(null));
				}
				mv.addObject("theatres",theatres);
				mv.addObject("location", location);
				return mv;
			}
			else {
				return new ModelAndView("redirect:"+"/managetheatres");
			}
		}
		else {
			return new ModelAndView("redirect:"+"/");
		}
	}
	@RequestMapping(value="/adminupdatedates",method=RequestMethod.GET)
	public ModelAndView AdminUpdateDates(@RequestParam("startdate") String start_date,@RequestParam("closedate") String end_date,@RequestParam("id") int id) {
		ModelAndView mv = new ModelAndView("message.jsp");
		
		if(isAdmin()) {
			Movie_Theatre mt = movie_theatresrepo.findById(id).orElse(null);
			if(mt!=null) {
				mt.setStart_date(start_date);
				mt.setEnd_date(end_date);
				movie_theatresrepo.save(mt);
				mv.addObject("status","success");
				mv.addObject("message","Updated successfully.");
			}else {
				mv.addObject("message","Updation failed. Try again");
				mv.addObject("status","fail");
			}

		}else {
			mv.addObject("message","Updation failed. Try again");
			mv.addObject("status","fail");
		}
		return mv;
	}
	@RequestMapping(value="/addtheatre")
	public ModelAndView AddTheatre(@RequestParam("tname") String tname,@RequestParam("seats") int seats,@RequestParam("location") String loc) {
		if(isAdmin()) {
			Theatres theatre = new Theatres();
			theatre.setSeating_plan("defaultseatingplan");
			theatre.setTname(tname);
			theatre.setSeats(seats);
			theatresrepo.save(theatre);
			Locations l = new Locations();
			l.setLocation(loc);
			l.setTid(theatre.getTid());
			locationsrepo.save(l);
			return new ModelAndView("redirect:"+"/managetheatres");
		}else {
			return new ModelAndView("redirect:"+"/");
		}
	}
	@RequestMapping(value="/addshowtime")
	public ModelAndView AddShowTime(@RequestParam("hour") String hour,@RequestParam("minute") String minute,@RequestParam("meridiem") String meridiem,@RequestParam("tid") int tid,@RequestParam("location") String location) {
		if(isAdmin()) {
			String time = hour+":"+minute+" "+meridiem;
			Timings timings = new Timings();
			timings.setTid(tid);
			timings.setTime(time);
			timingsrepo.save(timings);
			return new ModelAndView("redirect:"+"/theatre?location="+location+"&tid="+tid);
		}else {
			return new ModelAndView("redirect:"+"/");
		}
	}
	@RequestMapping(value="/screennewmovie")
	public ModelAndView ScreeNewMovie(@RequestParam("tid") int tid,@RequestParam("movie_id") int movie_id,@RequestParam("location") String location) {
		if(isAdmin()) {
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");  
		    Date date = new Date();  
			Movie_Theatre mt = new Movie_Theatre();
			mt.setMovie_id(movie_id);
			mt.setTid(tid);
			mt.setStart_date(formatter.format(date));
			mt.setEnd_date(formatter.format(date));
			movie_theatresrepo.save(mt);
			return new ModelAndView("redirect:"+"/theatre?location="+location+"&tid="+tid);
		}else {
			return new ModelAndView("redirect:"+"/");
		}
	}
	@RequestMapping(value="/addmovie",method=RequestMethod.POST)
	public ModelAndView AddMovie(@RequestParam("movie_name") String movie_name,@RequestParam("genre") String genre,
			@RequestParam("lan") String lan,@RequestParam("rd") String rd,@RequestParam("per") String per,
			@RequestParam("link") String link,@RequestParam("story") String story,@RequestParam("ml") String ml,
			@RequestParam("img") MultipartFile img) throws IOException {
		if(isAdmin()) {

			String original = img.getOriginalFilename();
			String genericfilename = movie_name+"_"+lan+"."+original.substring(original.lastIndexOf('.')+1);
			movies movie = new movies(); 
			movie.setMovie_name(movie_name);
			movie.setImg(genericfilename);
			moviesRepo.save(movie);
			
			MovieInfo mi = new MovieInfo();
			mi.setGenre(genre);
			mi.setLan(lan);
			mi.setLink(link);
			mi.setMl(ml);
			mi.setMovie_id(movie.getMovie_id());
			mi.setPer(per);
			mi.setRd(rd);
			mi.setStory(story);
			movieinforepo.save(mi);
			
			Path filenamepath = Paths.get(uploadDirectory, genericfilename);
			Files.write(filenamepath, img.getBytes());
			return new ModelAndView("redirect:"+"/admin");
		}
		else {
			return new ModelAndView("redirect:"+"/");
		}
	}
	
	@RequestMapping(value="/editmovie",method=RequestMethod.GET)
	public ModelAndView EditMovie(@RequestParam("mid") int mid) {
		if(isAdmin()) {
			MovieInfo mi = movieinforepo.findById(mid).orElse(null);
			if(mi!=null) {
				ModelAndView mv = new ModelAndView("editmovie.jsp");
				mv.addObject("movieinfo", mi);
				mv.addObject("movie", moviesRepo.findById(mid).orElse(null));
				mv.addObject("languages", new String[] {"English","Hindi","Telugu","Tamil"});
				return mv;
			}else {
				return new ModelAndView("redirect:"+"/");
			}
		}else {
			return new ModelAndView("redirect:"+"/");
		}
	}
	@RequestMapping(value="/editmovie",method=RequestMethod.POST)
	public ModelAndView EditMovie(@RequestParam("mid") int mid,@RequestParam("movie_name") String movie_name,@RequestParam("genre") String genre,
			@RequestParam("lan") String lan,@RequestParam("rd") String rd,@RequestParam("per") String per,
			@RequestParam("link") String link,@RequestParam("story") String story,@RequestParam("ml") String ml,
			@RequestParam("img") MultipartFile img) throws IOException {
		if(isAdmin()) {
			String original = img.getOriginalFilename();
			String genericfilename = movie_name+"_"+lan+"."+original.substring(original.lastIndexOf('.')+1);
			movies movie = moviesRepo.findById(mid).orElse(null);
			movie.setMovie_name(movie_name);
			movie.setImg(genericfilename);
			moviesRepo.save(movie);
			
			MovieInfo mi = movieinforepo.findById(mid).orElse(null);
			mi.setGenre(genre);
			mi.setLan(lan);
			mi.setLink(link);
			mi.setMl(ml);
			mi.setMovie_id(movie.getMovie_id());
			mi.setPer(per);
			mi.setRd(rd);
			mi.setStory(story);
			movieinforepo.save(mi);
			
			Path filenamepath = Paths.get(uploadDirectory, genericfilename);
			Files.write(filenamepath, img.getBytes());
			return new ModelAndView("redirect:"+"/admin");
		}
		else {
			return new ModelAndView("redirect:"+"/");
		}
	}
	@RequestMapping("/unscreenmovie")
	public ModelAndView UnScreenMovie(@RequestParam("id") int id,@RequestParam("tid") int tid,@RequestParam("location") String location) {
		if(isAdmin()) {
			movie_theatresrepo.deleteById(id);
			return new ModelAndView("redirect:"+"/theatre?location="+location+"&tid="+tid);
		}else {
			return new ModelAndView("redirect:"+"/");
		}
	}
	@RequestMapping(method=RequestMethod.GET,produces = "application/json",value="/bookingstats")
	public ResponseEntity<String> BookingsStats(@RequestParam("date") String date,@RequestParam("tid") int tid) {
		if(isAdmin()) {
			List<Timings> times = timingsrepo.findAllByTid(tid);
			int seats = theatresrepo.findById(tid).orElse(null).getSeats();
			String stats="";
			for(Timings timing:times) {
				
				List<Bookings> showbookings = bookingsrepo.findShowTrans(tid, date, timing.getTime());
				int amt=0;
				int cnt=0;
				for(Bookings booking:showbookings) {
					amt=amt+Integer.parseInt(booking.getAmount());
					cnt=cnt+ticketsrepo.CountTicketByTrans(booking.getTrans_id());
				}
				stats=stats+timing.getTime()+"|"+Integer.toString(amt)+"|"+Integer.toString(cnt)+"|"+Integer.toString((cnt*100)/seats)+"%";
			}
			return new ResponseEntity<String>(stats,HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("",HttpStatus.OK);
		}
	}
	
}

