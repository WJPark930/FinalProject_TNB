<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="WEB-INF/common/common.jsp" %> 
    <%@ page import="member.model.MemberBean" %> 
   main.jsp<br>
  
<%
String viewuserMember = request.getContextPath()+"/loginForm.mb";
/* String viewMember = request.getContextPath()+"/memberList.mb"; */


String insertuserMember = request.getContextPath()+"/insertuser.mb?user_type="+"G";

String insertBusinessMember = request.getContextPath()+"/insertuser.mb?user_type="+"B";


String viewmemberMypage = request.getContextPath()+"/memberMyPage.mb";

String adminPage = request.getContextPath() + "/gotoAdminPage.mb";

Object loginInfo = session.getAttribute("loginInfo");
String loginEmail = loginInfo != null ? ((MemberBean) loginInfo).getUser_email() : null; // User 객체에서 이메일을 가져옴
%>


<a href="<%=viewuserMember%>">일반회원 로그인</a><br><br>
<%-- <a href="<%=viewMember%>">회원리스트 보기</a><br><br> --%>
<a href="<%=insertuserMember%>">일반회원가입</a><br><br>
<a href="<%=insertBusinessMember%>">사업자회원가입</a><br><br>
<%-- <a href="<%=viewmemberMypage%>">마이페이지</a><br><br> --%>

<% if (loginInfo != null) { %>
    <a href="<%= viewmemberMypage %>">마이페이지</a><br><br>
<% } %>

<% if (loginEmail != null && loginEmail.equals("admin")) { %>
    <a href="<%= adminPage %>">관리자 페이지</a><br><br>
<% } %>

