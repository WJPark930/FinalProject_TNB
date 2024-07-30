<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %> 


<%
session.invalidate();
%>
<!-- //response.sendRedirect("main.jsp"); -->

 <script type="text/javascript">
        alert('로그아웃 되었습니다.');
        window.location.href = 'main.jsp';
    </script>
<!-- 모든 session설정한걸 다 무효화하겠다 -->

 <%@include file="/resources/include/footer.jsp" %> 
