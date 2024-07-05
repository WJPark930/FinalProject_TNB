<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%@include file="/resources/include/header.jsp" %>
	


	<!-- 페이지 css,js -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/shop/main_style.css?after">
	
	<%
		String[] region = {"서울","강릉","여수","부산","가평","제주도"};		
	%>
	
	<div class="container-fluid" id="container">
		<div id="main_banner_area" style="background-image: url('<%=request.getContextPath()%>/resources/assets/image/메인배너.svg');">
			<div class="container" id="search_area">
				<div id="search_content_area" class="text-center">
					<h2>여행지 검색</h2>
					<form action="search.sh" name="searchForm" method="get" >
						<%@include file="/resources/include/search.jsp" %>
					</form>
				</div>
			</div>			
		</div>
	</div>

	<div class="container" id="content_container">
		<div class="region_area">
			<h2>추천 여행지</h2>
			<div class="category_list">
				
			</div>
		</div>
	</div>

	<%@include file="/resources/include/footer.jsp" %>