<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <div class=" bg-white  p-4 mx-auto lg:w-1/2 mb-10 shadow-xl">
        <form action="/updateprofile" class="form-group" method="post">
          <label for="full_name"><b>Name</b></label>
          <input type="text" class="form-control" name="full_name" value="${user.full_name}">
          <label for="location"><b>Location</b></label>
          <select class="form-control" name="location" value="${user.location}">
          <option value="${user.location}">${user.location}</option>
            <c:forEach items="${locations}" var="temp">
            <c:if test="${user.location !=temp}">
            <option value="${temp}">${temp}</option>
            </c:if>
            </c:forEach>
          </select>
          <label for="Email"><b>Email</b></label>
          <input type="text" class="form-control" name="email" value="${user.email}" readonly>
          <center><button type="submit" name="button" class="flex ml-auto text-white text-sm lg:text-md bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded mt-4 mx-auto" >Update</button></center>
        </form>
      </div>