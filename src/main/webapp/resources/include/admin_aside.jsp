<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/resources/include/commons.jsp"%>
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/mypage/mypage_standard.css?after">
    
<div class="aside_mypage">
    <div class="nav_area_mypage">
        <button onclick="location.href='memberList.mb?user_id=${sessionScope.loginInfo.user_id}'">멤버 관리</button>
        <button onclick="location.href='list.faq?user_id=${sessionScope.loginInfo.user_id}'">F A Q 관리</button>
        <button onclick="location.href='eventInsert.ev?user_id=${sessionScope.loginInfo.user_id}'">이벤트 관리</button>           
    </div>
</div>