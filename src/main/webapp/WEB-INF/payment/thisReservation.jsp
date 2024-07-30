<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %> 

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/reservation/reservation.css?after">

<script>
    function formatNumber(number) {
        // 숫자가 아닌 경우 빈 문자열 반환
        if (isNaN(number)) return '';

        // 숫자를 문자열로 변환한 후, 정규 표현식을 사용하여 세 자리마다 콤마 추가
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    function updateFormattedValues() {
        // 텍스트 필드의 값들을 가져와서 포맷팅
        const roomPrice = document.getElementById('room_price');
        const trainPrice = document.getElementById('train_price');
        const couponAmount = document.getElementById('coupon_amount');
        const pointAmount = document.getElementById('point_amount');
        const totalPrice = document.getElementById('total_price');

        // 각 필드의 값을 가져와서 포맷팅하고 다시 설정
        roomPrice.value = formatNumber(parseFloat(roomPrice.value) || 0);
        trainPrice.value = formatNumber(parseFloat(trainPrice.value) || 0);
        couponAmount.value = formatNumber(parseFloat(couponAmount.value) || 0);
        pointAmount.value = formatNumber(parseFloat(pointAmount.value) || 0);
        totalPrice.value = formatNumber(parseFloat(totalPrice.value) || 0);
    }

    function isDiscount(coupon_num,couponKind,couponAmount) {

        document.getElementById('coupon_num').value = coupon_num;
        document.getElementById('coupon_kind').value = couponKind;
        document.getElementById('coupon_amount').value = couponAmount;

        updateTotalPrice();
    }
    
    function updateTotalPrice() {
        const roomPrice = parseFloat(document.getElementById('room_price').value.replace(/,/g, ''));
        const trainPrice = parseFloat(document.getElementById('train_price').value.replace(/,/g, '') || 0);
        const couponKind = document.getElementById('coupon_kind').value;
        const couponAmount = parseFloat(document.getElementById('coupon_amount').value.replace(/,/g, '') || 0);
        const pointAmount = parseFloat(document.getElementById('point_amount_show').value.replace(/,/g, '') || 0);

        let totalPrice = roomPrice + trainPrice;

        if (couponKind === "금액 차감") {
	        document.getElementById('default_price').innerHTML  = formatNumber(totalPrice)+"원";
            totalPrice -= couponAmount;
        } else if (couponKind === "비율 할인") {
	        document.getElementById('default_price').innerHTML  = formatNumber(totalPrice)+"원";
            totalPrice *= (1 - (couponAmount * 0.01));
        }

        totalPrice -= pointAmount;

        totalPrice = Math.round(totalPrice / 100) * 100;

        document.getElementById('final_price').innerHTML  = formatNumber(totalPrice)+"원";
        document.getElementById('total_price_show').value = formatNumber(totalPrice);
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
        
        if (pointAmount % 1000 !== 0) {
        	 var roundedAmount = Math.floor(pointAmount / 1000) * 1000;
             alert("포인트는 1000원 단위로 사용해야 합니다.");
             document.getElementById('point_amount_show').value = parseFloat(roundedAmount);
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

    window.onload = function() {
        updateFormattedValues();
        updateTotalPrice();
    };
</script>

<%
    reservation.model.ReservationBean rb = (reservation.model.ReservationBean) request.getAttribute("rb");
    
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat displayFormat = new SimpleDateFormat("M/d(E)");
	
	String roomCheckinDateStr = rb.getRoom_checkin_date();
	String roomCheckoutDateStr = rb.getRoom_checkout_date();
	
	String formattedCheckinDate = "날짜 없음";
	String formattedCheckoutDate = "날짜 없음";
	
	if (roomCheckinDateStr != null && roomCheckoutDateStr != null) {
	    Date checkinDate = sdf.parse(roomCheckinDateStr);
	    Date checkoutDate = sdf.parse(roomCheckoutDateStr);
	    
	    formattedCheckinDate = displayFormat.format(checkinDate);
	    formattedCheckoutDate = displayFormat.format(checkoutDate);
	}
	
	SimpleDateFormat inputFormat = new SimpleDateFormat("yy/MM/dd HH:mm:ss.SSSSSSSSS");
	SimpleDateFormat outputFormat = new SimpleDateFormat("M/dd(E) HH:mm");
	
	String formattedDepPlandDate = "날짜 없음";
	String formattedArrPlandDate = "날짜 없음";
	
	if (rb.getDepPlandTime() != null && rb.getArrPlandTime() != null) {
	    Date depPlandDate = inputFormat.parse(rb.getDepPlandTime());
	    Date arrPlandDate = inputFormat.parse(rb.getArrPlandTime());
	
	    formattedDepPlandDate = outputFormat.format(depPlandDate);
	    formattedArrPlandDate = outputFormat.format(arrPlandDate);
	}
%>

<div class="container" id="content_container">

    <div class="pay_container">
        <div class="user_area">
            <div class="info_area">
	        	<h2>회원정보</h2>
                <div class="line"></div>
                <p>예약자이름: <span>${ mb.user_name }</span></p>
                <p>이메일: <span>${ mb.user_email }</span></p>
                <p>전화번호: <span>${ mb.user_phone }</span></p>
            </div>
            <div class="pay_area">
                <h2>쿠폰</h2>
                <div class="line"></div>
                <c:forEach var="coupon" items="${ couponList }">
                    <div class="coupon_area">
                        <fmt:parseDate value="${coupon.event_end_date}" var="day" pattern="yyyy-MM-dd"/>
                        <div>
                            <p>
                            <input type="radio" name="couponChoice" value="${ coupon.coupon_num }"  onClick = "isDiscount(${ coupon.coupon_num },'${ coupon.kind }','${ coupon.amount }')">
                            ${ coupon.event_title } <span> (${ coupon.coupon_num })</span>
                            </p>
                        </div>
                        <div class="coupon_info">
                            <p class="pt-1"><span>만료일: <fmt:formatDate value="${day}" pattern="yyyy-MM-dd"/></span></p>
                            <p><span class="coupon_kind">${ coupon.kind } /</span>  
                                <span class="coupon_amount">${ coupon.amount }
                                <c:if test="${ coupon.kind == '비율 할인' }">
                                    %
                                </c:if>
                                <c:if test="${ coupon.kind == '금액 차감' }">
                                    원
                                </c:if>
                                </span></p>
                        </div>
                    </div>
                </c:forEach>
                <h2 class="mt-5">포인트</h2>
                <div class="line"></div>
                <input type="text" id="point_amount_show" name="point_amount_show"> <span class="point_my">/${ mb.user_point } </span>
                <input type = "button" class="btn btn-primary ms-2" id = "use_points_button" value = "사용하기" onClick="confirmUsePoints()">
                <h2 class="mt-5">결제 정보</h2>
                <div class="line"></div>
            	<form action="payment.pay">	        	
            		<input type="hidden" name="order_num" value="${ rb.order_num }">
            		<input type="hidden" name="user_id" value="${ mb.user_id }">
            		<input type = "hidden" id = "coupon_num" name = "coupon_num" value = 0>
            		<input type="hidden" id="coupon_kind" name="coupon_kind" value = 0>
            		<input type="hidden" id="coupon_amount" name="coupon_amount" value = 0>
            		<input type="hidden" id="point_amount" name="point_amount" value = 0>
            		<input type="hidden" id="room_price" name="room_price" value="${ rb.room_total_price }">
            		<input type="hidden" id="train_price" name="train_price" value="${ rb.train_total_price }">
        		    <input type="hidden" id="total_price_show" name="total_price_show">
            		<input type="hidden" id="total_price" name="total_price">
            		
            		<p>숙소 가격/1박당: <span>${ rb.room_total_price }원</span></p>
                    <c:if test="${ rb.train_no != 0 }">
                        <p>열차 가격: <span>${ rb.train_total_price }원</span></p>
                    </c:if>
            		<p class="total_price_text">
            		결제 금액: <span id="final_price"></span><span id="default_price"></span>
            		</p>
                    <c:set var="gotoMain" value="${ pageContext.request.contextPath }/main.jsp" />
                    <div class="mt-3">
                        <input type="submit" class="btn pay_submit_btn" value="결제하기">
                        <input type="button" class="btn btn-secondary" onclick="location.href='${ gotoMain }'" value="취소하기">
                    </div>
		        </form>
            </div>
        </div>
        <div class="reservation_area">
            <div class="reservation_image_area" >
                <img src="<%=request.getContextPath()%>/resources/assets/image/${shopImage}" >
            </div>
            <div class="line"></div>
            <p>숙소명: <span>${ shop_info.shop_name }</span></p>
            <p>객실명: <span>${ srb.room_name }</span></p>
            <p>숙박기간: <span><%= formattedCheckinDate %> ~ <%= formattedCheckoutDate %></span></p>
            <p>숙박인원: <span>${ rb.room_reserve_quantity }인</span></p>
            <div class="line"></div>
            <c:if test="${ rb.train_no != 0 }">
                <p>출발역: <span>${ rb.depPlaceName }</span></p>
                <p>도착역: <span>${ rb.arrPlaceName }</span></p>
                <p>출발시간: <span><%= formattedDepPlandDate %></span></p>
                <p>도착시간: <span><%= formattedArrPlandDate %> (${ rb.duration })</span></p>
                <p>열차종류: <span>${ rb.train_type }</span></p>
                <p>열차번호: <span>${ rb.train_no }</span></p>
                <p>인원: <span>
                <c:if test="${rb.num_adults>0}">
                어른 ${ rb.num_adults }인
                    <c:if test="${rb.num_children>0}">
                    / 
                    </c:if>  
                </c:if>
                <c:if test="${rb.num_children>0}">
                아이 ${ rb.num_children }인
                    <c:if test="${rb.num_seniors>0}">
                    / 
                    </c:if> 
                </c:if>
                <c:if test="${rb.num_seniors>0}">
                경로 ${ rb.num_seniors }인
                </c:if>
                </span></p>
                <p>좌석번호: <span>${ rb.seat_no }</span></p>
                <div class="line"></div>
			</c:if>
        </div>
    </div>
     
</div>

<%@include file="/resources/include/footer.jsp" %>
