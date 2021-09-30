<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Theatres</title>
<meta charset="ISO-8859-1">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://kit.fontawesome.com/1a63ab4674.js" crossorigin="anonymous"></script>
  <script
      src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.js"
      defer
    ></script>
  <script src="//code.jquery.com/jquery-latest.min.js"></script>
</head>
<body class="bg-gray-100">
<nav class="bg-gray-800">
  <div class="max-w-7xl mx-auto px-2 sm:px-6 lg:px-8">
    <div class="relative flex items-center justify-between h-16">
      <div class="absolute inset-y-0 left-0 flex items-center sm:hidden">
        <button type="button" class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-white hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white" aria-controls="mobile-menu" aria-expanded="false">
          <span class="sr-only" >Open main menu</span>
          <svg class="block h-6 w-6" id="menu-icon" onclick="showMenu();" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
          <svg class="hidden h-6 w-6" id="close-icon" onclick="closeMenu()" onclick="document.getElementById('mobile-menu').style.display='hidden'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>
      <div class="flex-1 flex items-center justify-center sm:items-stretch sm:justify-start">
        <div class="flex-shrink-0 flex text-white font-extrabold items-center">
    			MyTickets
        </div>
        <div class="hidden sm:block sm:ml-6">
          <div class="flex space-x-4">
            <a href="/admin" class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Dashboard</a>
            <a href="/managetheatres" class="bg-gray-900 text-white px-3 py-2 rounded-md text-sm font-medium" aria-current="page" >Manage Theatres</a>
            <a href="/" class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Book a Movie</a>
          </div>
        </div>
      </div>
      <div class="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">
        <div class="ml-3 relative">
        </div>
      </div>
    </div>
  </div>
  <div class="hidden transition duration-500 ease-in-out" id="mobile-menu">
    <div class="px-2 pt-2 pb-3 space-y-1">
      <a href="/admin" class="text-gray-300 hover:bg-gray-700 hover:text-white block px-3 py-2 rounded-md text-base font-medium">Dashboard</a>
      <a href="/managetheatres" class="bg-gray-900 text-white block px-3 py-2 rounded-md text-base font-medium" aria-current="page" >Manage Theatres</a>
      <a href="/" class="text-gray-300 hover:bg-gray-700 hover:text-white block px-3 py-2 rounded-md text-base font-medium">Movies</a>
    </div>
  </div>
</nav>
<div id="modal1" class="fixed z-10 inset-0 overflow-y-auto hidden" aria-labelledby="modal-title" role="dialog" aria-modal="true">
  <div class="flex transition ease-out duration-300  items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
    <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true"></div>
    <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
    <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
      <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
        
            <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-title">
              Add Show Time 
            </h3>
            <br>
          <form class="w-full" action="/addshowtime" method="post">
               <input type="hidden" name="location" value="${location}"  >
              <input type="hidden" name="tid" value="${theatre.tid}" >
              <table>
              <tr>
              <td>
               <select name="hour" type="text"  class="appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white timepicker"  autofocus>
               <option>01</option>
               <option>02</option>
               <option>03</option>
               <option>04</option>
               <option>05</option>
               <option>06</option>
               <option>07</option>
               <option>08</option>
               <option>09</option>
               <option>10</option>
               <option>11</option>
               <option>12</option>
               </select>
              </td>
              <td>&nbsp;&nbsp;</td>
              <td>
               <select name="minute" type="text"  class="appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white timepicker" >
               <option>00</option>
               <option >05</option>
               <option >10</option>
               <option >15</option>
               <option >20</option>
               <option >25</option>
               <option >30</option>
               <option >35</option>
               <option >40</option>
               <option >45</option>
               <option >50</option>
               <option >55</option>
               </select>
               </td>
              <td>&nbsp;&nbsp;</td>
              <td> <select type="text" name="meridiem" class="appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white timepicker" >
              <option>AM</option>
              <option>PM</option>
              </select>
              </td>
              </tr>
              </table>

                  <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                  <button type="submit" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-indigo-600 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:ml-3 sm:w-auto sm:text-sm">
                    Save
                  </button>
                  <button onclick="closemodal('modal1')" type="button" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                    Cancel
                  </button>
                </div>
            </form>
            
        </div>
      </div>
    </div>
  </div>
</div>
<div id="modal2" class="fixed z-10 inset-0 overflow-y-auto hidden" aria-labelledby="modal-title" role="dialog" aria-modal="true">
  <div class="flex transition ease-out duration-300  items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
    <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true"></div>
    <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
    <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
      <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
        
            <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-title">
              Select a Movie 
            </h3>
            <br>
          <form class="w-full" action="/screennewmovie" method="post">
            <input type="hidden" name="location" value="${location}"  >
              <input type="hidden" name="tid" value="${theatre.tid}" >
              <select name="movie_id" id="screen_movie_id" onchange="changeformstatus()" class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-state">
		          <option value="none">Select a movie</option>
		          <c:forEach items="${allmovies}" var="movie">
		          <option value=${movie.movie_id }>${movie.movie_name}</option>
		          </c:forEach>
		        </select>
              
                  <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                  <button type="submit" id="submit-btn" class="opacity-30 w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-indigo-600 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:ml-3 sm:w-auto sm:text-sm">
                    Save
                  </button>
                  <button onclick="closemodal('modal2')" type="button" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                    Cancel
                  </button>
                </div>
            </form>
            
        </div>
      </div>
    </div>
  </div>
</div>
<script>
document.getElementById("submit-btn").disabled=true;
function changeformstatus(){
	if(document.getElementById("screen_movie_id").value=="none"){
		document.getElementById("submit-btn").disabled=true;
		document.getElementById("submit-btn").style.opacity="0.3";
	}
	else{
		document.getElementById("submit-btn").style.opacity="1";
		document.getElementById("submit-btn").disabled=false;
	}
}

</script>
 <button type="button" onclick="showmodal('modal1')"  class="cursor-pointer float-right mr-6 mt-6 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
             <i class="fas fa-plus" style="margin-right:7px;margin-top:4.5px;font-size:12px"></i> Add New Show Time
            </button> 
<br>
<br>
<section class="text-gray-600 body-font relative">
  <div class="container px-5 py-12 mx-auto">
    <div class="flex flex-col text-center w-full mb-12">
      <h1 class="sm:text-3xl text-2xl font-medium title-font mb-4 text-gray-900">${theatre.tname}</h1>
      <div>
      <input type="date" id="date" onchange="showstats()" class="appearance-none block mx-auto  bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" />
		<div id="stats" class="  flex-wrap flex mt-4" >
		
		</div>
		</div>
   </div>
 </div>
</section>

   <button type="button" onclick="showmodal('modal2')"  class="cursor-pointer float-right mr-6 mt-6 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
             <i class="fas fa-eye" style="margin-right:7px;margin-top:4.5px;font-size:12px"></i> Screen a New Movie
            </button> 
            <br>
            <br><br>
<div id="matter" class="w-1/2 mx-auto">

  </div>
  <br>

<section class="text-gray-600  body-font">
  <div class="container px-3 mx-auto">
    <div class="flex-wrap flex -m-4">
    <c:forEach var="movie"  items="${movies}" >
	    <c:forEach  var="movieinfo" items="${moviesinfo}" >
	    <c:if test = "${movie.movie_id == movieinfo.movie_id }">
	      <div class="p-4 lg:w-1/2 py-12 rounded">
	      	<div class="bg-white p-5 shadow-md">
	        <div class="h-full flex sm:flex-row flex-col items-center sm:justify-start justify-center text-center sm:text-left">
	          <img alt="team" class="flex-shrink-0 rounded-lg w-48 h-84 object-cover object-center sm:mb-0 mb-4" src="${movieinfo.img}" >
	          <div class="flex-grow sm:pl-8">
	         <button type="button" title="remove" onclick="unscreenmovie('${movie.id}','${theatre.tid}','${location}')" class="float-right cursor-pointer w-8 h-8  justify-center  rounded-full border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
              <i class="fas fa-eye-slash"></i>
            </button> 
	          <input type="hidden" value="${movie.start_date}" class="start_date_text">
	           <input type="hidden" value="${movie.end_date}" class="close_date_text">
	          <form id="form${movie.id}">
	            <h2 class="title-font font-medium text-lg text-black">${movieinfo.movie_name}</h2>
	            <br>
	            <div class="w-full  px-3 mb-6 md:mb-0">
			      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-zip">
			        Start date
			      </label>
			      <input  name="startdate" class="startdate appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"  type="date" value="${movie.start_date}" placeholder="Start date">
			    </div>
			    <br>
			    <div class="w-full  px-3 mb-6 md:mb-0">
			      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-zip">
			        Closing date
			      </label>
			      <input name="closedate" class="closedate appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"  type="date" value="${movie.end_date}" placeholder="Closing date">
			    </div>
	            <button type="button" onclick="updatedates('${movie.id}')" class="float-left cursor-pointer  mr-6 mt-6 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
              Update
            </button> 
            </form>
	          </div>
	        </div>
	        </div>
	      </div>
	      </c:if>
	      </c:forEach>
      </c:forEach>
    </div>
  </div>
</section>

<br>
<br><br><br>
<section class="text-gray-600 body-font">
  <div class="container px-5 py-24 mx-auto">
    <div class="flex flex-wrap -m-4">
        <c:forEach items="${theatres}" var="item">
        <c:if test = "${item.tid != theatre.tid }">
      <div class="xl:w-1/3 w-full md:w-1/2 p-4" >
        <div class=" p-6 rounded-lg cursor-pointer shadow-md bg-white hover:shadow-2xl transition duration-500" onclick="window.location.href='/theatre?location=${location}&tid=${item.tid}';">
          <div class="w-10 h-10 inline-flex items-center justify-center rounded-full bg-indigo-100 text-indigo-500 mb-4">
             ${item.tid}
          </div>
          <h2 class="text-lg text-gray-900 font-medium title-font mb-2">${item.tname}</h2>
          <p class="leading-relaxed text-base">${item.seats} seats</p>
        </div>
      </div>
      </c:if>
      </c:forEach>
    </div>
   </div>
</section>

<br><br><br><br><br><br>
<script>
var sds = document.getElementsByClassName("start_date_text");
var cds = document.getElementsByClassName("close_date_text");
for(let i=0;i<sds.length;i++){
	document.getElementsByClassName("startdate")[i].value=dateFormat(sds[i].value);
	document.getElementsByClassName("closedate")[i].value=dateFormat(cds[i].value);
}

function showMenu(){
	document.getElementById('mobile-menu').style.display='block';
	document.getElementById('close-icon').style.display='block';
	document.getElementById('menu-icon').style.display='none';
	
}
function closeMenu(){
	document.getElementById('mobile-menu').style.display='none';
	document.getElementById('close-icon').style.display='none';
	document.getElementById('menu-icon').style.display='block';
}
function showmodal(m){
	document.getElementById(m).style.display='block';	
}
function closemodal(m){
	document.getElementById(m).style.display='none';
}
function dateFormat(x){
	var list = x.split("-");
	return list[2]+"-"+list[1]+"-"+list[0];
}
function unscreenmovie(mid,tid,location){
	if(confirm("Do you really want to unscreen this movie?")){
		window.location.href='/unscreenmovie?id='+mid+'&tid='+tid+'&location='+location;
	}
}
function updatedates(id){
	var x = $("#form"+id).serializeArray();
	var values=[]
    $.each(x, function(i, field){
      values.push(field.value);
    });
    if(values[0]>values[1]){
		alert("Start date must be greater than close date");
    }
    else{
  	  var xhttp = new XMLHttpRequest();
	    xhttp.onreadystatechange = function() {
	    	  document.getElementById("matter").innerHTML=this.responseText;

	      if (this.readyState == 4 && this.status == 200) {
	    	  document.getElementById("matter").innerHTML=this.responseText;
	      }
	    };
	    xhttp.open("GET", "adminupdatedates?startdate="+dateFormat(values[0])+"&closedate="+dateFormat(values[1])+"&id="+id+"&location="+"${location}",true);
	    xhttp.send();
    }
}
var now = new Date();
var month = (now.getMonth() + 1);               
var day = now.getDate();
if (month < 10) 
    month = "0" + month;
if (day < 10) 
    day = "0" + day;
var today = now.getFullYear() + '-' + month + '-' + day;
document.getElementById("date").value=today;
showstats();
function showstats(){
	  var tid ="${theatre.tid}";
	  var date = dateFormat(document.getElementById("date").value);
	  var xhttp = new XMLHttpRequest();
	    xhttp.onreadystatechange = function() {
	      if (this.readyState == 4 && this.status == 200) {
		      var output = this.responseText;
		      var shows=output.split("%");
		      shows.pop();
		      var stats=[];
		      for(let j=0;j<shows.length;j++){
				stats.push(shows[j].split("|"));
			}
		      document.getElementById("stats").innerHTML="";
			for(let k=0;k<stats.length;k++){
		      var htmlOutput="<div class='relative rounded-lg  lg:w-1/5 bg-white p-5 m-4 w-full shadow-2xl'>"+
		      "<div class='flex mb-2 items-center justify-between'>"+
		      "<div>"+
		      "<span class=' font-bold inline-block py-1 px-2 uppercase rounded-full text-indigo-500 '>"+
		      stats[k][0]+
		      "</span>"+
		      "</div>"+
		      "<div class='text-right'>"+
		      "<span class='text-sm font-semibold inline-block'>"+stats[k][3]+"% "+
		        "</span>"+
		        "</div>"+
		        "</div>";
		        if(stats[k][3]==0){
				htmlOutput+="<div class='overflow-hidden h-2 mb-4 text-xs flex rounded bg-pink-200'>"+
		        "<div style='width:"+stats[k][3]+"%' class='shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-pink-500'></div>"+
		        "</div>";
			    }else if (stats[k][3]>0 && stats[k][3]<50){
			    	htmlOutput+="<div class='overflow-hidden h-2 mb-4 text-xs flex rounded bg-yellow-200'>"+
			        "<div style='width:"+stats[k][3]+"%' class='shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-yellow-500'></div>"+
			        "</div>";
				}else{
					htmlOutput+="<div class='overflow-hidden h-2 mb-4 text-xs flex rounded bg-green-200'>"+
			        "<div style='width:"+stats[k][3]+"%' class='shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-green-500'></div>"+
			        "</div>";
				}
		        
		        htmlOutput+="<div class='text-sm font-bold text-left ml-2'>Rs. "+stats[k][1]+"<span class='float-right'>"+"("+stats[k][2]+"/${theatre.seats}"+")"+"</span></div>"+
		        "</div>";
	    	  document.getElementById("stats").innerHTML+=htmlOutput;
			}
	      }
	    };
	    xhttp.open("GET", "bookingstats?tid="+tid+"&date="+date,true);
	    xhttp.send();
  	}

</script>

</body>
</html>