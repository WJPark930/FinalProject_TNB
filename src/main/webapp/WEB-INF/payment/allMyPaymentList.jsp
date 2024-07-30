<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %> 
<%@include file="/resources/include/header.jsp" %>

allMyPaymentList.jsp<br>

<h2>내 모든 결제내역 보기</h2>
<table border="1">
    <tr>
        <td>결제번호</td>
        <td>tid</td>
        <td>주문번호</td>
        <td>결제금액</td>
        <td>취소</td>
    </tr>
    <c:forEach var="payment" items="${ allMyPaymentList }">
        <tr>
            <td>${ payment.payment_num }</td>
            <td>${ payment.tid }</td>
            <td>${ payment.order_num }</td>
            <td>${ payment.total_price }</td>
            <td><input type="button" value="취소" onClick = "gotoCancel('${ payment.order_num }')"></td>
        </tr>
    </c:forEach>
</table>

<script>
	function gotoCancel(order_num) {
		alert(order_num);
		location.href = "gotoCancel.pay?order_num=" + order_num; 
	}

</script>

<%@include file="/resources/include/footer.jsp" %>