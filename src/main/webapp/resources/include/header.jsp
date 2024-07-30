 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="commons.jsp"%>
<!-- header.jsp<br> -->
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>떠나봄</title>
    </head>
        <link href="<%=request.getContextPath()%>/resources/css/header_footer.css" rel="stylesheet">
      <script src="<%=request.getContextPath()%>/resources/script/header.js"></script>
   <body class="d-flex flex-column min-vh-100">
   <header>
      <div class="container">
         <div class="d-flex justify-content-between">
            <div class="logo">
               <a  href="<%=request.getContextPath()%>/main.jsp"><img src="<%=request.getContextPath()%>/resources/assets/logo/LOGO_MAIN.svg" ></a>
            </div>
            <div  class="nav_toggle_btn">
               <img src="<%=request.getContextPath()%>/resources/assets/icon/list_icon.svg"/>
            </div>
         </div>
      </div>
   </header>
   <aside class="nav__menu">
      <div>
         <div class="profile_area text-center">
            <c:if test="${sessionScope.loginInfo==null}">
               <img class="logo" src="<%=request.getContextPath()%>/resources/assets/logo/LOGO_BLACK.svg" >        
               <!-- <img class="profile_img" src="resources/images/default.jpg" >   -->  
            </c:if>
            <c:if test="${sessionScope.loginInfo!=null}">
               <div class="profile text-start">
                  <div class="profile_img_area">
                          <img class="profile_img" src="resources/images/${sessionScope.loginInfo.user_image}" >
                      </div>
                  <div class="profile_text">
                     <p class="profile_name">${sessionScope.loginInfo.user_name}</p>
                     <p class="profile_email">${sessionScope.loginInfo.user_email}</p>
                  </div>
               </div>
            </c:if>
         </div>
         <c:if test="${sessionScope.loginInfo!=null}">
            <div class="line">
               <img src="<%=request.getContextPath()%>/resources/assets/image/side_Line.svg" >
            </div>
            <div class="menu">
               <c:if test="${sessionScope.loginInfo.user_type == 'A'}">
                  <p><a href="gotoAdminPage.mb">관리자 페이지</a></p>               
               </c:if>
               <p><a href="update.mb?user_id=${sessionScope.loginInfo.user_id}">내 정보</a></p>
               <p><a href="showAllMyReservation.rv">예약내역</a></p>
               <c:if test="${sessionScope.loginInfo.user_type == 'A' ||sessionScope.loginInfo.user_type == 'B'}">
                  <p><a href="myshop_list.mp">시설관리</a></p>
               </c:if>
            </div>
         </c:if>
         <div class="line">
            <img src="<%=request.getContextPath()%>/resources/assets/image/side_Line.svg" >
         </div>
         <div class="menu">
            <p><a href="<%=request.getContextPath()%>/main.jsp?focus=focus">숙소찾기</a></p>
            <p><a href="list.bd">커뮤니티</a></p>
         </div>
         <div class="line">
            <img src="<%=request.getContextPath()%>/resources/assets/image/side_Line.svg" >
         </div>
         <div class="menu">
            <p><a href="eventList.ev">이벤트</a></p>
            <p><a href="user.faq">FAQ</a></p>
         </div>
         <div class="line">
            <img src="<%=request.getContextPath()%>/resources/assets/image/side_Line.svg" >
         </div>
         <c:if test="${sessionScope.loginInfo==null}">
            <button class="login_btn" onclick="location.href='loginForm.mb'">
               로그인/회원가입
            </button>
         </c:if>
         <c:if test="${sessionScope.loginInfo!=null}">
            <button class="login_btn" onclick="location.href='<%=request.getContextPath()%>/logout.jsp'">
               로그아웃
            </button>
         </c:if>
      </div>
   </aside>

