<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
    
    <%@include file="/resources/include/header.jsp" %>
    
    <script src="<%=request.getContextPath()%>/resources/script/mypage/mypage_shop.js?after"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/mypage/myshop.css?after">

    <div class="container-fruid min-vh-100 " id="content_container">
 
        <div class="content_mypage container">
        
           <%@include file="/resources/include/my_aside.jsp" %>
           
            <div class="content_area">
                <div class="shop_info_area shop_content_area">
                	<p class="shop_name_text">${shop_info.shop_name}</p>
                	<p class="shop_record_text">${shop_info.category_name}
                    &nbsp;/&nbsp;<span><img src="<%=request.getContextPath()%>/resources/assets/icon/Star_icon.png"><fmt:formatNumber value="${shop_info.grade}" pattern="#.#" /></span>
                	&nbsp;${shop_info.review_count}명 리뷰함</p>
                	<h2>숙소 소개</h2>
                	<p>${shop_info.shop_info}</p>
        	        <h2>서비스 및 부대 시설</h2>
                	<p>
                	<c:forEach items="${shop_service}" var="service">
                		<span>${service.service_name}</span>
                	</c:forEach>
                	</p>
                </div>
                <div class="accordion">
                    <div class="shop_image_area accordion-item shop_content_area">
                        <h2 class="accordion-header" id="headingOne">
                          <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            숙소 이미지
                          </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                          <div class="accordion-body row gap-1">
                            <c:forEach items="${shop_image}" var="image">
                            	<div class="shop_img_box">
                            		<img src="<%=request.getContextPath()%>/resources/assets/image/${image}">
                            	</div>
                            </c:forEach>
                          </div>
                        </div>
                    </div>
                    <div class="shop_guide_area shop_content_area accordion-item">
                        <h2 class="accordion-header" id="headingTwo">
                          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                            숙소 이용정보
                          </button>
                        </h2>
                        <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                          <div class="accordion-body">                            
							<c:forEach items="${shop_guide}" var="guide">
								<p class="guide_title">${guide.guide_title}</p>
								<p class="guide_content">${guide.guide_content}</p>
							</c:forEach>
                          </div>
                        </div>
                    </div>
                    <div class="shop_room_area shop_content_area accordion-item">
                        <h2 class="accordion-header" id="headingThree">
                          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                            객실
                          </button>
                        </h2>
                        <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                          <div class="accordion-body">
                          	<div class="text-end">
                            	<button class="btn btn-primary room_add_btn" onclick="location.href='insert_room.mp?shop_id=${shop_info.shop_id}'">객실 추가</button>
                            </div>
                            <c:forEach items="${shop_room}" var="room">
                                <div class="room_area">
                                    <div class="room_image_area">
                                        <img src="<%=request.getContextPath()%>/resources/assets/image/${room.image}">
                                    </div>
                                    <div class="room_text_area">
                                    	<div class="room_top_area">
	                                        <p class="room_name">${room.room_name}</p>
	                                        <div>
	                                        	<i class="bi bi-pencil btn btn-success" onclick="updateRoomMove(${shop_info.shop_id},${room.room_id})"></i>
	                                        	<i class="bi bi-trash3 btn btn-danger" onclick="deleteRoomCheck(${shop_info.shop_id},${room.room_id})"></i>
	                                        </div>
                                    	</div>
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
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>                            
                          </div>
                        </div>
                    </div>
                </div>
                <div class="controller_area text-end">
                	<div class="button me-3" onclick="location.href='update_shop.mp?shop_id=${shop_info.shop_id}'">
                    <p class="btnText">수정</p>
                    <div class="btnTwo btnUpate">
                      <p class="btnText2"><i class="bi bi-pencil"></i></p>
                    </div>
                 </div>
                
                <div class="button" onclick="deleteShopCheck(${shop_info.shop_id})">
                    <p class="btnText">삭제</p>
                    <div class="btnTwo btnDelete">
                      <p class="btnText2"><i class="bi bi-x-lg"></i></p>
                    </div>
                 </div>
                
            	</div>
            </div>
        </div>

    </div>    
    
    <%@include file="/resources/include/footer.jsp" %>