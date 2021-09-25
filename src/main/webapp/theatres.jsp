<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<section class="text-gray-600 body-font">
  <div class="container px-5 py-24 mx-auto flex flex-wrap">
    <div class="flex flex-wrap -m-4">
    <c:forEach items="${theatres}" var="item">
      <div class="p-4 lg:w-1/2 md:w-full ">
        <div onclick="window.location.href='/theatre?location=${location}&tid=${item.tid}';" class="flex  rounded-lg bg-white p-8 sm:flex-row flex-col shadow-md cursor-pointer duration-500 hover:shadow-2xl">
          <div class="w-16 h-16 sm:mr-8 sm:mb-0 mb-4 inline-flex items-center justify-center rounded-full bg-indigo-100 text-indigo-500 flex-shrink-0">
            ${item.tid}
          </div>
          <div class="flex-grow">
            <h2 class="text-gray-900 text-lg title-font font-medium mb-3">${item.tname}</h2>
            <p class="leading-relaxed text-base">${item.seats} seats</p>
            <a class="mt-3 text-indigo-500 inline-flex items-center">Manage
              <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="w-4 h-4 ml-2" viewBox="0 0 24 24">
                <path d="M5 12h14M12 5l7 7-7 7"></path>
              </svg>
            </a>
          </div>
        </div>
      </div>
      </c:forEach>
    </div>
  </div>
</section>