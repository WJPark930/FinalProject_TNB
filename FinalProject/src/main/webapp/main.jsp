<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%@include file="/resources/include/header.jsp" %>
	
	<!-- 캘린더용 -->
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

	<!-- 페이지 css,js -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/shop/main_style.css?after">
	<script src="<%=request.getContextPath()%>/resources/script/search.js?after"></script>


	<div class="container-fluid min-vh-100" id="container">
		<div id="main_banner_area" style="background-image: url('<%=request.getContextPath()%>/resources/assets/image/메인배너.svg');">
			<div class="container" id="search_area">
				<div id="search_content_area" class="text-center">
					<h2>여행지 검색</h2>
					<form action=""  method="post" id="search_form">
						<div>
							<input type="text" name="search_keyword" class="search_travel dropdown-toggle"  id="dropdown_search" data-bs-toggle="dropdown" aria-expanded="false" autocomplete='off'
							placeholder="여행지나 숙소를 입력해주세요" style="background-image: url('<%=request.getContextPath()%>/resources/assets/icon/home_icon.svg');">
							<ul class="dropdown-menu search_travel_menu " aria-labelledby="dropdown_search">
								<li><a class="dropdown-item" href="#">Action</a></li>
								<li><a class="dropdown-item" href="#">Another action</a></li>
								<li><a class="dropdown-item" href="#">Something else here</a></li>
								<li><a class="dropdown-item" href="#">Something else here</a></li>
								<li><a class="dropdown-item" href="#">Something else here</a></li>
								<li><a class="dropdown-item" href="#">Something else here</a></li>
							</ul>
						</div>
						<div>
							<div>
								<input type="button" class="search_calender"  id="txtDate"  
								style="background-image: url('<%=request.getContextPath()%>/resources/assets/icon/calender_icon.svg'); text-align: left; padding-top: 14px;"
								value="">
							</div>
						</div>
						<div>
							<input type="button" name="people" class="search_people"  href="#collapse_people" role="button" data-bs-toggle="collapse" aria-expanded="false" aria-controls="collapse_people"
							style="background-image: url('<%=request.getContextPath()%>/resources/assets/icon/people_icon.png'); text-align: left; padding-top: 14px;"
							value="인원 2 명">
							<div  class="collapse" id="collapse_people" style="position: absolute;">
								<div class="card card-body row" >
										<div class="people_text">인원선택</div>
										<div class="people_btn">
											<img onclick="minus_people()" src="<%=request.getContextPath()%>/resources/assets/icon/minus_btn.svg"/>
											<span id="people_count">2</span>
											<img onclick="plus_people()" src="<%=request.getContextPath()%>/resources/assets/icon/plus_btn.svg"/>
										</div>
								</div>
							</div>
						</div>
						<div>
							<input type="submit" value="검색" class="search_btn ">
						</div>
					</form>
				</div>
			</div>			
		</div>
	</div>
	
	<%@include file="/resources/include/footer.jsp" %>