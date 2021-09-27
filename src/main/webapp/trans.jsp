
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<section class="text-gray-600 body-font">
  <div class="container px-5 py-24 mx-auto">
    <div class="flex flex-wrap -mx-4 -my-8">
    <c:forEach items="${bookings}" var="book">
      <div class="py-8 px-4 lg:w-1/3 bg-white m-2 rounded shadow-xl">
        <div class="h-full flex items-start">
          <div class="w-24 flex-shrink-0 flex flex-col text-center leading-none">
            <span class="text-gray-500 pb-2 mb-2 border-b-2 border-gray-200">${book.time}</span>
            <span class="font-medium text-lg text-gray-800 title-font leading-none">Rs. ${book.amount}</span>
          </div>
          <div class="flex-grow pl-6">
            <h2 class="tracking-widest text-xs title-font font-medium text-indigo-500 mb-1">
            		<c:forEach items="${theatres}" var="entry">
			<c:if test = "${entry.key == book.trans_id}" >
			${entry.value}
			</c:if>
		</c:forEach>
		</h2>
            <h1 class="title-font text-xl font-medium text-gray-900 mb-3">
            		<c:forEach items="${movies}" var="entry">
			<c:if test = "${entry.key == book.trans_id}" >
			${entry.value}
			</c:if>
		</c:forEach>
		</h1>
            <p class="leading-relaxed mb-5">
            <c:forEach items="${tickets}" var="entry">
			<c:if test = "${entry.key == book.trans_id}" >
			<h2 class="font-bold">${entry.value}</h2>
			</c:if>
		</c:forEach>
		<br>
			Booked on ${book.date}
		</p>
            <a class="inline-flex items-center">
              <span class="flex-grow flex flex-col pl-3">
                <span class="title-font font-medium text-gray-900">${book.trans_id}</span>
              </span>
            </a>
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
