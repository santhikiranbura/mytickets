<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html  lang="en">
<head>
  <title>My Tickets</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
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
<nav class="bg-gray-800">
  <div class="max-w-7xl mx-auto px-2 sm:px-6 lg:px-8">
    <div class="relative flex items-center justify-between h-20">
      <div class="absolute inset-y-0 left-0 flex items-center sm:hidden">
        <!-- Mobile menu button-->
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
        <div class="flex-shrink-0 flex text-white font-extrabold items-center cursor-pointer"  onclick="window.location.href='/'">
    			<img src="/images/MyTickets.png" class="w-8 h-8 rounded-full mr-2" >MyTickets
        </div>
        <div class="hidden sm:block sm:ml-6">
          <div class="flex space-x-8">
             <div class="dropdown">
				<input type="text" placeholder="Search.." class=" outline-none text-gray-300 bg-gray-700 w-80 hover:text-white px-3 py-2  text-sm font-medium" id="myInput"  autocomplete="off" onkeyup="filterFunction()">
				    <div id="myDropdown" class="dropdown-content shadow-2xl w-80 bg-gray-700 text-white">
				     <c:forEach items="${movie}" var="temp">
				    <a href="javascript:void(0)" onclick="gotomovie(${temp.movie_id})">${temp.movie_name}</a>
				    </c:forEach>
				  </div>
  			</div>
  		 <div class="dropdown w-40">
	 		<a class="text-white dropdown-toggle" href="javascript:void(0)"  data-toggle="dropdown">
	        <i class="fas fa-ad"></i> <span id="navbardrop1">${current_lan}</span>
	      	</a>
	      <div class="dropdown-menu shadow-2xl bg-gray-700 p-2">
	        <a class="dropdown-item" href="javascript:void(0)" onclick="filterbylan('All languages')">All languages</a>
	      <c:forEach items="${lans}" var="lan">
	        <a class="dropdown-item" href="javascript:void(0)" onclick="filterbylan('${lan}')">${lan}</a>
	        </c:forEach>
	      </div>
	      </div>
	      <div class="dropdown w-40">
            <a class=" text-white dropdown-toggle" href="javascript:void(0)"  data-toggle="dropdown">
        		<i class="fas fa-map-marker-alt"></i> <span id="navbardrop2">${location}</span>
      		</a>
		      <div class="dropdown-menu shadow-2xl bg-gray-700 p-2">
		      <c:forEach items="${alllocations}" var="loc">
		        <a class="dropdown-item" href="javascript:void(0)" onclick="filterbyloc('${loc}');" >${loc}</a>
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
         <div class=" dropdown">
      <a class="nav-link text-white dropdown-toggle" href="javascript:void(0)" id="navbardrop3" data-toggle="dropdown">
        <i class="fas fa-user"></i> 
      </a>
      <div class="dropdown-menu shadow-2xl bg-gray-700 p-2">
        <a class="dropdown-item" href="/Account">Account</a>
        <hr class="border-white my-2">
        <a class="dropdown-item  text-red-500 " href="/logout">Logout</a>
      </div>
    </div>
      </c:if>
        </div>
      </div>
    </div>
  </div>
  <div class="hidden transition duration-500 ease-in-out" id="mobile-menu">
    <div class="px-2 pt-2 pb-3 space-y-1">
    <div class="dropdown">
				<input type="text" placeholder="Search.." class=" outline-none text-gray-300 bg-gray-700 w-full hover:text-white px-3 py-2  text-sm font-medium" id="mobmyInput"  autocomplete="off" onkeyup="mobfilterFunction()">
				    <div id="mobmyDropdown" class="dropdown-content shadow-2xl w-full bg-gray-700 text-white">
				     <c:forEach items="${movie}" var="temp">
				    <a href="javascript:void(0)" onclick="gotomovie(${temp.movie_id})">${temp.movie_name}</a>
				    </c:forEach>
				  </div>
  			</div>
  		 <div class="dropdown w-40 my-3">
	 		<a class="text-white dropdown-toggle" href="javascript:void(0)"  data-toggle="dropdown">
	        <i class="fas fa-ad"></i> <span id="mobnavbardrop1">${current_lan}</span>
	      	</a>
	      <div class="dropdown-menu shadow-2xl bg-gray-700 p-2">
	        <a class="dropdown-item" href="javascript:void(0)" onclick="mobfilterbylan('All languages')">All languages</a>
	      <c:forEach items="${lans}" var="lan">
	        <a class="dropdown-item" href="javascript:void(0)" onclick="mobfilterbylan('${lan}')">${lan}</a>
	        </c:forEach>
	      </div>
	      </div>
	      <div class="dropdown w-40 my-3">
            <a class=" text-white dropdown-toggle" href="javascript:void(0)"  data-toggle="dropdown">
        		<i class="fas fa-map-marker-alt"></i> <span id="mobnavbardrop2">${location}</span>
      		</a>
		      <div class="dropdown-menu shadow-2xl bg-gray-700 p-2">
		      <c:forEach items="${alllocations}" var="loc">
		        <a class="dropdown-item" href="javascript:void(0)" onclick="mobfilterbyloc('${loc}');" >${loc}</a>
		        </c:forEach>
		      </div>
		  </div>
       <c:if test = "${pageContext['request'].userPrincipal.principal.enabled != true}">
        <a style="margin-top:5px" class="bg-gray-900  text-white px-3 py-2 rounded-md text-sm font-medium" href="/login" ><i class="fas fa-user"></i>&nbsp;&nbsp;Login</a>
      </c:if>
      <c:if test = "${pageContext['request'].userPrincipal.principal.enabled == true}">
         <div class=" dropdown my-3">
      <a class=" text-white dropdown-toggle" href="javascript:void(0)" id="mobnavbardrop3" data-toggle="dropdown">
        <i class="fas fa-user"></i> ${username}
      </a>
      <div class="dropdown-menu shadow-2xl bg-gray-700 p-2">
        <a class="dropdown-item" href="/Account">Account</a>
        <hr class="border-white my-2">
        <a class="dropdown-item  text-red-500 " href="/logout">Logout</a>
      </div>
    </div>
      </c:if>
      
    </div>
  </div>
</nav>
<!-- >nav class="navbar navbar-expand-md  navbar-dark" >
  <a class="navbar-brand" href="/">
  <h2>My Tickets</h2></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
    <div class="dropdown">
<input type="text" placeholder="Search.." class="form-control" id="myInput" style="width:53vw;" autocomplete="off" onkeyup="filterFunction()">
    <div id="myDropdown" class="dropdown-content">
     <c:forEach items="${movie}" var="temp">
    <a href="javascript:void(0)" onclick="gotomovie(${temp.movie_id})">${temp.movie_name}</a>
    </c:forEach>
  </div>
  </div>
 
  <li class="nav-item dropdown">
      <a class="nav-link text-white dropdown-toggle" href="javascript:void(0)"  data-toggle="dropdown">
        <i class="fas fa-ad"></i> <span id="navbardrop1">${current_lan}</span>
      </a>
      <div class="dropdown-menu ">
              <a class="dropdown-item" href="javascript:void(0)" onclick="filterbylan('All languages')">All languages</a>
      <c:forEach items="${lans}" var="lan">
        <a class="dropdown-item" href="javascript:void(0)" onclick="filterbylan('${lan}')">${lan}</a>
        </c:forEach>
      </div>
    </li>
    <li class="nav-item dropdown">
      <a class="nav-link text-white dropdown-toggle" href="javascript:void(0)"  data-toggle="dropdown">
        <i class="fas fa-map-marker-alt"></i> <span id="navbardrop2">${location}</span>
      </a>
      <div class="dropdown-menu ">
      <c:forEach items="${alllocations}" var="loc">
        <a class="dropdown-item" href="javascript:void(0)" onclick="filterbyloc('${loc}');" >${loc}</a>
        </c:forEach>
      </div>

    </li>
    <c:if test = "${pageContext['request'].userPrincipal.principal.enabled != true}">
    <li class="nav-item">
        <a class="nav-link text-white " href="/login" ><i class="fas fa-user"></i>&nbsp;&nbsp;Login</a>
      </li>
      </c:if>
      <c:if test = "${pageContext['request'].userPrincipal.principal.enabled == true}">
         <li class="nav-item dropdown">
      <a class="nav-link text-white dropdown-toggle" href="javascript:void(0)" id="navbardrop2" data-toggle="dropdown">
        <i class="fas fa-user"></i> ${username}
      </a>
      <div class="dropdown-menu ">
        <a class="dropdown-item" href="/Account">Account</a>
        <a class="dropdown-item" href="/logout">Logout</a>
      </div>
    </li>
      </c:if>
    </ul>
  </div>
</nav-->
      <script>

      function filterFunction() {
        let input, filter, ul, li, a, i;
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        div = document.getElementById("myDropdown");
        a = div.getElementsByTagName("a");
        for (i = 0; i < a.length; i++) {
        if(filter.length>0){
        document.getElementById("myDropdown").style.display="block";
        }
        else{
        document.getElementById("myDropdown").style.display="none";
        
        }
          txtValue = a[i].textContent || a[i].innerText;
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
          document.getElementById('nomovies').style.display="none";
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
<section class="text-gray-600 body-font ">
  <div class="container px-5 py-24 mx-auto">
    <div class="flex flex-wrap -m-4">
      <div class="p-4 md:w-1/3">
        <div id="1" class="h-full introduce bg-white  duration-300 shadow-md cursor-pointer hover:shadow-2xl rounded-lg overflow-hidden">
          <img class="lg:h-48 md:h-36 w-full object-cover object-center" src="/images/001.jpg" alt="blog">
          <div class="p-6">
            <h2 class="tracking-widest text-xs title-font font-medium text-gray-400 mb-1">English</h2>
            <h1 class="title-font text-lg font-medium text-gray-900 mb-3 ">Man of Steel</h1>
          </div>
        </div>
        </div>
        <div class="p-4 md:w-1/3">
        <div id="2" class="h-full introduce duration-300 bg-white shadow-md cursor-pointer hover:shadow-2xl rounded-lg overflow-hidden">
          <img class="lg:h-48 md:h-36 w-full object-cover object-center" src="/images/002.jpg" alt="blog">
          <div class="p-6">
            <h2 class="tracking-widest text-xs title-font font-medium text-gray-400 mb-1">English</h2>
            <h1 class="title-font text-lg font-medium text-gray-900 mb-3">Batman vs Superman</h1>
          </div>
        </div>
        </div>
        <div class="p-4 md:w-1/3">
        <div id="3" class="h-full introduce duration-300  bg-white shadow-md cursor-pointer hover:shadow-2xl rounded-lg overflow-hidden">
          <img class="lg:h-48 md:h-36 w-full object-cover object-center" src="/images/003.jpg" alt="blog">
          <div class="p-6">
            <h2 class="tracking-widest text-xs title-font font-medium text-gray-400 mb-1">English</h2>
            <h1 class="title-font text-lg font-medium text-gray-900 mb-3">Jurassic world</h1>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<div id="matter">
<section   class="text-gray-600 body-font">
  <div class="container px-5 py-12 mx-auto">
    <div class="flex flex-wrap -m-4">
    <c:forEach items="${movie}" var="temp">
      <div class="xl:w-1/4 md:w-1/2 p-4 ">
        <div class="bg-white p-6 rounded-lg cursor-pointer shadow-md duration-500 hover:shadow-2xl"  onclick="gotomovie(${temp.movie_id})" >
          <img class="h-84 rounded w-full object-cover object-center mb-6" src="${temp.img }" alt="content">
          <h2 class="text-md text-gray-900 font-bold title-font mb-4">${temp.movie_name}</h2>
        </div>
      </div>
      </c:forEach>
    </div>
  </div>
</section>
</div>

 <c:if test = "${movie.size() == 0 }">
<div id="nomovies" class="jumbotron text-center font-bold w-1/2 mx-auto" >
<h1>No Movies Available !!</h1>
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
