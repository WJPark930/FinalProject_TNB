<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

접속자 아이디 : ${sessionScope.loginInfo.user_email}<br>
접속자 일련번호 : ${sessionScope.loginInfo.user_id}<br>

<a href="main2.jsp">시작페이지</a><br>
<a href="logout.jsp">로그아웃</a><br>