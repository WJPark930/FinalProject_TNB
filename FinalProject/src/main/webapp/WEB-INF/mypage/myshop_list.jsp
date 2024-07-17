<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <%@include file="/resources/include/header.jsp" %>
    
    <script src="<%=request.getContextPath()%>/resources/script/mypage/mypage_shop.js?after"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/mypage/myshop.css?after">

    <div class="container-fruid min-vh-100 " id="content_container">
 
        <div class="content_mypage container">
            <div class="aside_mypage">
                <div class="aside_menu_mypage">
                    <a href="myshop_list.mp">시설 관리</a>
                    <a href="review_list.mp">내 리뷰</a>
                </div>
            </div>
            <div class="content_area">
                <h2>내 시설 목록</h2>
                <button onclick="addShop(${list_count})">시설 등록</button>
                <div class="list_area row gap-3">
                	<c:if test="${list_count>0}">
                		<c:forEach items="${shop_list}" var="shop">
	                		<div class="content_box col-3" onclick="location.href='myshop_detail.mp?shop_id=${shop.shop_id}'">
	                            <div class="content_img">
	                                <img src="<%=request.getContextPath()%>/resources/assets/image/${shop.image}">
	                            </div>
	                            <div class="content_text">
	                                <p class="content_category_name">${shop.category_name}</p>
	                                <p class="content_shop_name">${shop.shop_name}</p>
	                                <p class="content_grade"><img src="<%=request.getContextPath()%>/resources/assets/icon/Star_icon.png"><fmt:formatNumber value="${shop.grade}" pattern="#.#" /></p>
	                            </div>
	                        </div>                        
                		</c:forEach>
                	</c:if>
                	<c:if test="${list_count<=0}">
                		<div class="col-12">
	                		<p>등록된 시설이 없습니다.</p>
                		</div>
                	</c:if>                
                </div>
                
            </div>
        </div>

    </div>    
    
    <%@include file="/resources/include/footer.jsp" %>