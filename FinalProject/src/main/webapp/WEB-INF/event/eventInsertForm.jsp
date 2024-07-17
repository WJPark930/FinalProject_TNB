<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../common/common.jsp" %>
eventInsertForm.jsp<br>

<%
    String[] event_discount_kind = {"할인 없음", "금액 차감", "비율 할인", "포인트 적립"};
    pageContext.setAttribute("event_discount_kind", event_discount_kind);
%>

<script>
	function toggleDiscountAmount() {
		const discountKind = document.querySelector('input[name="event_discount_kind"]:checked').value;
		const discountAmountContainer = document.getElementById('discountAmountContainer');
		const selectedAmount = "${event.event_discount_amount}";

		discountAmountContainer.innerHTML = '';

		if (discountKind === '금액 차감') {
			[10000, 20000, 30000].forEach(amount => {
				const label = document.createElement('label');
				const input = document.createElement('input');
				input.type = 'radio';
				input.name = 'event_discount_amount';
				input.value = amount;
				if (amount == selectedAmount) input.checked = true;
				label.appendChild(input);
				label.appendChild(document.createTextNode(amount + '원'));
				discountAmountContainer.appendChild(label);
			});
		} else if (discountKind === '비율 할인') {
			[3, 5, 7].forEach(rate => {
				const label = document.createElement('label');
				const input = document.createElement('input');
				input.type = 'radio';
				input.name = 'event_discount_amount';
				input.value = rate;
				if (rate == selectedAmount) input.checked = true;
				label.appendChild(input);
				label.appendChild(document.createTextNode(rate + '%'));
				discountAmountContainer.appendChild(label);
			});
		} else if (discountKind === '포인트 적립') {
			[1000, 3000, 5000].forEach(amount => {
				const label = document.createElement('label');
				const input = document.createElement('input');
				input.type = 'radio';
				input.name = 'event_discount_amount';
				input.value = amount;
				if (amount == selectedAmount) input.checked = true;
				label.appendChild(input);
				label.appendChild(document.createTextNode(amount + '포인트'));
				discountAmountContainer.appendChild(label);
			});
		} else {
			const input = document.createElement('input');
			input.type = 'text';
			input.name = 'event_discount_amount';
			input.disabled = true;
			discountAmountContainer.appendChild(input);
		}
	}

	function checkData() {
		const endDate = document.querySelector('input[name="event_end_date"]').value;
		const today = new Date();
		const endDateValue = new Date(endDate);

		const discountKind = document.querySelector('input[name="event_discount_kind"]:checked').value;
		const discountAmount = document.querySelector('input[name="event_discount_amount"]:checked') 
			? document.querySelector('input[name="event_discount_amount"]:checked').value 
			: 0;


		if (endDateValue < today) {
			alert('종료일은 오늘 날짜 이후로 설정해야 합니다.');
			return false; 
		}

		if (discountKind !== '할인 없음' && discountAmount == 0) {
			alert('할인값 선택하세요.');
			return false; 
		}

	}
</script>

<form:form commandName="event" name="eventInsertForm" action="eventInsert.ev" enctype="multipart/form-data">
	<table border="1">
		<tr>
			<td>title</td>
			<td>
				<input type="text" name="event_title" value="${event.event_title}">
				<form:errors path="event_title" cssClass="err"/>
			</td>
		</tr>
		<tr>
			<td>context</td>
			<td>
				<input type="text" name="event_context" value="${event.event_context}">
				<form:errors path="event_context" cssClass="err"/>
			</td>
		</tr>
		<tr>
			<td>image</td>
			<td>
				<input type="file" name="upload" value="${event.event_image}">
				<form:errors path="event_image" cssClass="err"/>
			</td>
		</tr>
		<tr>
			<td>할인 종류</td>			
			<td>
				<c:forEach var="kind" items="<%= event_discount_kind %>">
					<input type="radio" name="event_discount_kind" value="${ kind }" <c:if test="${event.event_discount_kind eq kind || (event.event_discount_kind == null && kind eq '할인 없음')}">checked</c:if> onclick="toggleDiscountAmount()">${ kind }
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td>discount amount</td>
			<td id="discountAmountContainer">
				<input type="text" name="event_discount_amount" value="${event.event_discount_amount}">
			</td>
		</tr>
		<tr>
			<td>end_date</td>
			<td>
				<input type="date" name="event_end_date" value="${event.event_end_date}">
				<form:errors path="event_end_date" cssClass="err"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="제출하기" onClick="return checkData()">
			</td>
		</tr>
	</table>
</form:form>

<script>
	document.addEventListener('DOMContentLoaded', (event) => {
		toggleDiscountAmount(); 
	});
</script>