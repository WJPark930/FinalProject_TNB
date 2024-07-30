<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/resources/include/commons.jsp"%>
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/mypage/mypage_standard.css?after">
    
<div class="aside_mypage">
    <div class="nav_area_mypage">
        <c:choose>
            <c:when test="${sessionScope.loginInfo.user_type != null}">
                <button onclick="location.href='update.mb?user_id=${sessionScope.loginInfo.user_id}'">내 정보</button>
                <c:if test="${sessionScope.loginInfo.user_type == 'A' ||sessionScope.loginInfo.user_type == 'B'}">
                    <button onclick="location.href='myshop_list.mp'">시설관리</button>
                </c:if>
                <button onclick="location.href='showAllMyReservation.rv'">예약확인</button>
                <button onclick="location.href='showAllMyCoupon.ev?user_id=${sessionScope.loginInfo.user_id}'">보유쿠폰</button>
            </c:when>
            <c:otherwise>
                <!-- 로그인되지 않은 사용자나 정의되지 않은 user_type에 대한 기본 메뉴 또는 메시지 -->
                <button onclick="location.href='loginForm.mb'">로그인/회원가입</button>
            </c:otherwise>
        </c:choose>
    </div>
</div>