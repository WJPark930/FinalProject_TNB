<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@include file="/resources/include/header.jsp" %>
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/mypage/review.css?after">
    <script src="<%=request.getContextPath()%>/resources/script/mypage/mypage_review.js?after"></script>

    <div class="container-fruid min-vh-100 " id="content_container">


        <div class="content_mypage container">
            <div class="aside_mypage">
                <div class="aside_menu_mypage">
                    <a href="review_list.mp">내 리뷰</a>
                </div>
            </div>
            <div class="content_area">
                <h2>리뷰 등록 하기</h2>
                <form:form commandName="review" action="review_update.mp" method="post" enctype="multipart/form-data">
                	<input type="text" name="shop_name" value="${review.shop_name}">
                	<input type="text" name="reservation_id" value="${review.reservation_id}">
                	<input type="text" name="review_id" value="${review.review_id}">
                	<input type="text" name="shop_id" value="${review.shop_id}">
                	<input type="text" name="room_id" value="${review.room_id}">
                	<input type="text" name="user_id" value="${sessionScope.loginInfo.user_id}">
                	<input type="text" name="room_checkin_date" value="${reservation.room_checkin_date}">
                	<input type="text" name="room_checkout_date" value="${reservation.room_checkout_date}">
               		<table>
                        <tr>
                            <td>시설명</td>
                            <td>${review.shop_name}</td>                            
                        </tr>
                        <tr>
                        	<fmt:parseDate value="${reservation.room_checkin_date}" var="room_checkin_date" pattern="yyyy-MM-dd"/>
                        	<fmt:parseDate value="${reservation.room_checkout_date}" var="room_checkout_date" pattern="yyyy-MM-dd"/>
                            <td>예약 기간</td>
                            <td>
                            	<fmt:formatDate value="${room_checkin_date}" pattern="yyyy-MM-dd"/>
                            	~
                            	<fmt:formatDate value="${room_checkout_date}" pattern="yyyy-MM-dd"/>
                            </td>    
                       </tr>  
                       <tr>
                           <td>평점</td>
                           <td>
                               <input type="range" name="grade" class="grade_range" min="1" max="10" step="0.5" value="${review.grade}">
                               <label class="grade_range_text"><span class="grade_text">${review.grade}</span> 점</label>
                           </td>                            
                       </tr>                            
                       <tr>
                           <td>이미지</td>
                           <td>
                                <div class="insert_img_area">
                                	<div class="image_area">
                                		<c:forEach items="${review_img_list}" var="review_img">
                                			<div class="save_img${review_img.review_img_id} save_area">
	                                			<img src="<%=request.getContextPath()%>/resources/assets/image/${review_img.image}" style="width:100px;" >
	                                			<input type="text" value="${review_img.review_img_id}${review_img.image}" name="save_image">
	                                			<button onclick="deleteSaveImg(${review_img.review_img_id})">삭제</button>
                                			</div>                                			
                                		</c:forEach>
                                		<input type="text" name="image" value="${review_img_list}">
                                	</div>
                                </div>
                                <input type="button" class="btn" value="이미지 추가" onclick="insertImg()">
                                <p><form:errors path="image" cssClass="err"></form:errors></p>
                           </td>                            
                       </tr>                            
                       <tr>
                           <td>내용</td>
                           <td>
                           		<textarea name="review_content">${review.review_content}</textarea>
                           		<br><form:errors path="review_content"/>
                           </td>                            
                       </tr>                            
                       <tr>
                       		<td colspan="2">
                       			<input type="submit" value="수정">
                       		</td>
                       </tr>                        
               		</table>
                </form:form>
                
            </div>
        </div>

    </div>    
    
    <%@include file="/resources/include/footer.jsp" %>