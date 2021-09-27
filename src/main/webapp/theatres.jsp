<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<section class="text-gray-600 body-font">
  <div class="container px-5 py-24 mx-auto">
    <div class="flex flex-wrap -m-4">
        <c:forEach items="${theatres}" var="item">
      <div class="xl:w-1/3 md:w-1/2 p-4" >
        <div class=" p-6 rounded-lg cursor-pointer shadow-md bg-white hover:shadow-2xl transition duration-500" onclick="window.location.href='/theatre?location=${location}&tid=${item.tid}';">
          <div class="w-10 h-10 inline-flex items-center justify-center rounded-full bg-indigo-100 text-indigo-500 mb-4">
             ${item.tid}
          </div>
          <h2 class="text-lg text-gray-900 font-medium title-font mb-2">${item.tname}</h2>
          <p class="leading-relaxed text-base">${item.seats} seats</p>
        </div>
      </div>
      </c:forEach>
    </div>
   </div>
</section>
