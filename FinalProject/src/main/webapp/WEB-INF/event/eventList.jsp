<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>  
eventList.jsp<br>

<style>
    .event-list {
        display: flex;
        flex-wrap: wrap;
        gap: 16px;
    }

    .event-container {
        flex: 1 1 calc(33.333% - 16px); 
        box-sizing: border-box;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 8px;
        text-align: center;
    }

    .event-container img {
        max-width: 100%;
        height: auto;
        border-radius: 8px;
    }
</style>



<a href = "eventInsert.ev"><input type = button value = "이벤트 추가하기"></a>

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