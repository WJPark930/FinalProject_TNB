<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/event/event.css?after">

<div class="container" id="content_container">
	
	<div class="text-center">
		<h2 >이벤트 목록보기</h2>
	</div>
	
	<c:choose>
	    <c:when test="${ not empty eventList }">
	        <div class="event-list row" id="listForPadding">
	            <c:forEach var="event" items="${ eventList }">
	                <a href="eventDetail.ev?event_num=${ event.event_num }" class="col-3 eventList">
	                    <div class="event-container">
	                        <div class="eventListImage"><img src="<%= request.getContextPath()+"/resources/uploadEventImage/" %>${ event.event_image }" width="100" height="70"></div>	                        
	                        <p class="event_title">${ event.event_title }</p>
	                        <fmt:parseDate value="${event.event_end_date}" pattern="yyyy-MM-dd" var="eventEndDate" />
	                        <p class="event_end_date">종료일 : <fmt:formatDate value="${eventEndDate}" pattern="yyyy년 M월 d일" /></p>
	                        <br>
	                    </div>
	                </a>
	            </c:forEach>
	        </div>
	    </c:when>
	    <c:otherwise>
	        <table border="1">
	            <tr>
	                <td>진행중인 이벤트가 없습니다</td>
	            </tr>
	        </table>
	    </c:otherwise>
	</c:choose>
</div>
<%@include file="/resources/include/footer.jsp" %>