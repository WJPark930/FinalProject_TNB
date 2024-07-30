<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/event/event.css?after">

    <style>
  
    </style>


<script type="text/javascript">
   function joinEvent(event_num, kind, amount) {
      if(kind === '금액 차감') {
         //alert('쿠폰 지급');
         location.href = "eventCoupon.ev?event_num="+event_num+"&kind="+kind+"&amount="+amount;
      } else if (kind === '비율 할인') {
         //alert('쿠폰 지급');
         location.href = "eventCoupon.ev?event_num="+event_num+"&kind="+kind+"&amount="+amount;
      } else if (kind === '포인트 적립') {
         //alert('포인트 적립');
         location.href = "eventPoint.ev?user_point="+amount;
      }
   }
   
   function gotoList() {
      location.href = "eventList.ev";
   }
   
   function goUpdate(event_num) {
      location.href = "eventUpdate.ev?event_num=" + event_num;
   }
   
   function goDelete(event_num) {
      location.href = "eventDelete.ev?event_num=" + event_num;
   }
</script>


<div class="container" id="content_container">

   <div class="text-center">
      <h2 >이벤트 상세보기 </h2>
   </div>
   
   <c:if test="${sessionScope.loginInfo.user_id == 1}">
   
      <div class="event-detail-container" style="border:0px;">
         <div class="event-image-view">
             <img src="<%= request.getContextPath()+"/resources/uploadEventImage/" %>${ event.event_image }">         
          </div>
          <div class="event-detail-content">
             <p class="event-title">${ event.event_title }</p>
             <p class="event-context">${ event.event_context }</p>
             <p class="event-date">
                 시작 날짜: 
                 <fmt:parseDate value="${event.event_start_date}" pattern="yyyy-MM-dd" var="eventStartDate" />
                 <fmt:formatDate value="${eventStartDate}" pattern="yyyy년 M월 d일" />
             </p>
             <p class="event-date">
                 종료 날짜: 
                 <fmt:parseDate value="${event.event_end_date}" pattern="yyyy-MM-dd" var="eventEndDate" />
                 <fmt:formatDate value="${eventEndDate}" pattern="yyyy년 M월 d일" />
             </p>
             <p class="event-discount">할인 종류: ${ event.event_discount_kind }</p>
             <p class="event-discount">할인 금액: ${ event.event_discount_amount }</p>
         </div>
          
          
         <div class="button-group2">
             <button class="btn btn-primary flex-grow-1 mx-1" type="button" onClick="goUpdate(${ event.event_num })">수정</button>
             <button class="btn btn-primary flex-grow-1 mx-1" type="button" onClick="goDelete(${ event.event_num })">삭제</button>
             <button class="btn btn-success flex-grow-1 mx-1" type="button" onClick="gotoList()">목록보기</button>
         </div>
      </div>
   
   </c:if>
   
   
   
   <c:if test="${sessionScope.loginInfo.user_id != 1}">
   
      <div class="event-detail-container">
         <div class="event-image-view">
             <img src="<%= request.getContextPath()+"/resources/uploadEventImage/" %>${ event.event_image }">
          </div>
          <div class="event-detail-content">
             <p class="event-title">${ event.event_title }</p>
             <p class="event-context">${ event.event_context }</p>
             <p class="event-date">
                 시작 날짜: 
                 <fmt:parseDate value="${event.event_start_date}" pattern="yyyy-MM-dd" var="eventStartDate" />
                 <fmt:formatDate value="${eventStartDate}" pattern="yyyy년 M월 d일" />
             </p>
             <p class="event-date">
                 종료 날짜: 
                 <fmt:parseDate value="${event.event_end_date}" pattern="yyyy-MM-dd" var="eventEndDate" />
                 <fmt:formatDate value="${eventEndDate}" pattern="yyyy년 M월 d일" />
             </p>
             <p class="event-discount">할인 종류: ${ event.event_discount_kind }</p>
             <p class="event-discount">할인 금액: ${ event.event_discount_amount }</p>
         </div>          
         <div class="button-group2">
             <button type="button" class="btn btn-outline-success" onClick="joinEvent(${ event.event_num },'${ event.event_discount_kind }', '${ event.event_discount_amount }' )">이벤트 참여하기</button>          
              <button class="btn btn-success" type="button" onClick= "gotoList()">목록보기</button>
         </div>
      </div>

   
   </c:if>
   
</div>
<%@include file="/resources/include/footer.jsp" %>