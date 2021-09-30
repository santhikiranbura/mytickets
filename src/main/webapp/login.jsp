<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700&display=swap" rel="stylesheet"> 
        <link href="https://fonts.googleapis.com/css?family=Lato:400,700&display=swap" rel="stylesheet"> 
    <link rel="stylesheet" type="text/css" href="css/signup.css" />
     <link
      href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css"
      rel="stylesheet"
    />
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
  <body class="min-h-screen bg-gray-100 text-gray-900 flex justify-center">
    <div
      class="max-w-screen-xl m-0 sm:m-20 bg-white shadow sm:rounded-lg flex justify-center flex-1"
    >
      <div class="lg:w-1/2 xl:w-5/12 p-6 sm:p-12">
       
        <div class="mt-12 flex flex-col items-center">
          <h1 class="text-2xl xl:text-3xl font-extrabold">
            Login
          </h1>
          <c:forEach items="${messages}" var="temp">
          	<h3 style="color:orange">${temp}</h3>
          </c:forEach>
          <form  action="/login"  method="post">
          <div class="w-full flex-1 mt-8">
            <div class="mx-auto max-w-xs">
             
              <input
                class="w-full px-8 py-4 rounded-lg font-medium bg-gray-100 border border-gray-200 placeholder-gray-500 text-sm focus:outline-none focus:border-gray-400 focus:bg-white"
                type="email"
                name="email"
                placeholder="Email"
              required/>
              <input
                class="w-full px-8 py-4 rounded-lg font-medium bg-gray-100 border border-gray-200 placeholder-gray-500 text-sm focus:outline-none focus:border-gray-400 focus:bg-white mt-5"
                type="password"
                name="password"
                placeholder="Password"
              required/>
              <button
                class="mt-5 tracking-wide font-semibold bg-indigo-500 text-gray-100 w-full py-4 rounded-lg hover:bg-indigo-700 transition-all duration-300 ease-in-out flex items-center justify-center focus:shadow-outline focus:outline-none"
              type="submit"
              >
              
                <span class="ml-3">
                  Submit
                </span>
              </button>
              </form>
				
              <div class="text-center mt-3">
              <b class="text-xs  lg:text-sm">Don't have an account? <a href="/register" style="color:slateblue;text-decoration:underline">Register</a> now!</b>
            </div>
            </div>
          </div>
        </div>
      </div>
      <div class="flex-1 bg-indigo-100 text-center hidden lg:flex">
        <div
          class="m-12 xl:m-16 w-full bg-contain bg-center bg-no-repeat"
          style="background-image: url('https://storage.googleapis.com/devitary-image-host.appspot.com/15848031292911696601-undraw_designer_life_w96d.svg');"
        ></div>
      </div>
    </div>
  </body>
</html>
