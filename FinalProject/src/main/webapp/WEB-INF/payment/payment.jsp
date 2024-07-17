<%@page import="member.model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://pay.nicepay.co.kr/v1/js/"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<%@ include file="../common/common.jsp" %>

<p>${ order_num } / ${ total_price } / ${ user_id } / ${ coupon_num } / ${ point_amount }</p> 
<input type="button" value="일반결제" onClick="card('${ order_num }', '${ user_id }', '${ coupon_num }', '${ point_amount }', '${ total_price }')">
<input type="button" value="계좌이체" onClick="bank('${ order_num }', '${ total_price }', '${ user_id }')">
<input type="button" value="무통장" onClick="vbank('${ order_num }', '${ total_price }', '${ user_id }')">
<input type="button" value="휴대폰" onClick="cellphone('${ order_num }', '${ total_price }', '${ user_id }')">
<input type="button" value="카카오" onClick="kakao('${ order_num }', '${ total_price }', '${ user_id }')">
<input type="button" value="삼성페이" onClick="samsung('${ order_num }', '${ total_price }', '${ user_id }')">
<input type="button" value="네이버페이" onClick="naver('${ order_num }', '${ total_price }', '${ user_id }')">



<script>
  function card(order_num, user_id, coupon_num, point_amount, total_price) {
    alert("card order_num : " + order_num);
    alert("total_price : " + total_price);
    alert("user_id : " + user_id);

    AUTHNICE.requestPay({
      clientId: 'S1_d61b63468d624d75b60a90af8fc09664',
      method: 'card',
      orderId: order_num,
      amount: total_price,
      goodsName: order_num,
      buyerName: user_id,
      buyerTel: '01037278251',
      buyerEmail: 'leeyewon81@naver.com',
      returnUrl: 'http://localhost:8080/ex/payment.pay?order_num='+order_num
												      +'&user_id='+user_id
												      +'&coupon_num='+coupon_num
												      +'&point_amount='+point_amount
												      +'&total_price='+total_price,
      fnError: function (result) {
        alert('개발자확인용 : ' + result.errorMsg + '');
      }
    });
  }

  function bank(order_num, total_price, user_id) {
    alert("bank order_num : " + order_num);
    alert("total_price : " + total_price);
    alert("user_id : " + user_id);

    AUTHNICE.requestPay({
      clientId: 'S1_d61b63468d624d75b60a90af8fc09664',
      method: 'bank',
      orderId: order_num,
      amount: total_price,
      goodsName: order_num,
      buyerName: user_id,
      buyerTel: '01037278251',
      buyerEmail: 'leeyewon81@naver.com',
      returnUrl: 'http://localhost:8080/ex/payment.pay?order_num='+order_num+'&total_price='+total_price+'&user_id='+user_id,
      fnError: function (result) {
        alert('개발자확인용 : ' + result.errorMsg + '');
      }
    });
  }

  function vbank(order_num, total_price, user_id) {
    alert("vbank order_num : " + order_num);
    alert("total_price : " + total_price);
    alert("user_id : " + user_id);

    AUTHNICE.requestPay({
      clientId: 'S1_d61b63468d624d75b60a90af8fc09664',
      method: 'vbank',
      orderId: order_num,
      amount: total_price,
      goodsName: order_num,
      buyerName: user_id,
      buyerTel: '01037278251',
      buyerEmail: 'leeyewon81@naver.com',
      returnUrl: 'http://localhost:8080/ex/payment.pay?order_num='+order_num+'&total_price='+total_price+'&user_id='+user_id,
      useEscrow: true,
      vbankHolder: '이예원',
      fnError: function (result) {
        alert('개발자확인용 : ' + result.errorMsg + '');
      }
    });
  }

  function cellphone(order_num, total_price, user_id) {
    alert("cellphone order_num : " + order_num);
    alert("total_price : " + total_price);
    alert("user_id : " + user_id);

    AUTHNICE.requestPay({
      clientId: 'S1_d61b63468d624d75b60a90af8fc09664',
      method: 'cellphone',
      orderId: order_num,
      amount: total_price,
      goodsName: order_num,
      buyerName: user_id,
      buyerTel: '01037278251',
      buyerEmail: 'leeyewon81@naver.com',
      returnUrl: 'http://localhost:8080/ex/payment.pay?order_num='+order_num+'&total_price='+total_price+'&user_id='+user_id,
      isDigital: true,
      fnError: function (result) {
        alert('개발자확인용 : ' + result.errorMsg + '');
      }
    });
  }

  function kakao(order_num, total_price, user_id) {
    alert("kakao order_num : " + order_num);
    alert("total_price : " + total_price);
    alert("user_id : " + user_id);

    AUTHNICE.requestPay({
      clientId: 'S1_d61b63468d624d75b60a90af8fc09664',
      method: 'kakaopay',
      orderId: order_num,
      amount: total_price,
      goodsName: order_num,
      buyerName: user_id,
      buyerTel: '01037278251',
      buyerEmail: 'leeyewon81@naver.com',
      returnUrl: 'http://localhost:8080/ex/payment.pay?order_num='+order_num+'&total_price='+total_price+'&user_id='+user_id,
      fnError: function (result) {
        alert('개발자확인용 : ' + result.errorMsg + '');
      }
    });
  }

  function samsung(order_num, total_price, user_id) {
    alert("samsung order_num : " + order_num);
    alert("total_price : " + total_price);
    alert("user_id : " + user_id);

    AUTHNICE.requestPay({
      clientId: 'S1_d61b63468d624d75b60a90af8fc09664',
      method: 'samsungpayCard',
      orderId: order_num,
      amount: total_price,
      goodsName: order_num,
      buyerName: user_id,
      buyerTel: '01037278251',
      buyerEmail: 'leeyewon81@naver.com',
      returnUrl: 'http://localhost:8080/ex/payment.pay?order_num='+order_num+'&total_price='+total_price+'&user_id='+user_id,
      fnError: function (result) {
        alert('개발자확인용 : ' + result.errorMsg + '');
      }
    });
  }

  function naver(order_num, total_price, user_id) {
    alert('서비스 준비중입니다');
  }
</script>
