<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
		String[] column = {"추천순","최신순","평점높은순","평점낮은순"};
	%>
	
    <%@include file="/resources/include/header.jsp" %>
    <!-- 페이지 css,js -->
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=y7qvlog2u1&submodules=geocoder"></script>
	<script src="<%=request.getContextPath()%>/resources/script/shop_view.js?after"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/shop/shop_view.css?after">
    
    <form action="viewShop.sh" name="searchForm" method="get" >
    	<input type="hidden" name="shop_id" value="${param.shop_id}">
		<input type="hidden" name="keyword" value="${search.keyword}">
	   	<div class="container-fruid search_header_container">
			<div class="container search_header">
				<%@include file="/resources/include/search.jsp" %>
			</div>
		</div>		
	</form>
	
	<div class="container view_container">
		<div class="image_container">
			<c:forEach items="${shop_image}" var="image" end="6">
				<img src="<%=request.getContextPath()%>/resources/assets/image/${image}">
			</c:forEach>
		</div>
		
		<div class="content_container">
			<div class="content_info">
				<p>${shop_info.category_name}</p>
				<p>${shop_info.shop_name}</p>
				<p  class="grade_content"><img src="<%=request.getContextPath()%>/resources/assets/icon/Star_icon.png"><fmt:formatNumber value="${shop_info.grade}" pattern="#.#" /><span>${shop_info.review_count}명 리뷰</span></p>
				<div class="line"></div>
				<h2>숙소소개</h2>
				<p>${shop_info.shop_info}</p>
				<div class="line"></div>
				<h2>서비스 및 부대시설</h2>
				<p>
					<c:forEach items="${shop_service}" var="service">
						<span>${service.service_name}</span>
					</c:forEach>
				</p>
				<div class="line"></div>
				<div id="shop_room">
					<h2>객실 선택</h2>
					<c:forEach items="${shop_room}" var="room">
						<div class="room_area">
							<div class="room_image_area">
								<img src="<%=request.getContextPath()%>/resources/assets/image/${room.image}">
							</div>
							<div class="room_text_area">
								<p class="room_name">${room.room_name}</p>
								<div class="room_info_area">
									<div class="room_time_people_area">
										<p class="sub_title">인원</p>
										<p>기준 ${room.standard_people}인</p>
										<p>최대 ${room.max_people}인</p>
										<p class="sub_title">시간</p>
										<p>입실 ${room.check_in}:00</p>
										<p>퇴실 ${room.check_out}:00</p>
									</div>
									<div class="room_price_area">
										<p><fmt:formatNumber value="${room.price}" pattern="#,###" /> 원<span>/1박당</span></p>
										<c:if test="${room.room_count==0}"><p>다른 날짜 확인</p></c:if>
										<c:if test="${room.room_count>0}"><button>객실예약</button></c:if>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="line"></div>
				<h2>숙박 이용정보</h2>
				<c:forEach items="${shop_guide}" var="guide">
					<p class="guide_title">${guide.guide_title}</p>
					<p class="guide_content">${guide.guide_content}</p>
				</c:forEach>
				<div class="review_sort">
					<p  class="grade_content"><img src="<%=request.getContextPath()%>/resources/assets/icon/Star_icon.png"><fmt:formatNumber value="${shop_info.grade}" pattern="#.#" /><span>${shop_info.review_count}명 리뷰</span></p>
					<label class="reviewColumn dropdown-toggle"  id="dropdown_reviewColumn" data-bs-toggle="dropdown" aria-expanded="false">
					<img src="<%=request.getContextPath()%>/resources/assets/icon/sort_icon.svg">
					 추천순
					</label>
					<ul class="dropdown-menu reviewColumn_menu" aria-labelledby="dropdown_reviewColumn">
						<c:forEach items="<%=column%>" var="column">
							<li><a class="dropdown-item" href="javascript:selectReview('${column}')">${column}</a></li> 
						</c:forEach>
					</ul>
				</div>
				<div class="line"></div>
				<div class="review_area">
					<c:forEach items="${shop_review}" var="review">
						<div class="review_content_area">
							<div class="review_header">
								<img src="<%=request.getContextPath()%>/resources/assets/image/${review.user_image}">
								<div class="user_info">
									${review.user_nickname}
									<c:set var="gradeCnt"  value="0" />
									<fmt:parseNumber var="gradeInt" value="${review.grade}" integerOnly="true" />
									<c:forEach begin="1" end="${gradeInt/2}">
										<img src="<%=request.getContextPath()%>/resources/assets/icon/Star_full_icon.svg">
										<c:set var="gradeCnt"  value="${gradeCnt+1}" />
									</c:forEach>
									<c:if test="${review.grade%2!=0}">
										<img src="<%=request.getContextPath()%>/resources/assets/icon/Star_half_icon.svg">
										<c:set var="gradeCnt"  value="${gradeCnt+1}" />
									</c:if>
									<c:forEach begin="1" end="${5-gradeCnt}">
										<img src="<%=request.getContextPath()%>/resources/assets/icon/Star_empty_icon.svg">
									</c:forEach>
								</div>		
								<div class="recommend_box">
									<p>
										<c:set var="recommend_my"  value="false" />
										<c:forEach items="${review_recommend}" var="recommend">									
											<c:if test="${recommend.review_id==review.review_id}">
												<c:set var="recommend_my"  value="true" />
											</c:if>
										</c:forEach>
										<c:if test="${recommend_my == 'true'}">
											<img id="recommend_unlike${review.review_id}" 
											src="<%=request.getContextPath()%>/resources/assets/icon/recommend_icon.svg" onclick="recommend('unlike','${review.review_id}',${loginInfo.user_id})"
											style="display: none;">
											<img id="recommend_like${review.review_id}" 
											src="<%=request.getContextPath()%>/resources/assets/icon/recommend_like_icon.svg" onclick="recommend('like','${review.review_id}',${loginInfo.user_id})" >	
										</c:if>
										<c:if test="${recommend_my == 'false'}">
											<img id="recommend_unlike${review.review_id}" src="<%=request.getContextPath()%>/resources/assets/icon/recommend_icon.svg" onclick="recommend('unlike','${review.review_id}',${loginInfo.user_id})">
											<img id="recommend_like${review.review_id}" src="<%=request.getContextPath()%>/resources/assets/icon/recommend_like_icon.svg" onclick="recommend('like','${review.review_id}',${loginInfo.user_id})" 
											style="display: none;">										
										</c:if>
										<span id="recommend_count${review.review_id}">${review.recommend}</span>명이 추천함
									</p>
								</div>						
							</div>
							<div class="review_image">
								<c:forEach  items="${review_image}" var="reviewImage">
									<c:if test="${reviewImage.review_id == review.review_id}">
										<div class="review_image_box">
											<img src="<%=request.getContextPath()%>/resources/assets/image/${reviewImage.image}">
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="review_text">
								<p>${review.room_name}</p>
								<p>${review.review_content}</p>
							</div>
						</div>
						<div class="line"></div>
						
					</c:forEach>
				</div>
			</div>
			<div class="content_nav">
				<div class="map_area"> 
					<div class="map">
						<div id="map" style="width:100%;height:160px;"></div>
					</div>
					<div class="address_area" > 
						<input type="text" id="address" disabled value="${shop_info.shop_address}"></input>
						<img src="<%=request.getContextPath()%>/resources/assets/icon/copy_icon.svg" onclick="copy()">
					</div>
				</div>
				<div class="nav_area">
					<button data-scroll="shop_info">숙소정보</button>
					<button data-scroll="shop_room">객실</button>
					<button>리뷰</button>
					<button data-scroll="shop_room">객실예약</button>
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="/resources/include/footer.jsp" %>