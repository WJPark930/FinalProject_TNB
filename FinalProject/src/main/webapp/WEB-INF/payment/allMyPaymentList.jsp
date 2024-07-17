<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %> 
allMyPaymentList.jsp<br>

<h2>내 모든 결제내역 보기</h2>
<table border = 1>
	<tr>
		<td>결제번호</td>
		<td>주문번호</td>
		<td>결제금액</td>
	</tr>
	<c:forEach var="payment" items="${ allMyPaymentList }">
		<tr>
			<td>${ payment.payment_num }</td>
			<td>${ payment.order_num }</td>
			<td>${ payment.total_price }</td>
		</tr>
	
	</c:forEach>

</table>