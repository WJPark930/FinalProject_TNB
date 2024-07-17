<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
roomReservationForm.jsp<br>
<script>
	function checkData() {
		const quantity = document.querySelector('input[name="room_reserve_quantity"]').value;
		
		if(quantity == 0) {
			alert("인원수를 입력하세요");
			return false;
		}
		
		if(quantity > 3) {
			alert("최대 인원수를 초과했습니다");
			return false;
		}
	
	}
</script>

<form:form commandName="roomreserve" action="roomReserve.rv" method = "post">
	<input type = "text" name = "user_id" value = ${ user_id }>
	<table border = 1>
		<tr>
			<td>shop_id</td>
			<td><input type = "text" name = "shop_id" value = ${ shop_id }></td>
		</tr>
		<tr>
			<td>room_id</td>
			<td><input type = "text" name = "room_id" value = ${ room_id }></td>
		</tr>
		<tr>
			<td>checkin_date</td>
			<td>
				<fmt:parseDate value="${ room_checkin_date }" var="dayFmt" pattern="yyyy-MM-dd"/>
				<fmt:formatDate var="room_checkin_date" value="${ dayFmt }" pattern="yyyy-MM-dd"/>
				<input type="date" name="room_checkin_date" value="${ room_checkin_date }">
			</td>
		</tr>
		<tr>
			<td>checkout_date</td>
			<td>
				<fmt:parseDate value="${ room_checkout_date }" var="dayFmt" pattern="yyyy-MM-dd"/>
				<fmt:formatDate var="room_checkout_date" value="${ dayFmt }" pattern="yyyy-MM-dd"/>
				<input type="date" name="room_checkout_date" value="${ room_checkout_date }">
			</td>
		</tr>
		<tr>
			<td>quantity</td>
			<td>
				<input type="text" id="quantity" name="room_reserve_quantity" value="0">
			</td>
		</tr>
		<tr>
			<td>price</td>
			<td>
				<input type="text" id="price" name="price" value="${ price }">
			</td>
		</tr>		
		<tr>
			<td colspan = 2> 
				<input type = "submit" value = "예약하기" onClick = "return checkData()">
			</td>
		</tr>
	</table>
</form:form>