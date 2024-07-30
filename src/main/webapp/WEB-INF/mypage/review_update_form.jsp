<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
   <%@include file="/resources/include/header.jsp" %>
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/mypage/review.css?after">
    <script src="<%=request.getContextPath()%>/resources/script/mypage/mypage_review.js?after"></script>

    <div class="container-fruid min-vh-100 " id="content_container">


        <div class="content_mypage container">
            <%@include file="/resources/include/my_aside.jsp" %>
            <div class="content_area">
                <form:form commandName="review" action="review_update.mp" method="post" enctype="multipart/form-data">
                	<input type="hidden" name="shop_name" value="${review.shop_name}">
                	<input type="hidden" name="reservation_id" value="${review.reservation_id}">
                	<input type="hidden" name="review_id" value="${review.review_id}">
                	<input type="hidden" name="shop_id" value="${review.shop_id}">
                	<input type="hidden" name="room_id" value="${review.room_id}">                	
                	<input type="hidden" name="room_checkin_date" value="${reservation.room_checkin_date}">
                	<input type="hidden" name="room_checkout_date" value="${reservation.room_checkout_date}">

                    <fmt:parseDate value="${reservation.room_checkin_date}" var="room_checkin_date" pattern="yyyy-MM-dd"/>
                    <fmt:parseDate value="${reservation.room_checkout_date}" var="room_checkout_date" pattern="yyyy-MM-dd"/>
                    <div class="reivew_content_area reivew_insert_area">
                        <p class="info_title">${review.shop_name}</p>
                        <p>
                            예약기간 :
                            <fmt:formatDate value="${room_checkin_date}" pattern="yyyy-MM-dd"/>
                            	~
                            <fmt:formatDate value="${room_checkout_date}" pattern="yyyy-MM-dd"/>
                        </p>
                        <br>
                        <p class="info_title">평점*</p>
                        <div class="info_content">
                            <input type="range" name="grade" class="grade_range" min="1" max="10" step="0.5" value="${review.grade}">
                            <label class="grade_range_text"><span class="grade_text">${review.grade}</span> 점</label>
                        </div>
                        <p class="info_title">내용*</p>
                        <div class="info_content">
                            <textarea name="review_content" class="review_textarea" placeholder="리뷰 내용을 입력해주세요. (최대 100자)" >${review.review_content}</textarea>
                            <p><form:errors path="review_content" cssClass="err" /></p>
                        </div>
                    </div>
                    <div class="reivew_content_area reivew_insert_area">
                        <div class="area_top">
                            <p class="info_title pt-2">이미지*</p>                        
                            <div>
                                <input type="button" class="btn btn-outline-secondary" onclick="image_delete()" value="이미지 삭제">
                                <input type="button" class="btn btn-secondary" onclick="insertImg()" value="이미지 추가">
                            </div>
                        </div>
                        <p class="">최소 1개이상의 이미지를 등록해주세요.</p><br>
                        <div class="insert_img_area">
                            <div class="image_area">
                                <div class="file_area">
                                    <c:forEach items="${review_img_list}" var="review_img">
                                        <div class="save_img${review_img.review_img_id} save_area">
                                            <img src="<%=request.getContextPath()%>/resources/assets/image/${review_img.image}" >
                                            <input type="text" value="${review_img.review_img_id}${review_img.image}" name="save_image">
                                            <button onclick="deleteSaveImg(${review_img.review_img_id})"><i class="bi bi-trash-fill"></i></button>
                                        </div>                                			
                                    </c:forEach>
                                </div>
                                <input type="hidden" name="image" value="${review_img_list}">
                            </div>
                        </div>
                        <p><form:errors path="image" cssClass="err"></form:errors></p>
                    </div>
                    <div class="text-end">
                        <input type="submit" value="수정" class="submit_btn">
                    </div>               		
                </form:form>
                
            </div>
        </div>

    </div>    
    
    <%@include file="/resources/include/footer.jsp" %>