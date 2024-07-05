<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%@include file="/resources/include/header.jsp" %>
	<!-- 페이지 css,js -->
	<script src="<%=request.getContextPath()%>/resources/script/shop_list.js?after"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/shop/shop_list.css?after">
	<form action="" name="searchForm" method="get" >

	<div class="container-fruid search_header_container">
		<div class="container search_header">
			<%@include file="/resources/include/search.jsp" %>
		</div>
	</div>

	<div class="container min-vh-100 " id="content_container">
		<div class="aside_filter">
			<div>
				<input type="radio" name="category_id" value="0"
					<c:if test="${search.category_id==null}">checked</c:if>
				 > 전체
				<c:forEach  items="${list_category}" var="category">
					<p><input type="radio" name="category_id" value="${category.category_id}"				
						<c:if test="${search.category_id==category.category_id}">checked</c:if>				
					> ${category.category_name}</p> 
				</c:forEach>
			</div>
			<div>
				<div class="price_slider">
			        <input type="range" id="input-left" min="1" max="100" value="1" />
			        <input type="range" id="input-right" min="1" max="100" value="100" />
			        <div class="track">
			          <div class="range"></div>
			          <div class="thumb left"></div>
			          <div class="thumb right"></div>
			        </div>
			      </div>
			</div>
		</div>
		<div class="content_list_area">
			<div>
				<table border="1">
				  <tr>
					<th>번호</th>
					<th>시설 이름</th>
					<th>주소</th>
					<th>상세주소</th>
					<th>리뷰수</th>
					<th>평점</th>
					<th>카테고리</th>
					<th>가격</th>
				  </tr>
				  <c:forEach items="${list_shop}" var="shop">
				  <tr>
						  <td>${shop.shop_id}</td>
						  <td>${shop.shop_name}</td>
						  <td>${shop.region}</td>
						  <td>${shop.shop_address}</td>
						  <td>${shop.grade}</td>
						  <td>${shop.review_count}</td>
						  <td>${shop.category_id}</td>
						  <td>${shop.price}</td>
				  </tr>
				  </c:forEach>
				</table>		
			</div>
		</div>
	</div>
	
	</form>

	<%@include file="/resources/include/footer.jsp" %>