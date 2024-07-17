<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
thisPayment.jsp<br>

<table border = 1>
	<tr>
		<td>결제번호</td>
		<td>주문번호</td>
		<td>회원아이디</td>
		<td>결제금액</td>
	</tr>
	<tr>
		<td>${ pb.payment_num }</td>
		<td>${ pb.order_num }</td>
		<td>${ pb.user_id }</td>
		<td>${ pb.total_price }</td>
	</tr>
	<tr>
		<td colspan = 4>
			<a href = "gotoAllMyPaymentList.pay?user_id=${ pb.user_id }"><input type = "button" value = "전체 주문내역 보기"></a>
			<a href = "gotoCancel.pay"><input type = "button" value = "취소"></a>
		</td>
	</tr>
</table>