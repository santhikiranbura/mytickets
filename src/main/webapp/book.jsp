<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Booking Confirmation</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://kit.fontawesome.com/1a63ab4674.js" crossorigin="anonymous"></script>
        <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">
            <script
      src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.js"
      defer
    ></script>
  <style>
  ::-webkit-scrollbar {
      width: 5px;
    }
    ::-webkit-scrollbar-track {
      box-shadow: inset 0 0 5px white;
    }
    ::-webkit-scrollbar-thumb {
      background-color:#6366F1;
    }
    ::-webkit-scrollbar-thumb:hover {
        background-color:#6366F1;
    }
  body {
    background: #fbfbfd;
}
 
  </style>
  </head>
  <body class="bg-white">
<section class="text-gray-600 body-font overflow-hidden">
  <div class="container px-5 py-12 mx-auto">
    <div class="lg:w-4/5 mx-auto flex flex-wrap ">
      <img alt="ecommerce" class="mx-auto h-72 w-54  rounded" src="${image}">
      <div class="lg:w-1/2 w-full lg:pl-10 lg:py-6 mt-6 lg:mt-0">
        <h2 class="text-sm title-font text-gray-500 tracking-widest">${tname}</h2>
        <h1 class="text-gray-900 text-3xl title-font font-medium mb-1">${movie_name}</h1>
        <div class="flex mb-4">
          <span class="flex items-center">
            <span class="text-gray-600 ml-3">${bookingdate}</span>
          </span>
          <span class="flex ml-3 pl-3 py-2 border-l-2 border-gray-200 space-x-2s">
            ${time}
          </span>
        </div>
        <p class="leading-relaxed font-bold">${ticket}</p>
        <br>	
        <div class="flex">
          <span class="title-font font-medium text-2xl text-gray-900">Rs. ${amount}.00</span>
        </div>
        <form action="/success"  method="post">
	<input type="hidden" name="tid" value="${tid}" >
    <input type="hidden" name="date" value="${bookingdate}" >
    <input type="hidden" name="mid" value="${mid}" >
    <input type="hidden" name="time" value="${time}" >
    <input type="hidden" name="seq" value="${ticket}" >
   <input type="hidden" name="amount" value="${amount}" >
		<input class="form-control" id="email" name="email" value="${email}" placeholder="Enter Email" hidden />
          <button type="submit" class="flex text-white bg-indigo-500 border-0 mt-4 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded" >Proceed</button>
          </form>
      </div>
    </div>
  </div>
</section>
	
  </body>
  </html>