<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %> 
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %> 

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/reservation/reservation.css?after">

<fmt:setLocale value="ko_KR" />

<%
    reservation.model.RoomReservationBean rrb = (reservation.model.RoomReservationBean) request.getAttribute("rrb");
    reservation.model.ReservationBean rb = (reservation.model.ReservationBean)request.getAttribute("rb");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat displayFormat = new SimpleDateFormat("M/d(E)", java.util.Locale.KOREAN);
    
    String currentDate = sdf.format(new java.util.Date());
    pageContext.setAttribute("currentDate", currentDate);
    
    Date checkinDate = sdf.parse(rb.getRoom_checkin_date());
    Date checkoutDate = sdf.parse(rb.getRoom_checkout_date());
    
    
    String formattedCheckinDate = displayFormat.format(checkinDate);
    String formattedCheckoutDate = displayFormat.format(checkoutDate);
%>


<script>
    function gotoCancel(order_num) {
        if (confirm("정말로 취소하시겠습니까?")) {
            window.location.href = "gotoCancel.pay?order_num=" + order_num;
        }
    }
    
    function gotoMyReservation(user_id) {
    	window.location.href = "showAllMyReservation.rv?user_id=" + user_id;
    }
</script>

<div class="container-fruid min-vh-100 content_container" id="content_container">
 
	<div class="content_mypage container">
	
	   <%@include file="/resources/include/my_aside.jsp" %>
	   
		<div class="content_area">
			<div class="reservation_content_area">
				<div class="reservation_box">
					<p class="shop_name_text">${rb.shop_name}</p>
					<div class="line"></div>
					<h2>- 시설정보 -</h2>
					<p>객실명: <span>${ rb.room_name }</span></p>
					<p>인원: <span>${ rb.room_reserve_quantity }인</span></p>
					<p>기간: <span><%= formattedCheckinDate %> ~ <%= formattedCheckoutDate %></span></p>
					<p>예약자: <span>${ mb.user_name }</span></p>
					<p>예약자 번호: <span>${ mb.user_phone }</span></p>
					<div class="line"></div>
					<c:if test="${ rb.train_no != 0 }">
						<h2>- 교통정보 -</h2>
						<p>출발역: <span>${ rb.depPlaceName }</span></p>
						<p>도착역: <span>${ rb.arrPlaceName }</span></p>
						<p>출발시간: <span>
							<c:set var="depPlandTime" value="${ rb.depPlandTime }" />
							<c:set var="depPlandTimeWithoutNano" value="${fn:substringBefore(depPlandTime, '.')}" />
							<fmt:parseDate value="${depPlandTimeWithoutNano}" pattern="yy/MM/dd HH:mm:ss" var="parsedDepPlandTime" />
							<fmt:formatDate value="${parsedDepPlandTime}" pattern="yyyy년 M월 d일 H시 m분" />
						</span></p>
						<p>도착시간: <span>
							<c:set var="arrPlandTime" value="${rb.arrPlandTime}" />
							<c:set var="arrPlandTimeWithoutNano" value="${fn:substringBefore(arrPlandTime, '.')}" />
							<fmt:parseDate value="${arrPlandTimeWithoutNano}" pattern="yy/MM/dd HH:mm:ss" var="parsedArrPlandTime" />
							<fmt:formatDate value="${parsedArrPlandTime}" pattern="yyyy년 M월 d일 H시 m분" />
							 (${ rb.duration })	
						</span></p>
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
				<div class="image_box">
					<img src="<%=request.getContextPath()%>/resources/assets/image/${ shopImage }" width="100" height="70">
				</div>
			</div>	
			<c:if test="${review != null}">
				<div class="reservation_content_area">
					<div>
						<p class="review_name">${rb.shop_name} <span> <img src="<%=request.getContextPath()%>/resources/assets/icon/Star_icon.png"> ${review.grade}점</span></p>
						<p class="review_content">${review.review_content}</p>
					</div>
					<div>
						<i class="bi bi-pencil-fill" onclick="location.href='review_update.mp?review_id=${review.review_id}'"></i>
						<i class="bi bi-trash3-fill ms-2"  onclick="delete_check()"></i>
					</div>
				</div>
			</c:if>
			
			<input type = "button" class="btn btn-secondary" value = "예약목록" onClick = "gotoMyReservation('${ mb.user_id }')">
			<c:if test="${review == null}">
					<button class="btn btn-primary" onclick="location.href='review_insert.mp?shop_name=${rb.shop_name}&reservation_id=${order_num}'">리뷰 추가</button>
			</c:if>
			<input type = "button" class="btn btn-danger" value = "예약취소" onClick = "gotoCancel('${ rb.order_num}')">

			</div>	
		</div>
	</div>



<script>

	function delete_check(){
		if(confirm("삭제하겠습니까?")){
			location.href='review_delete.mp?review_id=${review.review_id}&order_num=${ rb.order_num}';
			alert("삭제완료");
		}
	}

</script>

<%@include file="/resources/include/footer.jsp" %>