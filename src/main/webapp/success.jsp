<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
      <title>My Tickets | Success</title>
        <link rel="icon" href="/images/favicon.ico" type="image/gif" >
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/1a63ab4674.js" crossorigin="anonymous"></script>
  <link href='https://fonts.googleapis.com/css?family=Aldrich' rel='stylesheet'>
    <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">
            <script
      src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.js"
      defer
    ></script>
  <style>
  ::-webkit-scrollbar {
      width: 10px;
    }
    ::-webkit-scrollbar-track {
      box-shadow: inset 0 0 5px white;
    }
    ::-webkit-scrollbar-thumb {
      background-color:slateblue;
    }
    ::-webkit-scrollbar-thumb:hover {
        background-color:slateblue;
    }
  body {
    background: #fbfbfd;
}
  .

.success{
color:mediumseagreen;
text-align:center;
} 
.check{
padding:12px;
margin:5px;
font-size:22px;
border-radius:50%;
background-color:mediumseagreen;
box-shadow:0px 3px 6px rgba(0,0,0,0.3);
color:white;
}

  </style>
  </head>
  <body class="bg-white">
  <section class=" body-font overflow-hidden">
  <div class="container px-5 mt-12  mb-12  py-12 mx-auto">
  <div class="text-green-500 text-md lg:text-3xl  text-center mb-7">
    <i class="fas fa-check text-white rounded-full p-2 bg-green-500"></i>&nbsp;Successfully Booked
  </div>
    <div class="lg:w-4/5 mx-auto flex flex-wrap ">
      <img alt="ecommerce" class="mx-auto h-72 w-54  rounded" src="${image}">
      <div class="lg:w-1/2 w-full lg:pl-10 lg:py-6 mt-6 lg:mt-0">
        <h2 class="text-sm title-font text-gray-500 tracking-widest">${tname}</h2>
        <h1 class="text-gray-900 text-3xl title-font font-medium mb-1">${movie_name}</h1>
        <div class="flex mb-4">
          <span class="flex items-center">
            <span class="text-indigo-600 ml-3">${b.date}</span>
          </span>
          <span class="flex ml-3 pl-3 py-2 border-l-2 border-gray-200 space-x-2s text-indigo-500">
            ${b.time}
          </span>
        </div>
        <p class="leading-relaxed font-bold">${seq}</p>
        <br>	
        <div class="flex">
          <span class="title-font font-medium text-2xl text-gray-900">Rs. ${b.amount}.00</span>
        </div>
        <p class="text-indigo-500 mt-4">${b.trans_id}</p>
      </div>
    </div>
  </div>
</section>
<script>
window.history.pushState({}, null, '/success?id='+'${b.trans_id}');
</script>
  </body>
  </html>