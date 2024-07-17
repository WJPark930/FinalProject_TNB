<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>  

<script>
    window.onload = function() {
        updateTotalPrice();
    };
    
    function isDiscount() {
        const selectedCoupon = document.querySelector('input[name="couponChoice"]:checked');
        
        if (selectedCoupon) {
            const couponNum = selectedCoupon.value;

            const couponRow = selectedCoupon.closest('table').querySelectorAll('tr')[2];
            const couponKind = couponRow.children[1].textContent.trim();
            const couponAmount = parseFloat(couponRow.children[2].textContent);

            document.getElementById('coupon_num').value = couponNum;
            document.getElementById('coupon_kind').value = couponKind;
            document.getElementById('coupon_amount').value = couponAmount;

            updateTotalPrice();
        }
    }
    
    function updateTotalPrice() {
        const roomPrice = parseFloat(document.getElementById('room_price').value);
        const trainPrice = parseFloat(document.getElementById('train_price').value || 0);
        const couponKind = document.getElementById('coupon_kind').value;
        const couponAmount = parseFloat(document.getElementById('coupon_amount').value || 0);
        const pointAmount = parseFloat(document.getElementById('point_amount_show').value || 0);

        let totalPrice = roomPrice + trainPrice;

        if (couponKind === "금액 차감") {
            totalPrice -= couponAmount;
        } else if (couponKind === "비율 할인") {
            totalPrice *= (1 - (couponAmount * 0.01));
        }

        totalPrice -= pointAmount;

        totalPrice = Math.round(totalPrice / 100) * 100;

        document.getElementById('total_price').value = totalPrice;
    }
    
    function confirmUsePoints() {
    	var userPoint = parseFloat('${ mb.user_point }');
    	var pointAmount = document.getElementById('point_amount_show').value;
    	if(pointAmount == "") {
    		alert("포인트 값을 입력하지 않았습니다");
    		return;
    	}
    	
    	if (isNaN(pointAmount)) {
            alert("포인트 값에는 숫자만 입력해야 합니다.");
            document.getElementById('point_amount_show').value = ""; // 값을 초기화
            return;
        }
    	
    	var inputAmount = parseFloat(pointAmount);
        
        // 보유 포인트를 초과하는지 확인
        if (inputAmount > userPoint) {
            alert("보유 포인트를 초과하였습니다.");
            document.getElementById('point_amount_show').value = userPoint;
            return;
        }
    	
        if (confirm("포인트를 사용하시겠습니까?")) {
            alert("사용할 포인트 금액: " + pointAmount);
            
            updateTotalPrice();
            document.getElementById('point_amount').value = pointAmount;
        } 
    }
    
    
</script>


showAllReservation.jsp<br>


<c:forEach var="coupon" items="${ couponList }">

    <table border = 1>
        <tr>
            <td colspan = 3>
                <input type="radio" name="couponChoice" value="${ coupon.coupon_num }"  onClick = "isDiscount()">
            </td>
        </tr>
        <tr>
            <td>쿠폰번호</td>
            <td>종류</td>
            <td>금액</td>
        </tr>
        <tr>
            <td>${ coupon.coupon_num }</td>
            <td>${ coupon.kind }</td>
            <td>${ coupon.amount }</td>
        </tr>
    
    </table>

</c:forEach>

<table border = 1>
    <tr>
        <td>회원id</td>
        <td>보유 포인트</td>
        <td>사용 포인트</td>
        <td>버튼</td>
    </tr>
    <tr>
        <td>${ mb.user_id }</td>
        <td>${ mb.user_point }</td>
        <td><input type="text" id="point_amount_show" name="point_amount_show"></td>
        <td><input type = "button" id = "use_points_button" value = "사용하기" onClick="confirmUsePoints()"></td>
    </tr>
</table>

<c:if test="${ trb == null }">

    <table border = 1 width = 30%>
        <tr>
            <td>예약번호</td>
            <td>${ rrb.room_reservation_num }</td>
        </tr>
        <tr>
            <td>예약자아이디 user_id</td>
            <td>${ rrb.user_id }</td>
        </tr>
        <tr>
            <td>숙소아이디 shop_id</td>
            <td>${ rrb.shop_id }</td>
        </tr>       
        <tr>
            <td>타입아이디 room_id</td>
            <td>${ rrb.room_id }</td>
        </tr>       
        <tr>
            <td>체크인날짜 checkin_date</td>
            <td>${ rrb.room_checkin_date }</td>
        </tr>       
        <tr>
            <td>체크아웃날짜 checkout_date</td>
            <td>${ rrb.room_checkout_date }</td>
        </tr>       
        <tr>
            <td>숙박인원</td>
            <td>${ rrb.room_reserve_quantity }</td>
        </tr>       
        <tr>
            <td>숙소가격</td>
            <td>${ rrb.price }</td>
        </tr>       
    </table>

</c:if>


<c:if test="${ trb != null }">

    <table border = 1 width = 30%>
        <tr>
            <td>예약번호</td>
            <td>${ rrb.room_reservation_num }</td>
        </tr>
        <tr>
            <td>예약자아이디 user_id</td>
            <td>${ rrb.user_id }</td>
        </tr>
        <tr>
            <td>숙소아이디 shop_id</td>
            <td>${ rrb.shop_id }</td>
        </tr>       
        <tr>
            <td>타입아이디 room_id</td>
            <td>${ rrb.room_id }</td>
        </tr>       
        <tr>
            <td>체크인날짜 checkin_date</td>
            <td>${ rrb.room_checkin_date }</td>
        </tr>       
        <tr>
            <td>체크아웃날짜 checkout_date</td>
            <td>${ rrb.room_checkout_date }</td>
        </tr>       
        <tr>
            <td>숙박인원</td>
            <td>${ rrb.room_reserve_quantity }</td>
        </tr>       
        <tr>
            <td>숙소 가격</td>
            <td>${ rrb.price }</td>
        </tr>       
    
    </table>
        
    <table border = 1 width = 30%>
        <tr>
            <td>예약번호</td>
            <td>${ trb.train_reservation_num }</td>
        </tr>
        <tr>
            <td>예약자아이디 user_id</td>
            <td>${ trb.user_id }</td>
        </tr>
        <tr>
            <td>기차 운행일정 train_schedule_id</td>
            <td>${ trb.train_schedule_id }</td>
        </tr>
        <tr>
            <td>출발역ID train_departure_station_id</td>
            <td>${ trb.train_departure_station_id }</td>
        </tr>
        <tr>
            <td>도착역ID train_arrival_station_id</td>
            <td>${ trb.train_arrival_station_id }</td>
        </tr>
        <tr>
            <td>예약인원(성인/아동/경로)</td>
            <td>${ trb.train_quantity_adult }/${ trb.train_quantity_child }/${ trb.train_quantity_senior }</td>
        </tr>
        <tr>
            <td>열차 총 가격</td>
            <td>${ trb.train_price }</td>
        </tr>
    </table>

</c:if>


<form action="payment.pay">
    <table border = 1 id="final">
        <tr>
            <td>예약번호</td>
            <td><input type="text" name="order_num" value="${ rrb.room_reservation_num }"></td>
            <td>회원번호</td>
            <td><input type="text" name="user_id" value="${ mb.user_id }"></td>
        </tr>
        <tr>
            <td>숙소 가격</td>
            <td><input type="text" id="room_price" name="room_price" value="${ rrb.price }"></td>
            <td>열차 가격</td>
            <td><input type="text" id="train_price" name="train_price" value="${ trb.train_price }"></td>
        </tr>
        <tr>
            <td>쿠폰 번호</td>
            <td><input type = "text" id = "coupon_num" name = "coupon_num" value = 0></td>
            <td>쿠폰 종류</td>
            <td><input type="text" id="coupon_kind" name="coupon_kind" value = 0></td>           
        </tr>
        <tr>
            <td>쿠폰 금액</td>
            <td><input type="text" id="coupon_amount" name="coupon_amount" value = 0></td>
            <td>포인트 금액</td>
            <td><input type="text" id="point_amount" name="point_amount" value = 0></td>    
        </tr>
        <tr>
            <td>총 결제 금액</td>
            <td><input type="text" id="total_price" name="total_price"></td>
            <td>결제버튼</td>
            <td><input type="submit" value="결제하기"></td>
        </tr>

    </table>
</form>

<c:set var="gotoMain" value="${ pageContext.request.contextPath }/main.jsp" />
<a href="${ gotoMain }"><input type="button" value="메인으로"></a>

