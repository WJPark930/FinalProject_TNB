<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

session.setAttribute<br>

<%
session.invalidate();
response.sendRedirect("main.jsp");
%>


<!-- 모든 session설정한걸 다 무효화하겠다 -->