<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>  

showAllMyReservation.jsp<br>

<table border = 1>

	<tr>
		<td>주문번호</td>
		<td>회원번호</td>
		<td>숙소번호</td>
		<td>타입번호</td>
		<td>체크인날짜</td>
		<td>체크아웃날짜</td>
		<td>인원수</td>
		<td>기차 스케줄 아이디</td>
		<td>출발역</td>
		<td>도착역</td>
		<td>인원수(성인/아동/경로)</td>
		<td>총가격</td>
		<td>결제여부</td>
		<td>환불여부</td>
	</tr>

<c:forEach var="reservation" items="${ reservationList }">
	<tr>
		<td>${ reservation.order_num }</td>
		<td>${ reservation.user_id }</td>
		<td>${ reservation.shop_id }</td>
		<td>${ reservation.room_id }</td>
		<td>${ reservation.room_checkin_date }</td>
		<td>${ reservation.room_checkout_date }</td>
		<td>${ reservation.room_reserve_quantity }</td>	
		<td>${ reservation.train_schedule_id }</td>
		<td>${ reservation.train_departure_station_id }</td>
		<td>${ reservation.train_arrival_station_id }</td>
		<td>${ reservation.train_quantity_adult }/${ reservation.train_quantity_child }/${ reservation.train_quantity_senior }</td>
		<td>${ reservation.total_price }</td>
		<td>${ reservation.payment_status }</td>
		<td>${ reservation.refund_status }</td>
	</tr>
</c:forEach>


</table>