<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>  
eventList.jsp<br>


<%@ include file="../../resources/include/header.jsp" %> 



<c:if test="${sessionScope.loginInfo.user_id == 1}">
	<a href = "eventInsert.ev"><input type = button value = "이벤트 추가하기"></a>
</c:if>

<div class="event-list">
    <c:forEach var="event" items="${ eventList }">
        <a href="eventDetail.ev?event_num=${ event.event_num }">
            <div class="event-container">
            
                <%
    			System.out.println(request.getContextPath());
   				 %>
                <img src="<%= request.getContextPath()+"/resources/uploadEventImage/" %>${ event.event_image }" width="100" height="70">
                <br>
                제목 : ${ event.event_title }
                <br>
                내용 : ${ event.event_context }
                <br>
                이벤트 종료일 : ${ event.event_end_date }
                <br>
            </div>
        </a>
    </c:forEach>
</div>

<%@ include file="../../resources/include/footer.jsp" %> 