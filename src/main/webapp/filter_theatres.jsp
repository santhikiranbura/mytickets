<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class=" text-left ">
<c:forEach items="${theatres}" var="theatre">
<div class="border-b-2 border-gray-200 py-10  m-2 lg:m-10 bg-white">
    <h6 class="font-semibold mb-6">${theatre.tname}</h6>
    <form action="/seatingplan" method="post">
    <input type="hidden" name="tid" value="${theatre.tid}" >
    <input type="hidden" name="date" value="${bookingdate}" >
    <input type="hidden" name="mid" value="${mid}" >
    <input type="hidden" id="${theatre.tid}" name="time" >
	<input type="hidden" name="plan" value="${theatre.seating_plan}">
    <c:forEach items="${times}" var="time">
		<c:if test = "${time.tid == theatre.tid}" >
			<c:forEach var="entry" items="${hm}">
			    <c:if test = "${entry.key == time.id}" >
			    	<c:if test = "${entry.value == 'success'}" >
			    		<button type="submit" class="inline-flex transition duration-300 mt-2  text-green-500 hover:text-white border-2 border-green-500 py-1 text-xs lg:text-lg px-2 lg:px-5 focus:outline-none hover:bg-green-600 rounded " onclick="document.getElementById('${theatre.tid}').value='${time.time}';">${time.time}</button>
			    	</c:if>
			    	<c:if test = "${entry.value == 'warning'}" >
			    		<button type="submit" class=" inline-flex transition duration-300 mt-2 text-yellow-500 hover:text-white border-2 border-yellow-500 py-2 text-xs lg:text-lg sm:px-2 lg:px-5 focus:outline-none hover:bg-yellow-600 rounded " onclick="document.getElementById('${theatre.tid}').value='${time.time}';">${time.time}</button>
			    	</c:if>
			    	<c:if test = "${entry.value == 'danger'}" >
			    		<button type="submit" class="inline-flex transition duration-300 mt-2 text-red-500 hover:text-white border-2 border-red-500 py-2 text-xs lg:text-lg sm:px-2 lg:px-5 focus:outline-none hover:bg-red-600 rounded " onclick="document.getElementById('${theatre.tid}').value='${time.time}';">${time.time}</button>
			    	</c:if>
			    	<c:if test = "${entry.value == 'default'}" >
			    		<button type="submit" class="btn mt-2 btn-outline-${entry.value} time_btn" disabled>${time.time}</button>
			    	</c:if>
			    </c:if>
			</c:forEach>
		</c:if>
    </c:forEach>
	<c:if test = "${times.size() == 0}">
	No shows
	</c:if> 
 </form>
 </div>
</c:forEach>
<c:if test = "${theatres.size() == 0 }">
<div class="p-14 text-center bg-white ">
<h1 class=" font-bold text-red-500">No Shows Available</h1>
</div>
</c:if>
</div>