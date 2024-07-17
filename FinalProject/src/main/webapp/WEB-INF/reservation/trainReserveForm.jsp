<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>

trainReserveForm.jsp<br>

<script>
	function checkData() {
		var adultQty = document.getElementById("train_quantity_adult").value;
		var childQty = document.getElementById("train_quantity_child").value;
		var seniorQty = document.getElementById("train_quantity_senior").value;

		if (parseInt(childQty) > 0 && parseInt(adultQty) === 0 && parseInt(seniorQty) === 0) {
			alert("아동은 반드시 보호자와 동승해야 합니다");
			return false;
		}
        
		if(parseInt(childQty) === 0 && parseInt(adultQty) === 0 && parseInt(seniorQty) === 0) {
			alert("탑승 인원을 선택해주세요");
			return false;
		}
	}

	function calculatePrice() {
		var adultQty = parseInt(document.getElementById("train_quantity_adult").value) || 0;
		var childQty = parseInt(document.getElementById("train_quantity_child").value) || 0;
		var seniorQty = parseInt(document.getElementById("train_quantity_senior").value) || 0;
		var priceForAdult = parseFloat("${ train_price_forAdult }");

		var totalPrice = (adultQty * priceForAdult) + (childQty * priceForAdult * 0.5) + (seniorQty * priceForAdult * 0.7);
		var roundedPrice = Math.round(totalPrice / 100) * 100; 
		document.getElementById("train_price").value = roundedPrice;
	}

	window.onload = function() {
		document.getElementById("train_quantity_adult").addEventListener("input", calculatePrice);
		document.getElementById("train_quantity_child").addEventListener("input", calculatePrice);
		document.getElementById("train_quantity_senior").addEventListener("input", calculatePrice);
	}
</script>

<form:form commandName="trainreserve" action="trainReserve.rv" method="post">
    train_price_forAdult : ${ train_price_forAdult }
   <input type = "text" name = "user_id" value = "${ user_id }">
    <table border="1">
        <tr>
            <td>train_schedule_id</td>
            <td><input type="text" name="train_schedule_id" value="${ train_schedule_id }"></td>
        </tr>
        <tr>
            <td>train_departure_station_id</td>
            <td><input type="text" name="train_departure_station_id" value="${ train_departure_station_id }"></td>
        </tr>
        <tr>
            <td>train_arrival_station_id</td>
            <td><input type="text" name="train_arrival_station_id" value="${ train_arrival_station_id }"></td>
        </tr>
        <tr>
            <td>train_quantity_adult</td>
            <td>
                <input type="text" id="train_quantity_adult" name="train_quantity_adult" value="0">
            </td>
        </tr>
        <tr>
            <td>train_quantity_child</td>
            <td>
                <input type="text" id="train_quantity_child" name="train_quantity_child" value="0">
            </td>
        </tr>
        <tr>
            <td>train_quantity_senior</td>
            <td>
                <input type="text" id="train_quantity_senior" name="train_quantity_senior" value="0">
            </td>
        </tr>
        <tr>
            <td>train_price</td>
            <td>
                <input type="text" id="train_price" name="train_price" value="${ train_price }" readonly>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="예약하기" onClick="return checkData()">
            </td>
        </tr>
    </table>
</form:form>
