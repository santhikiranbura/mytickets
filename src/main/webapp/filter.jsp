<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<section   class="text-gray-600 body-font">
  <div class="container px-5 py-24 mx-auto">
    <div class="flex flex-wrap -m-4">
    <c:forEach items="${movie_list}" var="temp">
      <div class="xl:w-1/5 w-1/2 md:w-1/4 p-4 ">
        <div class="bg-white p-6 rounded-lg cursor-pointer shadow-md duration-500 hover:shadow-2xl"  onclick="gotomovie(${temp.movie_id})" >
          <img class="h-54 lg:h-80 rounded w-full object-cover object-center mb-6" src="${temp.img }" alt="content">
          <h2 class="text-md text-gray-900 font-medium title-font mb-4">${temp.movie_name}</h2>
        </div>
      </div>
      </c:forEach>
    </div>
  </div>
</section>
<c:if test = "${movie_list.size() == 0 }">
 <div class="lg:w-1/2  mx-auto px-3">
<div id="nomovies" class="jumbotron text-center font-bold " >
<h1>No Movies Available !!</h1>
</div>
</div>
</c:if>