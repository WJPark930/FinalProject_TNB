<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/event/event.css?after">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<%
    String[] event_discount_kind = {"할인 없음", "금액 차감", "비율 할인", "포인트 적립"};
    pageContext.setAttribute("event_discount_kind", event_discount_kind);
%>

<script>

window.addEventListener('DOMContentLoaded', (event) => {
    toggleDiscountAmount(); // 초기 상태 설정
});

	function toggleDiscountAmount() {
	    const discountKind = document.querySelector('input[name="event_discount_kind"]:checked');
	    const discountAmountContainer = document.getElementById('discountAmountContainer');
	    const selectedAmount = document.querySelector('input[name="event_discount_amount"]') ? document.querySelector('input[name="event_discount_amount"]').value : '';
	
	    // 초기화
	    discountAmountContainer.innerHTML = '';
	
	    const createRadioButton = (value, text) => {
	        const input = document.createElement('input');
	        input.type = 'radio';
	        input.classList.add('btn-check');
	        input.name = 'event_discount_amount';
	        input.id = 'radio-' + value;
	        input.value = value;
	        if (value == selectedAmount) input.checked = true;
	
	        const label = document.createElement('label');
	        label.classList.add('btn', 'btn-outline-success');
	        label.setAttribute('for', input.id);
	        label.textContent = text;
	
	        discountAmountContainer.appendChild(input);
	        discountAmountContainer.appendChild(label);
	    };
	
	    if (discountKind) {
	        const discountKindValue = discountKind.value;
	
	        if (discountKindValue === '금액 차감') {
	            [10000, 20000, 30000].forEach(amount => createRadioButton(amount, amount + '원'));
	        } else if (discountKindValue === '비율 할인') {
	            [3, 5, 7].forEach(rate => createRadioButton(rate, rate + '%'));
	        } else if (discountKindValue === '포인트 적립') {
	            [1000, 3000, 5000].forEach(amount => createRadioButton(amount, amount + '포인트'));
	        } else {
	            const input = document.createElement('input');
	            input.type = 'text';
	            input.name = 'event_discount_amount';
	            input.classList.add('form-control');
	            input.disabled = true;
	            discountAmountContainer.appendChild(input);
	        }
	    } else {
	        const input = document.createElement('input');
	        input.type = 'text';
	        input.name = 'event_discount_amount';
	        input.classList.add('form-control');
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
    function gotoList() {
    	location.href = "eventList.ev";
    }
</script>

<div id = content_container>
	<form:form commandName="event" name="eventInsertForm" action="eventInsert.ev" enctype="multipart/form-data" onsubmit="return checkData()">
	    <div class="container mt-4">
	        <div class="event-form">
	            <div class="text-center">
					<h2 >이벤트 등록하기</h2>
				</div>
	            <div class="event-form-body">
	                <div class="form-group">
	                    <label for="eventTitle">제목</label><form:errors path="event_title" cssClass="text-danger"/>
	                    <input type="text" class="form-control" id="eventTitle" name="event_title" value="${event.event_title}">
	                    
	                </div>
	                <div class="form-group">
	                    <label for="eventContext">내용</label><form:errors path="event_context" cssClass="text-danger"/>                
	                    <textarea class="form-control" id="exampleFormControlTextarea1" name="event_context" rows="3">${event.event_context}</textarea>	                   
	                    
	                </div>
					<div class="mb-3">
					    <label for="formFile" class="form-label">이미지</label><form:errors path="event_image" cssClass="text-danger"/>
					    <input class="form-control" type="file" id="formFile" name="upload" multiple>
					    
					</div>
	                <div class="form-group">
	                    <label>할인 종류</label>
	                    <div class="form-check">
	                        <c:forEach var="kind" items="<%= event_discount_kind %>">
	                            <input type="radio" class="form-check-input" name="event_discount_kind" value="${ kind }" 
	                                   <c:if test="${event.event_discount_kind eq kind || (event.event_discount_kind == null && kind eq '할인 없음')}">checked</c:if> 
	                                   onclick="toggleDiscountAmount()">
	                            <label class="form-check-label">${ kind }</label>
	                        </c:forEach>
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label for="discountAmount">할인 금액</label>
	                    <div id="discountAmountContainer">
	                        <input type="text" class="form-control" id="discountAmount" name="event_discount_amount" value="${event.event_discount_amount}">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label for="eventEndDate">종료일</label><form:errors path="event_end_date" cssClass="text-danger"/>
	                    <input type="date" class="form-control" id="eventEndDate" name="event_end_date" value="${event.event_end_date}">	                   
	                </div>
	                <div class="button-group">
		                <button type="submit" class="btn btn-primary">제출하기</button>	                
		                <button type="reset" class="btn btn-primary">취소</button>
		                <button type="button" class="btn btn-primary" onClick = "gotoList()">목록보기</button>
	                </div>
	            </div>
	        </div>
	    </div>
	</form:form>
</div>
<%@include file="/resources/include/footer.jsp" %>