<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 
    <%@include file="/resources/include/header.jsp"%>
    
    <script src="<%=request.getContextPath()%>/resources/script/mypage/mypage_room.js?after"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/mypage/myroom.css?after">

    <div class="container-fruid min-vh-100 " id="content_container">
        <div class="content_mypage container">
        
           <%@include file="/resources/include/my_aside.jsp" %>
           
            <div class="content_area">
                <form:form commandName="room" method="post" action="update_room.mp" enctype="multipart/form-data">
                <input type="hidden" value="${room.shop_id}" name="shop_id">
                <input type="hidden" value="${room.room_id}" name="room_id">
                <div class="room_content_area room_insert_area">
                	<p class="info_title">객실명*</p>
                    <div class="info_content">
                        <input type="text" name="room_name" class="room_text_input" placeholder="객실명을 입력해주세요. (최대 30자)" value="${room.room_name}">
                        <p class="info_err"><form:errors path="room_name" cssClass="err"></form:errors></p>
                    </div>
                    <p class="info_title">가격*<span>1박 기준 / 1000 ~ 1000만원 사이</span></p>
                    <div class="info_content">
                        <input type="number" name="price" class="room_text_input price_input" value="${room.price}" min="1000" max="10000000">
                        <p class="info_err"><form:errors path="price" cssClass="err"></form:errors></p>
                    </div>
                	<p class="info_title">인원*</p>
                    <div class="info_content">
                    	최대 인원 
                        <select class="form-select room_select" name="max_people" 
                        aria-label=".form-select-max_people">                            
                            <c:forEach begin="1" end="10" var="max_people" >
	                            <option value="${max_people}" 
	                            <c:if test="${room.max_people == max_people}"> selected </c:if>
	                            >${max_people} 인</option>
                            </c:forEach>
                        </select>
						기준 인원             
                        <select class="form-select room_select" name="standard_people" 
                        aria-label=".form-select-standard_people">
                            <c:forEach begin="1" end="10" var="standard_people" >
	                            <option value="${standard_people}" 
	                            <c:if test="${room.standard_people == standard_people}"> selected </c:if>
	                            >${standard_people} 인</option>
                            </c:forEach>
                        </select>                           
                    </div>
                    
                	<p class="info_title">입퇴실 시간*</p>                	
                    <div class="info_content">
                    	입실 
                        <select class="form-select room_select" name="check_in" 
                        aria-label=".form-select-check_in">
                            <c:forEach begin="14" end="18" var="check_in">
	                            <option value="${check_in}" 
	                            <c:if test="${room.check_in == check_in}"> selected </c:if>
	                            >${check_in}</option>
                            </c:forEach>
                        </select>
                                                   
                        퇴실 
                        <select class="form-select room_select" name="check_out" 
                        aria-label=".form-select-standard_people">
                            <c:forEach begin="10" end="12" var="check_out">
	                            <option value="${check_out}" 
	                            <c:if test="${room.check_out == check_out}"> selected </c:if>
	                            >${check_out}</option>
                            </c:forEach>
                        </select>                           
                    </div>
                    
                    <p class="info_title">객실 수*</p>
                    <div class="info_content">
                        <select class="form-select room_select" name="room_count" 
                        aria-label=".form-select-room_count">
                            <c:forEach begin="1" end="20" var="room_count">
	                            <option value="${room_count}" 
	                            <c:if test="${room.room_count == room_count}"> selected </c:if>
	                            >${room_count} 개</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <div class="room_content_area room_insert_area">
                    <div class="area_top">
                        <p class="info_title pt-2">이미지*</p>                        
                        <div>
                            <input type="button" class="btn btn-outline-secondary" onclick="image_delete()" value="이미지 삭제">
                            <input type="button" class="btn btn-secondary" onclick="image_add()" value="이미지 추가">
                        </div>
                    </div>
                    <p class="">최소 1개이상의 이미지를 등록해주세요.</p><br>
                    <div class="image_area">
                        <div class="file_area">
                            <c:forEach items="${room_image_list}" var="room_img">
                                <div class="save_img${room_img.room_img_id} save_area">
                                    <img src="<%=request.getContextPath()%>/resources/assets/image/${room_img.image}" >
                                    <input type="hidden" value="${room_img.room_img_id}" name="save_image">
                                    <button onclick="deleteSaveImg(${room_img.room_img_id})"><i class="bi bi-trash-fill"></i></button>
                                </div>                                			
                            </c:forEach>
                        </div>
                    </div>
                    <p class="err file_err"></p>
                </div>

                <div class="text-end">
                    <input type="submit" value="수정" class="submit_btn" onclick="return checkSubmit()">
                </div>
                </form:form>
            </div>
            <div>
            </div>            
        </div>
    </div>    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <%@include file="/resources/include/footer.jsp" %>
    