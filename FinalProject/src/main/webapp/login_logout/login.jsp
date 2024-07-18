<%@page import="member.model.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		MemberBean member = new MemberBean();
		member.setUser_id(1);
		member.setUser_nickname("admin");
		member.setUser_email("abc@naver.com");
		//System.out.println(member.user_email);
		session.setAttribute("loginInfo", member);
		response.sendRedirect(request.getContextPath()+"/main.jsp");
	%>