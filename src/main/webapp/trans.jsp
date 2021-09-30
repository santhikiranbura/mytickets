
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <section class="text-gray-600 body-font overflow-hidden">
  <div class="container px-3 py-12 mx-auto">
    <div class="lg:w-4/5 mx-auto flex flex-wrap">
          <c:forEach items="${bookings}" var="book">
          <div class="lg:w-1/2 w-full  lg:pr-10  mb-6 mt-6 ">
          <div class="bg-white p-10 shadow-xl">
        <h2 class="text-sm title-font text-indigo-500 tracking-widest">
        <c:forEach items="${theatres}" var="entry">
			<c:if test = "${entry.key == book.trans_id}" >
			${entry.value}
			</c:if>
		</c:forEach>
        </h2>
        <h1 class="text-gray-900 text-xl lg:text-3xl title-font font-medium mb-4">
            <c:forEach items="${movies}" var="entry">
			<c:if test = "${entry.key == book.trans_id}" >
			${entry.value}
			</c:if>
		</c:forEach></h1>
        <p class="leading-relaxed mb-4 ">
        <c:forEach items="${tickets}" var="entry">
			<c:if test = "${entry.key == book.trans_id}" >
			<h2 class="font-bold text-indigo-500">${entry.value}</h2>
			</c:if>
		</c:forEach>
		</p>
        <div class="flex py-2">
          <span class="text-gray-500">Show Time</span>
          <span class="ml-auto text-gray-900">${book.time}</span>
        </div>
        <div class="flex border-t border-gray-200 py-2">
          <span class="text-gray-500">Booking date</span>
          <span class="ml-auto text-gray-900">${book.date}</span>
        </div>
        <div class="flex mt-4">
          <span class="title-font font-medium text-xl lg:text-2xl text-gray-900">Rs. ${book.amount}</span>
          <button class="flex ml-auto text-white text-sm lg:text-md bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded" onclick='window.location.href="/success?id=${book.trans_id}"'>Get Receipt</button>
        </div>
      </div>
      </div>
            </c:forEach>
       </div>
  </div>
</section>


 <c:if test = "${bookings.size() == 0 }">
<div  class="jumbotron text-center font-bold w-1/2 mx-auto" >
<h1>No Bookings Made !!</h1>
</div>
</c:if>
