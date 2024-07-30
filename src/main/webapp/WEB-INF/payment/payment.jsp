<%@page import="member.model.MemberDao"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %>
<script src="https://pay.nicepay.co.kr/v1/js/"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/reservation/reservation.css?after">

<div class="container text-center" id="content_container">
   <div class="payment_area">
      <div class="payment_box_area">
          <div class="box" data-value="1">
                <div class="box_text">
                    <i class="bi bi-credit-card"></i>일반결제
                </div>
            </div>
          <div class="box" data-value="2">
                <div class="box_text">
                    <i class="bi bi-send"></i>계좌이체
                </div>
            </div>
      </div>
      <div class="payment_box_area">
          <div class="box" data-value="3">
                <div class="box_text">
                    <i class="bi bi-stripe"></i>삼성페이
                </div>
            </div>
          <div class="box" data-value="4">
                <div class="box_text">
                    <img src="<%=request.getContextPath()%>/resources/assets/icon/kakao_pay.svg">
                    카카오페이
                </div>
            </div>
      </div>
   </div>
   <button class="payment-button" id="paymentButton">결제하기</button>
</div>

<%-- <p>${ order_num } / ${ total_price } / ${ user_id } / ${ coupon_num } / ${ point_amount }<br>
${ shop_info.shop_name } / ${ mb.user_name } / ${ mb.user_phone } / ${ mb.user_email }
 --%>
<script>

   const orderNum = "${order_num}";
   const totalPrice = "${total_price}";
   const userId = "${user_id}";
   const couponNum = "${coupon_num}";
   const pointAmount = "${point_amount}";
   const shopName = "${shop_info.shop_name}";
   const userName = "${mb.user_name}";
   const userPhone = "${mb.user_phone}";
   const userEmail = "${mb.user_email}";

    document.addEventListener('DOMContentLoaded', () => {
        // JSP에서 정의된 변수들
   
        let selectedBox = null;

        // 박스 클릭 이벤트 설정
        document.querySelectorAll('.box').forEach(box => {
            box.addEventListener('click', () => {
                // 모든 박스에서 선택된 상태 제거
                document.querySelectorAll('.box').forEach(b => b.classList.remove('selected'));

                // 클릭한 박스를 선택 상태로 변경
                box.classList.add('selected');
                selectedBox = box;

                // 콘솔 로그 추가: 클릭한 박스와 데이터 값 확인
                console.log('Selected box:', selectedBox);
                console.log('Selected box data-value:', selectedBox.getAttribute('data-value'));
            });
        });

        // 결제하기 버튼 클릭 이벤트 설정
        document.getElementById('paymentButton').addEventListener('click', () => {
            if (selectedBox) {
                // data-value 속성에서 값을 읽어오기
                const value = selectedBox.getAttribute('data-value');
                //alert(`선택한 박스의 값은 ${value}입니다.`);

                // 콘솔 로그 추가: 선택된 박스와 데이터 값 확인
                console.log('Button clicked. Selected box:', selectedBox);
                console.log('Button clicked. Selected box data-value:', value);

                // data-value에 따라 적절한 함수 호출
                switch (value) {
                    case '1':
                        card(orderNum, userId, couponNum, pointAmount, totalPrice);
                        break;
                    case '2':
                        bank(orderNum, userId, couponNum, pointAmount, totalPrice);
                        break;
                    case '3':
                        samsung(orderNum, userId, couponNum, pointAmount, totalPrice);
                        break;
                    case '4':
                        kakao(orderNum, userId, couponNum, pointAmount, totalPrice);
                        break;
                    case '5':
                        naver(orderNum, userId, couponNum, pointAmount, totalPrice);
                        break;
                    case '6':
                        // 특정 함수 호출 (빈 박스)
                        alert('해당 결제 방법은 준비 중입니다.');
                        break;
                    default:
                        alert('잘못된 선택입니다.');
                }
            } else {
                alert('결제방식을 선택해 주세요.');

                // 콘솔 로그 추가: 박스가 선택되지 않았을 때
                console.log('Button clicked but no box is selected.');
            }
        });
    });

    // 결제 함수들
    function card(orderNum, userId, couponNum, pointAmount, totalPrice) {
        //alert("card orderNum : " + orderNum);
        //alert("totalPrice : " + totalPrice);
       // alert("userId : " + userId);

        AUTHNICE.requestPay({
            clientId: 'S1_d61b63468d624d75b60a90af8fc09664',
            method: 'card',
            orderId: orderNum,
            amount: totalPrice,
            goodsName: shopName,
            buyerName: userName,
            buyerTel: userPhone,
            buyerEmail: userEmail,
            returnUrl: 'http://localhost:8080/ex/payment.pay?order_num=' + orderNum +
                '&user_id=' + userId +
                '&coupon_num=' + couponNum +
                '&point_amount=' + pointAmount +
                '&total_price=' + totalPrice,
            fnError: function (result) {
                //alert('개발자확인용 : ' + result.errorMsg + '');
            }
        });
    }

    function bank(orderNum, userId, couponNum, pointAmount, totalPrice) {
        //alert("bank orderNum : " + orderNum);
        //alert("totalPrice : " + totalPrice);
       // alert("userId : " + userId);

        AUTHNICE.requestPay({
            clientId: 'S1_d61b63468d624d75b60a90af8fc09664',
            method: 'bank',
            orderId: orderNum,
            amount: totalPrice,
            goodsName: shopName,
            buyerName: userName,
            buyerTel: userPhone,
            buyerEmail: userEmail,
            returnUrl: 'http://localhost:8080/ex/payment.pay?order_num=' + orderNum +
            '&user_id=' + userId +
            '&coupon_num=' + couponNum +
            '&point_amount=' + pointAmount +
            '&total_price=' + totalPrice,
            fnError: function (result) {
                //alert('개발자확인용 : ' + result.errorMsg + '');
            }
        });
    }

    function samsung(orderNum, userId, couponNum, pointAmount, totalPrice) {
        //alert("samsung orderNum : " + orderNum);
        //alert("totalPrice : " + totalPrice);
        //alert("userId : " + userId);

        AUTHNICE.requestPay({
            clientId: 'S1_d61b63468d624d75b60a90af8fc09664',
            method: 'samsungpayCard',
            orderId: orderNum,
            amount: totalPrice,
            goodsName: shopName,
            buyerName: userName,
            buyerTel: userPhone,
            buyerEmail: userEmail,
            returnUrl: 'http://localhost:8080/ex/payment.pay?order_num=' + orderNum +
            '&user_id=' + userId +
            '&coupon_num=' + couponNum +
            '&point_amount=' + pointAmount +
            '&total_price=' + totalPrice,
            fnError: function (result) {
                alert('개발자확인용 : ' + result.errorMsg + '');
            }
        });
    }

    function kakao(orderNum, userId, couponNum, pointAmount, totalPrice) {
        //alert("kakao orderNum : " + orderNum);
        //alert("totalPrice : " + totalPrice);
        //alert("userId : " + userId);

        AUTHNICE.requestPay({
            clientId: 'S1_d61b63468d624d75b60a90af8fc09664',
            method: 'kakaopay',
            orderId: orderNum,
            amount: totalPrice,
            goodsName: shopName,
            buyerName: userName,
            buyerTel: userPhone,
            buyerEmail: userEmail,
            returnUrl: 'http://localhost:8080/ex/payment.pay?order_num=' + orderNum +
            '&user_id=' + userId +
            '&coupon_num=' + couponNum +
            '&point_amount=' + pointAmount +
            '&total_price=' + totalPrice,
            fnError: function (result) {
                alert('개발자확인용 : ' + result.errorMsg + '');
            }
        });
    }

    function naver(orderNum, userId, couponNum, pointAmount, totalPrice) {
        alert('서비스 준비중입니다');
    }
</script>

<%@include file="/resources/include/footer.jsp" %>
