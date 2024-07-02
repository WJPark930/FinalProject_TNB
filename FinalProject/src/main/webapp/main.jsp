<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%@include file="/resources/include/header.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/shop/main_style.css">

	<div class="container-fluid min-vh-100" id="container">
		<div id="main_banner_area" style="background-image: url('<%=request.getContextPath()%>/resources/assets/image/메인배너.svg');">
			<div class="container" id="search_area">
				<div id="search_content_area" class="text-center">
					<h2>여행지 검색</h2>
					<form action=""  method="post" id="search_form">
						<div>
							<input type="text" name="search_keyword" class="search_travel"
							placeholder="여행지나 숙소를 입력해주세요" style="background-image: url('<%=request.getContextPath()%>/resources/assets/icon/home_icon.svg');">
						</div>
						<div>
							<input type="text" name="period" class="search_calender"
							style="background-image: url('<%=request.getContextPath()%>/resources/assets/icon/calender_icon.svg');"
							
							>
						</div>
						<div>
							<input type="button" name="people" class="search_people"  href="#collapseExample" role="button" data-bs-toggle="collapse" aria-expanded="false" aria-controls="collapse_people"
							style="background-image: url('<%=request.getContextPath()%>/resources/assets/icon/people_icon.png');"
							
							>
							<div  class="collapse" id="collapseExample" style="position: absolute;">
								<div class="card card-body" >
									<span>인원선택</span>
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