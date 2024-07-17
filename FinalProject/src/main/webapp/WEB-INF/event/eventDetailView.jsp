<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
eventDetailView.jsp<br>

<script type="text/javascript">
	function joinEvent(event_num, kind, amount, user_id) {
		if(kind === '금액 차감') {
			alert('쿠폰 지급');
			location.href = "eventCoupon.ev?event_num="+event_num+"&kind="+kind+"&amount="+amount+"&user_id="+user_id;
		} else if (kind === '비율 할인') {
			alert('쿠폰 지급');
			location.href = "eventCoupon.ev?event_num="+event_num+"&kind="+kind+"&amount="+amount+"&user_id="+user_id;
		} else if (kind === '포인트 적립') {
			alert('포인트 적립');
			location.href = "eventPoint.ev?user_point="+amount+"&user_id="+user_id;
		}
	}		
</script>

<c:if test="${user_email == 'admin'}">
	<table border = 1>
		<tr>
			<td>제목</td>
			<td>${ event.event_title }</td>
		</tr>
		<tr>
			<td>이미지</td>
			<td><img src="<%= request.getContextPath()+"/resources/uploadEventImage/" %>${ event.event_image }" width="100" height="100"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${ event.event_context }</td>
		</tr>
	
		<tr>
			<td>이벤트 시작일</td>
			<td>${ event.event_start_date }</td>
		</tr>
	
		<tr>
			<td>이벤트 마감일</td>
			<td>${ event.event_end_date }</td>
		</tr>
		<tr>
			<td>할인종류</td>
			<td>${ event.event_discount_kind }</td>
		</tr>
		<tr>
			<td>할인금액</td>
			<td>${ event.event_discount_amount }</td>
		</tr>
	
		<tr>
			<td colspan = 2>
				<a href = "eventUpdate.ev?event_num=${ event.event_num }"><input type = "button" value = "수정하기"></a>
				<a href = "eventDelete.ev?event_num=${ event.event_num }"><input type = "button" value = "삭제하기"></a>
				<a href = "eventList.ev"><input type = "button" value = "목록보기"></a>
			</td>
		</tr>
	
	</table>
</c:if>



<c:if test="${user_email != 'admin'}">
	<table border = 1>
		<tr>
			<td>제목</td>
			<td>${ event.event_title }</td>
		</tr>
		<tr>
			<td>이미지</td>
			<td><img src="<%= request.getContextPath()+"/resources/uploadEventImage/" %>${ event.event_image }" width="100" height="100"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${ event.event_context }</td>
		</tr>
	
		<tr>
			<td>이벤트 시작일</td>
			<td>${ event.event_start_date }</td>
		</tr>
	
		<tr>
			<td>이벤트 마감일</td>
			<td>${ event.event_end_date }</td>
		</tr>
		<tr>
			<td>할인종류</td>
			<td>${ event.event_discount_kind }</td>
		</tr>
		<tr>
			<td>할인금액</td>
			<td>${ event.event_discount_amount }</td>
		</tr>
	
		<tr>
			<td colspan = 2>
				
				<a href = "eventList.ev"><input type = "button" value = "목록보기"></a>
			</td>
		</tr>
		
		<tr>
			<td colspan = 2>
				<input type="button" value="이벤트 참여하기" onClick="joinEvent(${ event.event_num },'${ event.event_discount_kind }', '${ event.event_discount_amount }', '${ user_id }' )">
			</td>
		</tr>
		
	</table>
</c:if>