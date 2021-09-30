<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html  lang="en">
<head>
  <title>My Tickets</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="/images/favicon.ico" type="image/gif" >
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/1a63ab4674.js" crossorigin="anonymous"></script>
  <link href='https://fonts.googleapis.com/css?family=Aldrich' rel='stylesheet'>
  <link rel="stylesheet" href="/css/home.css">
      <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;900&display=swap"
      rel="stylesheet"
    />
    <meta
      name="viewport"
      content="width=device-width,initial-scale=1,maximum-scale=1"
    />
    <script
      src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.js"
      defer
    ></script>
</head>
<body class="bg-gray-100 ">
<nav class="bg-white  shadow-md lg:shadow-none fixed w-full">
  <div class="max-w-7xl mx-auto px-2 sm:px-6 lg:px-8">
    <div class="relative flex items-center justify-between h-20">
      <div class="absolute inset-y-0 left-0 flex items-center md:hidden">
        <!-- Mobile menu button-->
        <button type="button" class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-gray-400 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white" aria-controls="mobile-menu" aria-expanded="false">
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
        <div class="flex-shrink-0 flex  font-extrabold items-center cursor-pointer"  onclick="window.location.href='/'">
    			<img src="/images/MyTickets.png" class="w-8 h-8 rounded-full mr-2" >MyTickets
        </div>
        <div class="hidden sm:block sm:ml-6">
          <div class="flex space-x-8">
             <div class="dropdown">
				<input type="text" placeholder="Search.." class=" outline-none text-gray-700 bg-gray-100 rounded w-80 px-3 py-2  text-sm font-medium" id="myInput"  autocomplete="off" onkeyup="filterFunction()">
				    <div id="myDropdown" class="dropdown-content shadow-md w-80 bg-white rounded">
				     <c:forEach items="${movie}" var="temp">
				    <a href="javascript:void(0)" class="hover:bg-gray-100  transition duration-300 hover:text-indigo-500 hover:bg-opacity-50 px-5 py-2 mx-1 my-2  rounded-xl" onclick="gotomovie(${temp.movie_id})">${temp.movie_name}</a>
				    </c:forEach>
				  </div>
  			</div>
  		 <div class="dropdown w-40">
	 		<a class=" dropdown-toggle w-full text-sm font-medium rounded hover:text-indigo-500 bg-gray-100 px-3 py-2" href="javascript:void(0)"  data-toggle="dropdown">
	        <i class="fas fa-ad"></i> <span id="navbardrop1">${current_lan}</span>
	      	</a>
	      <div class="dropdown-menu shadow-md border-none bg-white p-2">
	        <a class="dropdown-item hover:text-indigo-500 transition duration-300 focus:bg-gray-100 focus:text-indigo-500" href="javascript:void(0)" onclick="filterbylan('All languages')">All languages</a>
	      <c:forEach items="${lans}" var="lan">
	        <a class="dropdown-item  hover:text-indigo-500 transition duration-300 focus:bg-gray-100 focus:text-indigo-500" href="javascript:void(0)" onclick="filterbylan('${lan}')">${lan}</a>
	        </c:forEach>
	      </div>
	      </div>
	      <div class="dropdown w-40">
            <a class="  dropdown-toggle text-sm font-medium rounded bg-gray-100 px-3 py-2 hover:text-indigo-500" href="javascript:void(0)"  data-toggle="dropdown">
        		<i class="fas fa-map-marker-alt"></i> <span id="navbardrop2">${location}</span>
      		</a>
		      <div class="dropdown-menu border-none shadow-md bg-white p-2">
		      <c:forEach items="${alllocations}" var="loc">
		        <a class="dropdown-item  hover:text-indigo-500 transition duration-300 focus:bg-gray-100 focus:text-indigo-500" href="javascript:void(0)" onclick="filterbyloc('${loc}');" >${loc}</a>
		        </c:forEach>
		      </div>
		  </div>
      
          </div>
        </div>
      </div>
      <div class="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">
        <div class="ml-3 relative">
         <c:if test = "${pageContext['request'].userPrincipal.principal.enabled != true}">
        <a style="margin-top:5px" class="bg-gray-900  text-white px-3 py-2 rounded-md text-sm font-medium" href="/login" ><i class="fas fa-user"></i>&nbsp;&nbsp;Login</a>
      </c:if>
      <c:if test = "${pageContext['request'].userPrincipal.principal.enabled == true}">
    <a  href="/Account" ><i class="fas fa-user  rounded-full  p-2 text-indigo-500 hover:text-white transition duration-500  hover:bg-indigo-500 "></i></a>
      <a  href="/logout"><i class=" rounded-full fas fa-power-off p-2 text-red-500 hover:text-white transition duration-500  hover:bg-red-500 "></i></a>
      </c:if>
        </div>
      </div>
    </div>
  </div>
  <div class="hidden transition  duration-500 " id="mobile-menu">
    <div class="px-2 pt-2 pb-3 space-y-1 ">
    <div class="dropdown">
				<input type="text" placeholder="Search.." class="outline-none w-full text-gray-700 bg-gray-100 rounded w-80 px-3 py-2  text-sm font-medium" id="mobmyInput"  autocomplete="off" onkeyup="mobfilterFunction()">
				    <div id="mobmyDropdown" class="dropdown-content shadow-md w-full bg-white ">
				     <c:forEach items="${movie}" var="temp">
				    <a href="javascript:void(0)" class="hover:bg-gray-100  transition duration-300 hover:text-indigo-500 hover:bg-opacity-50 px-5 py-2 mx-1 my-2  rounded-xl" onclick="gotomovie(${temp.movie_id})">${temp.movie_name}</a>
				    </c:forEach>
				  </div>
  			</div>
  		 <div class="dropdown w-40 my-3">
	 		<a class="w-full  dropdown-toggle text-sm font-medium rounded hover:text-indigo-500 bg-gray-100 px-3 py-2" href="javascript:void(0)"  data-toggle="dropdown">
	        <i class="fas fa-ad"></i> <span id="mobnavbardrop1">${current_lan}</span>
	      	</a>
	      <div class="dropdown-menu shadow-md border-none bg-white p-2">
	        <a   class="dropdown-item  hover:text-indigo-500 transition duration-300 focus:bg-gray-100 focus:text-indigo-500"  href="javascript:void(0)" onclick="mobfilterbylan('All languages')">All languages</a>
	      <c:forEach items="${lans}" var="lan">
	        <a  class="dropdown-item hover:text-indigo-500 transition duration-300 focus:bg-gray-100 focus:text-indigo-500"  href="javascript:void(0)" onclick="mobfilterbylan('${lan}')">${lan}</a>
	        </c:forEach>
	      </div>
	      </div>
	      <div class="dropdown w-40 my-3">
            <a class=" dropdown-toggle text-sm font-medium rounded hover:text-indigo-500 bg-gray-100 px-3 py-2" href="javascript:void(0)"  data-toggle="dropdown">
        		<i class="fas fa-map-marker-alt"></i> <span id="mobnavbardrop2">${location}</span>
      		</a>
		      <div class="dropdown-menu shadow-md border-none bg-white p-2">
		      <c:forEach items="${alllocations}" var="loc">
		        <a   class="dropdown-item  hover:text-indigo-500 transition duration-300  focus:bg-gray-100 focus:text-indigo-500"  href="javascript:void(0)" onclick="mobfilterbyloc('${loc}');" >${loc}</a>
		        </c:forEach>
		      </div>
		  </div>
       <c:if test = "${pageContext['request'].userPrincipal.principal.enabled != true}">
        <a style="margin-top:5px" class="bg-gray-900  text-white px-3 py-2 rounded-md text-sm font-medium" href="/login" ><i class="fas fa-user"></i>&nbsp;&nbsp;Login</a>
      </c:if>
      <c:if test = "${pageContext['request'].userPrincipal.principal.enabled == true}">
        <a class="bg-gray-100 px-3 py-2 font-medium text-sm rounded" href="/Account">   <i class="fas fa-user"></i> Account</a>
        <hr class="m-4">
        <a class="bg-gray-100 px-3 py-2 font-medium text-sm text-red-500 " href="/logout">Not ${username}? Logout</a>
      </c:if>
      
    </div>
  </div>
</nav>

     
<section class="text-gray-600 body-font bg-white">
  <div class="container mx-auto flex px-5 pb-6 pt-24 md:flex-row flex-col items-center">
    <div class="lg:flex-grow md:w-1/2 lg:pr-24 md:pr-16 flex flex-col md:items-start md:text-left mb-16 md:mb-0 items-center text-center">
      <h1 class="title-font sm:text-4xl text-3xl mb-4 font-medium text-gray-900">Book a Ticket
      </h1>
      <p class="mb-8 leading-relaxed">Cinema is a matter of what's in the frame and what's out. -Martin Scorsese

      </p>
      <div class="flex justify-center">
        <button onclick="window.location.href='/login'" class="font-medium inline-flex text-white bg-indigo-500 border-0 py-2 sm:px-2 lg:px-6 focus:outline-none hover:bg-indigo-600 rounded text-xs lg:text-lg">Get Started</button>
        <button class="font-medium ml-4 inline-flex text-gray-700 bg-gray-100 border-0 py-2 px-2 lg:px-6 focus:outline-none hover:bg-gray-200 rounded text-xs lg:text-lg">Launch your Theatre</button>
      </div>
    </div>
    <div class="lg:max-w-lg lg:w-full md:w-1/2 w-5/6 hidden lg:block">
      <img class="object-cover object-center rounded" alt="hero" src="https://media.istockphoto.com/vectors/movie-tickets-online-sale-tiny-people-buy-or-book-tickets-on-the-vector-id1266582056?k=20&m=1266582056&s=170667a&w=0&h=pwRkU7KMw2Piq-CgMvv9PMdxXSGB8CKyyixSJYgRw8A=">
    </div>
  </div>
</section>
<div id="matter">
<section   class="text-gray-600 body-font">
  <div class="container px-5 py-12 mx-auto">
    <div class="flex flex-wrap -m-12 lg:-m-4">
    <c:forEach items="${movie}" var="temp">
      <div class="xl:w-1/5 w-1/2 md:w-1/4 p-2 lg:p-4 ">
        <div class="bg-white xs:p-2 p-6 rounded-lg cursor-pointer shadow-md duration-500 hover:shadow-2xl"  onclick="gotomovie(${temp.movie_id})" >
          <img class="h-48 rounded w-full object-cover object-center mb-6" src="${temp.img }" alt="content">
          <h2 class="text-xs xl:text-sm text-gray-900 font-bold title-font mb-4">${temp.movie_name}</h2>
        </div>
      </div>
      </c:forEach>
    </div>
  </div>
</section>
</div>

 <c:if test = "${movie.size() == 0 }">
 <div class="lg:w-1/2  mx-auto px-3">
<div id="nomovies" class="jumbotron text-center font-bold " >
<h1>No Movies Available !!</h1>
</div>
</div>
</c:if>
<br>
<br>
<br>
<br>
<form id="movie_form" action="movie" method="POST">
<input name="movie_id" id="movie_id" style="display:none"/>
</form>
 <script>

      function filterFunction() {
        let input = document.getElementById("myInput");
        let filter = input.value.toUpperCase();
        let div = document.getElementById("myDropdown");
        let a = div.getElementsByTagName("a");
        for (let i = 0; i < a.length; i++) {
        if(filter.length>0){
        document.getElementById("myDropdown").style.display="block";
        }
        else{
        document.getElementById("myDropdown").style.display="none";
        
        }
          let txtValue = a[i].textContent || a[i].innerText;
          if (txtValue.toUpperCase().indexOf(filter) > -1) {
            a[i].style.display = "";
          } else {
            a[i].style.display = "none";
          }
        }
      }
      var lan_title=document.getElementById('navbardrop1');
      var loc_title=document.getElementById('navbardrop2');
      function filterbylan(lan){
    	  lan_title.innerHTML=lan;
    	  var xhttp = new XMLHttpRequest();
    	    xhttp.onreadystatechange = function() {
    	      if (this.readyState == 4 && this.status == 200) {
    	    	  document.getElementById('matter').innerHTML=this.responseText;
    	      }
    	    };
    	    xhttp.open("GET", "filter?language="+lan+"&location="+String(loc_title.innerHTML),true);
    	    xhttp.send();
          }
      function filterbyloc(loc){
    	  loc_title.innerHTML=loc;
    	  var xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
  	      if (this.readyState == 4 && this.status == 200) {
  	    	  document.getElementById('matter').innerHTML=this.responseText;
  	      }
  	    };
  	    xhttp.open("GET", "filter?language="+String(lan_title.innerHTML)+"&location="+loc,true);
  	    xhttp.send();
        }

      function mobfilterFunction() {
        let input, filter, ul, li, a, i;
        input = document.getElementById("mobmyInput");
        filter = input.value.toUpperCase();
        div = document.getElementById("mobmyDropdown");
        a = div.getElementsByTagName("a");
        for (i = 0; i < a.length; i++) {
        if(filter.length>0){
        document.getElementById("mobmyDropdown").style.display="block";
        }
        else{
        document.getElementById("mobmyDropdown").style.display="none";
        
        }
          txtValue = a[i].textContent || a[i].innerText;
          if (txtValue.toUpperCase().indexOf(filter) > -1) {
            a[i].style.display = "";
          } else {
            a[i].style.display = "none";
          }
        }
      }
      var moblan_title=document.getElementById('mobnavbardrop1');
      var mobloc_title=document.getElementById('mobnavbardrop2');
      function mobfilterbylan(lan){
    	  moblan_title.innerHTML=lan;
    	  var xhttp = new XMLHttpRequest();
    	    xhttp.onreadystatechange = function() {
    	      if (this.readyState == 4 && this.status == 200) {
    	    	  document.getElementById('matter').innerHTML=this.responseText;
    	      }
    	    };
    	    xhttp.open("GET", "filter?language="+lan+"&location="+String(mobloc_title.innerHTML),true);
    	    xhttp.send();
          }
      function mobfilterbyloc(loc){
    	  mobloc_title.innerHTML=loc;
    	  var xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
  	      if (this.readyState == 4 && this.status == 200) {
  	    	  document.getElementById('matter').innerHTML=this.responseText;
  	      }
  	    };
  	    xhttp.open("GET", "filter?language="+String(moblan_title.innerHTML)+"&location="+loc,true);
  	    xhttp.send();
        }
 
      </script>
<script>

function gotomovie(id){
	document.getElementById('movie_id').value=id;
	document.getElementById('movie_form').submit();
}
$(document).ready(function(){
	
		
	$(".introduce").click(function(){
	document.getElementById('movie_id').value=this.id;
	document.getElementById('movie_form').submit();
	});
});
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
</script>
<footer class="text-gray-600 body-font">
  <div class="container px-5 py-8 mx-auto flex items-center sm:flex-row flex-col">
    <a class="flex title-font font-medium items-center md:justify-start justify-center text-gray-900">
      <img src="/images/MyTickets.png" class="w-8 h-8 rounded-full mr-2" >
      <span class="ml-3 text-xl">MyTickets</span>
    </a>
    <span class="inline-flex sm:ml-auto sm:mt-0 mt-4 justify-center sm:justify-start">
      <a class="text-gray-500">
        <svg fill="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="w-5 h-5" viewBox="0 0 24 24">
          <path d="M18 2h-3a5 5 0 00-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 011-1h3z"></path>
        </svg>
      </a>
      <a class="ml-3 text-gray-500">
        <svg fill="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="w-5 h-5" viewBox="0 0 24 24">
          <path d="M23 3a10.9 10.9 0 01-3.14 1.53 4.48 4.48 0 00-7.86 3v1A10.66 10.66 0 013 4s-4 9 5 13a11.64 11.64 0 01-7 2c9 5 20 0 20-11.5a4.5 4.5 0 00-.08-.83A7.72 7.72 0 0023 3z"></path>
        </svg>
      </a>
      <a class="ml-3 text-gray-500">
        <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="w-5 h-5" viewBox="0 0 24 24">
          <rect width="20" height="20" x="2" y="2" rx="5" ry="5"></rect>
          <path d="M16 11.37A4 4 0 1112.63 8 4 4 0 0116 11.37zm1.5-4.87h.01"></path>
        </svg>
      </a>
      <a class="ml-3 text-gray-500">
        <svg fill="currentColor" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="0" class="w-5 h-5" viewBox="0 0 24 24">
          <path stroke="none" d="M16 8a6 6 0 016 6v7h-4v-7a2 2 0 00-2-2 2 2 0 00-2 2v7h-4v-7a6 6 0 016-6zM2 9h4v12H2z"></path>
          <circle cx="4" cy="4" r="2" stroke="none"></circle>
        </svg>
      </a>
    </span>
  </div>
</footer>
<br>
</body>
</html>
