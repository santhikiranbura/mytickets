<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html  lang="en">
<head>
  <title>Dashboard</title>
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
<body class="bg-gray-100">
<nav class="bg-gray-800">
  <div class="max-w-7xl mx-auto px-2 sm:px-6 lg:px-8">
    <div class="relative flex items-center justify-between h-16">
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
        <div class="flex-shrink-0 flex text-white font-extrabold items-center">
    			MyTickets
        </div>
        <div class="hidden sm:block sm:ml-6">
          <div class="flex space-x-4">
            <a href="/admin" class="bg-gray-900 text-white px-3 py-2 rounded-md text-sm font-medium" aria-current="page">Dashboard</a>
            <a href="/managetheatres" class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Manage Theatres</a>
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
      <!-- Current: "bg-gray-900 text-white", Default: "text-gray-300 hover:bg-gray-700 hover:text-white" -->
      <a href="/admin" class="bg-gray-900 text-white block px-3 py-2 rounded-md text-base font-medium" aria-current="page">Dashboard</a>
      <a href="/managetheatres" class="text-gray-300 hover:bg-gray-700 hover:text-white block px-3 py-2 rounded-md text-base font-medium">Manage Theatres</a>
      <a href="/" class="text-gray-300 hover:bg-gray-700 hover:text-white block px-3 py-2 rounded-md text-base font-medium">Movies</a>
    </div>
  </div>
</nav>
 <a href="/addmovie">
 <button type="submit" class=" float-right mr-6 mt-6 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
             <i class="fas fa-plus" style="margin-right:7px;margin-top:4.5px;font-size:12px"></i> Add Movie
            </button> </a>
<br>
<br>
<section   class="text-gray-600 body-font">
  <div class="container px-5 py-24 mx-auto">
    <div class="flex flex-wrap -m-4">
    <c:forEach items="${movies}" var="temp">
      <div class="xl:w-1/4 md:w-1/2 p-4 ">
        <div class="bg-white p-6 rounded-lg cursor-pointer shadow-md duration-500 hover:shadow-2xl"  onclick="window.location.href='/editmovie?mid=${temp.movie_id}'" >
          <img class="h-84 rounded w-full object-cover object-center mb-6" src="${temp.img }" alt="content">
          <h2 class="text-md text-gray-900 font-bold title-font mb-4">${temp.movie_name}</h2>
        </div>
      </div>
      </c:forEach>
    </div>
  </div>
</section>


 <c:if test = "${movies.size() == 0 }">
<div class="jumbotron text-center font-bold w-1/2 mx-auto" >
<h1>No Movies Available !!</h1>
</div>
</c:if>
<script>
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


</body>
</html>
