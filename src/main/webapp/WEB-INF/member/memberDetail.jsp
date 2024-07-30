<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/resources/include/header.jsp" %>
  
 
 <h2>회원상세보기(<%=request.getContextPath()%>)</h2>
 
 <table border="1">
 <tr>
 <td rowspan="5" align="center">
 <img src="<%=request.getContextPath()%>/resources/images/${member.user_image}" width="150">
</td>
 </tr>
 
 <tr>
 <th>이메일</th>
 <td>${member.user_email }</td>
 </tr>
 
  <tr>
 <th>비밀번호</th>
 <td>${member.user_passwd }</td>
 </tr>
 
  <tr>
 <th>성별</th>
 <td>${member.user_gender }</td>
 </tr>
 
  <tr>
 <th>회원상태</th>
 <td>${member.user_status }</td>
 </tr>
 
 <%--   <tr>
 <th>보유 포인트</th>
 <td>${member.user_point }</td>
 </tr> --%>
 
<tr>
<td colspan="3" align="center">

<a href ="memberList.mb?pageNumber=${param.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}">회원 리스트</a>
</td>
</tr>
</table>
 
 
<%@include file="/resources/include/footer.jsp" %>
 