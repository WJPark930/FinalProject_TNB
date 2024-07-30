<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%
 session.invalidate();
 int user_id = Integer.parseInt(request.getParameter("user_id"));
 String redirectUrl = "/ex/LoginSessionSkip.mb?user_id=" + user_id;
  
 response.sendRedirect(redirectUrl);
 %>
