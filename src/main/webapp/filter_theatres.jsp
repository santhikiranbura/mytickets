<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class=" text-left movie-theater ">
<c:forEach items="${theatres}" var="theatre">
<div class="shadow-xl my-4 p-4 bg-white">
    <h6 class="font-semibold mb-2">${theatre.tname}</h6>
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
			    	<c:if test = "${entry.value != 'default'}" >
			    		<button type="submit" class="btn btn-outline-${entry.value} time_btn" onclick="document.getElementById('${theatre.tid}').value='${time.time}';">${time.time}</button>
			    	</c:if>
			    	<c:if test = "${entry.value == 'default'}" >
			    		<button type="submit" class="btn btn-outline-${entry.value} time_btn" disabled>${time.time}</button>
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
<div class="jumbotron text-center bg-white shadow-xl">
<h1 class=" font-bold text-red-500">No Shows Available</h1>
</div>
</c:if>
</div>