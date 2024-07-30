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
			<div class="main_image">
				<img src="<%=request.getContextPath()%>/resources/assets/image/${shop_image[0]}">
			</div>
			<div class="sub_image_area">
				<c:forEach items="${shop_image}" var="image" end="4" varStatus="vs">
					<c:if test="${vs.index!=0}">
						<div class="sub_image">
							<img src="<%=request.getContextPath()%>/resources/assets/image/${image}">
						</div>
					</c:if>
				</c:forEach>
				<button onclick="shopImgAll()"><i class="bi bi-image"></i></button>
			</div>
		</div>
		
		<div class="content_container">
			<div class="content_info">
				<p class="category_name_text">${shop_info.category_name}</p>
				<p class="shop_name_text">${shop_info.shop_name}</p>
				<p  class="grade_content"><img src="<%=request.getContextPath()%>/resources/assets/icon/Star_icon.png"><fmt:formatNumber value="${shop_info.grade}" pattern="#.#" /><span>${shop_info.review_count}명 리뷰</span></p>
				<div class="line"></div>
				<div class="content_margin">
					<h2>숙소소개</h2>
					<p>${shop_info.shop_info}</p>
				</div>
				<div class="line"></div>
				<div class="content_margin">
					<h2>서비스 및 부대시설</h2>
					<p>
						<c:forEach items="${shop_service}" var="service">
							<span>${service.service_name}</span>
						</c:forEach>
					</p>
				</div>
				<div class="line"></div>
				<div id="shop_room" class="content_margin">
					<h2>객실 선택</h2>
					<c:forEach items="${shop_room}" var="room">
						<div class="room_area">
							<div class="room_image_area">
								<img src="<%=request.getContextPath()%>/resources/assets/image/${room.image}">
								<button onclick="roomImgAll(${room.room_id})"><i class="bi bi-image"></i></button>
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
										<c:if test="${room.room_count<=0}"><p>다른 날짜 확인</p></c:if>
										<c:if test="${room.room_count>0}"><a href = "roomReservation.rv?shop_id=${param.shop_id}&room_id=${room.room_id}&room_checkin_date=${search.day1}&room_checkout_date=${search.day2}&room_price=${room.price}&room_quantity=${room.max_people}&people=${search.people}"><button>객실예약</button></a></c:if>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="line"></div>
				<div class="content_margin">
					<h2>숙박 이용정보</h2>
					<c:forEach items="${shop_guide}" var="guide">
						<p class="guide_title">${guide.guide_title}</p>
						<p class="guide_content">${guide.guide_content}</p>
					</c:forEach>
				</div>
				<div class="review_sort" id="shop_review">
					<p  class="grade_content"><img src="<%=request.getContextPath()%>/resources/assets/icon/Star_icon.png"><fmt:formatNumber value="${shop_info.grade}" pattern="#.#" /><span>${shop_info.review_count}명 리뷰</span></p>
					<label class="reviewColumn dropdown-toggle"  id="dropdown_reviewColumn" data-bs-toggle="dropdown" aria-expanded="false">
					<!-- <img src="<%=request.getContextPath()%>/resources/assets/icon/sort_icon.svg">
					 추천순
					</label>
					<ul class="dropdown-menu reviewColumn_menu" aria-labelledby="dropdown_reviewColumn">
						<c:forEach items="<%=column%>" var="column">
							<li><a class="dropdown-item" href="javascript:selectReview('${column}')">${column}</a></li> 
						</c:forEach>
					</ul> -->
				</div>
				<div class="line"></div>
				<div class="review_area">
					<c:forEach items="${shop_review}" var="review">
						<div class="review_content_area">
							<div class="review_header">
								<div class="review_header_user">
									<div class="user_image_area">
										<img src="<%=request.getContextPath()%>/resources/images/${review.user_image}">
									</div>
									<div class="user_info">
										<p>${review.user_nickname}님</p>
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
							<c:set var="image_check" value="0"/>
							<div class="content_slide_box review_num${review.review_id}">
								<input type="hidden" class="currentIndex" value="0">
								<div class="slide_box_area">
									<div class="content_slide_view">
										<div class="review_image slide_inner">		
											<c:forEach  items="${review_image}" var="reviewImage">
												<c:if test="${reviewImage.review_id == review.review_id}">
													<c:set var="image_check" value="${image_check+1}"/>
													<div class="review_image_box">
														<img src="<%=request.getContextPath()%>/resources/assets/image/${reviewImage.image}">
													</div>
												</c:if>
											</c:forEach>
										</div>
									</div>
									<c:if test="${image_check>4}">
										<div class="slider__btn">
											<div class="prev" onclick="slider_btn(${review.review_id},'prev',${image_check})">
												<img src="<%=request.getContextPath()%>/resources/assets/icon/left_slide_icon.svg">				
											</div>
											<div class="next" onclick="slider_btn(${review.review_id},'next',${image_check})">
												<img src="<%=request.getContextPath()%>/resources/assets/icon/right_slide_icon.svg">											
											</div>
										</div>
									</c:if>
								</div>
							</div>							
							<div class="review_text">
								<fmt:parseDate value="${review.review_date}" var="day" pattern="yyyy-MM-dd"/>
								<p>${review.room_name} - <fmt:formatDate value="${day}" pattern="yyyy.MM.dd"/></p>
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
					<button data-scroll="shop_review">리뷰</button>
					<button data-scroll="shop_room">객실예약</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal_bg" onClick="javascript:popClose();"></div>
	<div class="modal_wrap_room modal_wrap">
		<div class="modal_header">
			<p>${shop_info.shop_name}</p>
		</div>
		<div class="madal_image">
			<img class="room_main_image" src="">
		</div>
		<div class="madal_slide_box">
			<div class="slide_madal_area">
				<div class="madal_slide_view">
					<div class="madal_image_list slide_madal_inner">		

					</div>
				</div>
				<div class="slider_madal_btn">
					<div class="prev" onclick="madal_slider_btn('prev')">
						<img src="<%=request.getContextPath()%>/resources/assets/icon/left_slide_icon.svg">				
					</div>
					<div class="next" onclick="madal_slider_btn('next')">
						<img src="<%=request.getContextPath()%>/resources/assets/icon/right_slide_icon.svg">											
					</div>
				</div>
			</div>
		</div>	
	</div>
	<div class="modal_wrap_shop modal_wrap p-3">
		<div class="modal_header">
			<p>${shop_info.shop_name}</p>
		</div>
		<div class="madal_image">
			<img class="shop_main_image" src="">

		</div>
		<div class="madal_slide_box">
			<div class="slide_madal_area">
				<div class="madal_slide_view">
					<div class="madal_image_list slide_madal_inner">		
						
					</div>
				</div>
				<div class="slider_madal_btn">
					<div class="prev" onclick="madal_slider_btn('prev')">
						<img src="<%=request.getContextPath()%>/resources/assets/icon/left_slide_icon.svg">				
					</div>
					<div class="next" onclick="madal_slider_btn('next')">
						<img src="<%=request.getContextPath()%>/resources/assets/icon/right_slide_icon.svg">											
					</div>
				</div>
			</div>
		</div>

	</div>
	
	
	
	<script>
		let sliderWidthM = 110;
		let currentIndex = 0;
		let sliderCountM = 0;

		function roomImgAll(room_id) {

			var modalPop_room = $('.modal_wrap_room');
			var modalBg = $('.modal_bg'); 
			var arr = new Array();
			
			<c:forEach items="${room_image}" var="img">
				if(room_id=="${img.room_id}"){
					arr.push({
						image : "${img.image}"
					})
				}
			</c:forEach>
			let list = "";
			let first_image;
			for(var i=0;i<arr.length;i++){
				//console.log(i+":"+arr[i].image);
				let image_src = "<%=request.getContextPath()%>/resources/assets/image/"+arr[i].image;
				if(i==0){
					list += `<div class="modal_img_box room_img_box_1" onClick="mainImg('`+image_src+`','room',this)" ><img src='`+image_src+`'></div>`;				
					first_image = image_src;
				}else{
					list += `<div class="modal_img_box" onClick="mainImg('`+image_src+`','room',this)" ><img src='`+image_src+`'></div>`;				
				}
			}	
			let image_div = $(".modal_wrap_room .madal_image_list");
			image_div.empty();
			image_div.append(list);
			mainImg(first_image,'room',document.querySelector(".room_img_box_1"));

			currentIndex = 0;
			sliderCountM = 0;
			$('.madal_image_list').css("transform" ,"translateX(0px)");

			if(arr.length>9){
				sliderCount = arr.length - 8;
			}

			$(modalPop_room).show();
			$(modalBg).show();

		}

		function shopImgAll() {

			var modalPop_shop = $('.modal_wrap_shop');
			var modalBg = $('.modal_bg'); 

			var arr = new Array();
			
			<c:forEach items="${shop_image}" var="img">
				arr.push({
					image : "${img}"
				})
			</c:forEach>
			let list = "";
			let first_image;
			for(var i=0;i<arr.length;i++){
				//console.log(i+":"+arr[i].image);
				let image_src = "<%=request.getContextPath()%>/resources/assets/image/"+arr[i].image;
				if(i==0){
					list += `<div class="modal_img_box shop_img_box_1" onClick="mainImg('`+image_src+`','shop',this)" ><img src='`+image_src+`'></div>`;				
					first_image = image_src;
				}else{
					list += `<div class="modal_img_box" onClick="mainImg('`+image_src+`','shop',this)" ><img src='`+image_src+`'></div>`;				
				}
			}	
			let image_div = $(".modal_wrap_shop .madal_image_list");
			image_div.empty();
			image_div.append(list);
			mainImg(first_image,'shop',document.querySelector(".shop_img_box_1"));

			currentIndex = 0;
			sliderCountM = 0;
			$('.madal_image_list').css("transform" ,"translateX(0px)");
			
			if(arr.length>8){
				sliderCountM = arr.length - 7;
			}

			$(modalPop_shop).show();
			$(modalBg).show();

		}

		
		function madal_slider_btn(type){
				console.log("currentIndex:"+currentIndex);
				console.log("sliderCountM:"+sliderCountM);
				let prevIndex = (currentIndex + sliderCountM-1) % sliderCountM
				let nextIndex = (currentIndex + 1) % sliderCountM

				if(type=="prev"){
					madal_gotoSlider(prevIndex);
				} else {
					madal_gotoSlider(nextIndex);
				}
		}

		function madal_gotoSlider(num){
			$('.madal_image_list').css("transition" , "all 400ms")
			$('.madal_image_list').css("transform" ,"translateX("+ -sliderWidthM * num+"px)");

			currentIndex = num;
		}


	</script>
	
	<%@include file="/resources/include/footer.jsp" %>