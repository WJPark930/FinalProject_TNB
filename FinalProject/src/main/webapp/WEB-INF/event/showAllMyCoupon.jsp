<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>  

showAllMyCoupon.jsp<br>

<table border = 1>

	<tr>
		<td>쿠폰 번호</td>
		<td>회원 번호</td>
		<td>종류</td>
		<td>금액</td>
		<td>사용 여부</td>
	</tr>

<c:forEach var="coupon" items="${ couponList }">
	<tr>
		<td>${ coupon.coupon_num }</td>
		<td>${ coupon.user_id }</td>
		<td>${ coupon.kind }</td>
		<td>${ coupon.amount }</td>
		<td>${ coupon.use_status }</td>
	</tr>
</c:forEach>


</table>