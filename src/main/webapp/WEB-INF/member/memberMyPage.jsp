<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %>

<head> 
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/mypage/mypage.css">
</head>

   <div class="container-fruid min-vh-100 " id="content_container">
<div class="content_mypage container">
<%@include file="/resources/include/my_aside.jsp" %>
 <div class="content_area">

                <h2>환영합니다, ${sessionScope.loginInfo.user_nickname}님!</h2>

    </div>
    </div>
    </div>
<%@include file="/resources/include/footer.jsp" %>
