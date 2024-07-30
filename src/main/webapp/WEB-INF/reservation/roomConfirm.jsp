<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@include file="/resources/include/header.jsp" %> 
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %> 	 

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/reservation/reservation.css?after">

<%
    reservation.model.RoomReservationBean rrb = (reservation.model.RoomReservationBean) request.getAttribute("rrb");
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat displayFormat = new SimpleDateFormat("M/d(E)", java.util.Locale.KOREAN);
    
    Date checkinDate = sdf.parse(rrb.getRoom_checkin_date());
    Date checkoutDate = sdf.parse(rrb.getRoom_checkout_date());
    
    
    String formattedCheckinDate = displayFormat.format(checkinDate);
    String formattedCheckoutDate = displayFormat.format(checkoutDate);
%>

<script>
    function gotoTrainReservation() {
        window.location.href = "station.train";
    }
    
    function gotoPayment() {
        var userId = "<%= rrb.getUser_id() %>";
        var roomReservationNum = "<%= rrb.getRoom_reservation_num() %>";
        window.location.href = "gotoPay.pay?user_id=" + userId + "&room_reservation_num=" + roomReservationNum;
    }
</script>

<div class="container" id="content_container">
    <div class="choice_btn_area">
        <h2 class="mb-5"> 철도 예약을 추가하시겠습니까? </h2>
        <div class="btn_area">
            <a class="button btnFloat train_btn" onClick="gotoTrainReservation()"></a>
            <a class="button btnFloat pay_btn" onClick="gotoPayment()"></a>
        </div>
    </div>
</div>
<%@include file="/resources/include/footer.jsp" %>