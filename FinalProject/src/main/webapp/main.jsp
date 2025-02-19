<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%@include file="/resources/include/header.jsp" %>
	<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

	<!-- 페이지 css,js -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/shop/main_style.css?after">
						
	<%
		String[] region = {"서울","강릉","여수","부산","가평","제주"};
		String[] category = {"모텔","호텔·리조트","펜션·풀빌라","캠핑","게스트하우스"};		
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
			<div class="btn_list">
				<input type="radio" name="region" 
				class="btn-check" id="btn-check"autocomplete="off" checked value="전체" onclick="shop_list('전체','region')">
				<label class="btn btn-primary" for="btn-check">전체</label>
				<c:forEach  items="<%=region%>" var="region" varStatus="vs">
					<input type="radio" name="region" 
					class="btn-check" id="btn-check-${vs.count}"autocomplete="off" value="${region}" onclick="shop_list('${region}','region')">
					<label class="btn btn-primary" for="btn-check-${vs.count}">${region}</label>
				</c:forEach>
			</div> 
			<div class="region_list">				
			</div>
		</div>
		<div class="category_area">
			<h2>인기 추천 숙소</h2>
			<div class="btn_list">
				<input type="radio" name="category" 
				class="btn-check" id="btn-check-cate"autocomplete="off" checked value="전체" onclick="shop_list('전체','category')">
				<label class="btn btn-primary" for="btn-check-cate">전체</label>
				<c:forEach  items="<%=category%>" var="category" varStatus="vs">
					<input type="radio" name="category" 
					class="btn-check" id="btn-check-cate-${vs.count}"autocomplete="off" value="${region}" onclick="shop_list('${category}','category')">
					<label class="btn btn-primary" for="btn-check-cate-${vs.count}">${category}</label>
				</c:forEach>
			</div> 
			<div class="category_list">				
			</div>
		</div>
	</div>

	<script>
		function shop_list(word,type){
			let list_div = null;
			if(type == 'region'){
				list_div = $('.region_list'); 
			}else{
				list_div = $('.category_list'); 
			}

			$.ajax({
				type: 'GET',
				url: 'region_list.sh',
				data: { 'word': word ,
						'type': type		
				},
				dataType: "json",
				success: function(response) {   
					let list = "";
					list_div.empty();
					$.each(response, function(index, shop) { 	
						list = "";
						console.log(shop);
						console.log(index);
						console.log(shop.shop_id);
						console.log(shop.category_name);
						console.log(shop.shop_name);
						let grade = Number(shop.grade).toFixed(1);
						let price = Number(shop.price).toLocaleString('ko-KR');
						let abc = shop.image;
						console.log("abc:"+abc)				
						list += '<div class="content_box" onclick="viewPage('+shop.shop_id+',`'+shop.shop_name+'`)">'
						list +=		`<div class="content_img">`
						list +=		'<img src="<%=request.getContextPath()%>/resources/assets/image/'+abc+'">'
						list +=			`</div>`
						list +=	`<div class="content_text">`
						list +=			'<p class="content_category_name">'+shop.category_name+'</p>'
						list +=					'<p class="content_shop_name">'+shop.shop_name+'</p>'
						list +=					`<div class="price_grade_box">`
						list +=						'<p class="content_price">'+price+'원 <span>/1박당</span></p>'
						list +=						'<p class="content_grade"><img src="<%=request.getContextPath()%>/resources/assets/icon/Star_icon.png">'+grade+'</p>'
						list +=					`</div>`
						list +=				`</div>`
						list +=			`</div>`
						list_div.append(list);
					});
				},
				error: function (xhr) {
					console.error('오류:', xhr);
				}
			});
		}
		window.addEventListener('load', function() {
			shop_list("전체","region");
			shop_list("전체","category");
		});

		function viewPage(shop_id,shop_name){
			// console.log(shop_id);
			// console.log(shop_name);

			let currentDate = new Date();
			let calender = document.querySelector('.search_calender');
			let calender_word = calender.value.split('~');
			let peopleForm = document.querySelector('.search_people');
			let people_word = peopleForm.value.split(' ');

			let people = people_word[1];
			let day1 = currentDate.getFullYear()+"-"+calender_word[0];
			let day2 =  currentDate.getFullYear()+"-"+calender_word[1];

			location.href="viewShop.sh?shop_id="+shop_id+"&keyword="+shop_name+"&day1="+day1+"&day2="+day2+"&people="+people;

		}
	</script>

	<%@include file="/resources/include/footer.jsp" %>
	
