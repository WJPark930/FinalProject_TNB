<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
	<%
		String[] column = {"평점높은순","리뷰많은순","낮은가격순","높은가격순"};
	%>

	<%@include file="/resources/include/header.jsp" %>
	<!-- 페이지 css,js -->
	<script src="<%=request.getContextPath()%>/resources/script/shop_list.js?after"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/shop/shop_list.css?after">
	
	<form action="search.sh" name="searchForm" method="get" >
	 
	<div class="container-fruid search_header_container">
		<div class="container search_header">
			<%@include file="/resources/include/search.jsp" %>
		</div>
	</div>

	<div class="container min-vh-100 " id="content_container">
		<div class="aside_filter">
			<div class="category_area">
				<p>
				<input type="radio" name="category_id" value="0"
					<c:if test="${search.category_id==0}">checked</c:if>
				 > 전체</p>
				<c:forEach  items="${list_category}" var="category"> 
					<p><input type="radio" name="category_id" value="${category.category_id}"				
						<c:if test="${search.category_id==category.category_id}">checked</c:if>				
					> ${category.category_name}</p> 
				</c:forEach>
			</div>
			<div class="line">
				<img src="<%=request.getContextPath()%>/resources/assets/image/side_Line.svg" style="width:275px;" >
			</div>
			<div class="price_area">
			    <label class="price_range_text" >가격 <span>1박기준</span></label>
				<input type="range" name="price_range" class="price_range" min="1" max="6"
				value="${search.price_range}">
				<p>0원 ~ <c:if test="${search.price_range!=6}"> <fmt:formatNumber value="${search.price}" pattern="#,###" />원 이하</c:if><c:if test="${search.price_range==6}">500,000원 이상</c:if></p>
			</div>
			<div class="line">
				<img src="<%=request.getContextPath()%>/resources/assets/image/side_Line.svg" style="width:275px;" >
			</div>
			<div class="service_area">
            <c:forEach  items="${list_service}" var="service">
               <input type="checkbox" name="service" 
               class="btn-check" id="btn-check-${service.service_id}"autocomplete="off"
               <c:forEach items="${fn:split(search.service,',')}" var="service_choice">
                  <c:if test="${service_choice == service.service_id}"> checked </c:if>
               </c:forEach>               
               value="${service.service_id}">
               <label class="btn btn-primary" for="btn-check-${service.service_id}">${service.service_name}</label>
            </c:forEach>
         </div>
		</div>
		<div class="content_list_area">
			<input type="hidden" name="pageNumber" value="${pageNumber}">
			<div class="content_list_top">
				<h2>'${search.keyword}' 검색결과 ${pageInfo.totalCount}건</h2>
				
				<input type="hidden" name="whatColumn" value="<c:if test='${whatColumn==null}'>평점높은순</c:if><c:if test='${whatColumn!=null}'>${whatColumn}</c:if>">
				<input type="button"  class="whatColumn dropdown-toggle"  id="dropdown_whatColumn" data-bs-toggle="dropdown" aria-expanded="false" autocomplete='off'
				 style="background-image: url('<%=request.getContextPath()%>/resources/assets/icon/list_arrow_icon.svg');"
				value="<c:if test='${whatColumn==null}'>평점높은순</c:if><c:if test='${whatColumn!=null}'>${whatColumn}</c:if>">
				<ul class="dropdown-menu whatColumn_menu" aria-labelledby="dropdown_whatColumn">
					<c:forEach items="<%=column%>" var="column">
						<li><a class="dropdown-item" href="javascript:selectItem('${column}')">${column}</a></li> 
					</c:forEach>
				</ul>
			</div>
			<div class="line"></div>
			  <c:forEach items="${list_shop}" var="shop">	
				<div class="content" onclick="location.href='viewShop.sh?shop_id=${shop.shop_id}&keyword=${shop.shop_name}&day1=${search.day1}&day2=${search.day2}&people=${search.people}'">
					<div class="content_img">
						<img src="<%=request.getContextPath()%>/resources/assets/image/${shop.image}">
					</div>
					<div class="content_text">						
						<c:forEach  items="${list_category}" var="category">
							 <c:if test="${shop.category_id==category.category_id}"><p class="category_content">${category.category_name}</p></c:if> 
						</c:forEach>
					  <p class="name_content">${shop.shop_name}</p>
					  <p  class="address_content">${shop.shop_address}</p>
					  <p  class="grade_content"><img src="<%=request.getContextPath()%>/resources/assets/icon/Star_icon.png"><fmt:formatNumber value="${shop.grade}" pattern="#.#" /><span>${shop.review_count}명 리뷰</span></p>
					  <p  class="price_content"><fmt:formatNumber value="${shop.price}" pattern="#,###" /> 원<span>/1박당</span></p>
					</div>
				</div>
 				<div class="line"></div>
			  </c:forEach>
			<div class="page_area">${pageInfo.pagingHtml}</div> 
		</div>
	</div>
	
	</form>

	<%@include file="/resources/include/footer.jsp" %>