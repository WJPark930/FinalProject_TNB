<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<style>
.err {
	color: red;
	font-size: 12px;
	font-weight: bold;
	font-style: italic;
}

th {
	background-color: navy;
	color: white;
}
</style>

<h2 align="center">회원 수정 화면</h2>

	<form:form commandName="mb" method="post" action="update.mb?pageNumber=${param.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}">
		<input type="hidden" name="pageNumber" value="${pageNumber}">
		 <input type="hidden" name="keyword" value="${param.keyword}">
 		<input type="hidden" name="whatColumn" value="${param.whatColumn}">
		<table border="1" align="center">

		<tr>
			<th>아이디</th>
			<td><input type="text" name="id" value="${mb.id}"> <form:errors
					path="id" cssClass="err" /></td>
		</tr>

		<tr>
			<th>이름</th>
			<td><input type="text" name="name" value="${mb.name}"> <form:errors
					path="name" cssClass="err" /></td>
		</tr>

		<tr>
			<th>비번</th>
			<td><input type="password" name="password"
				value="${mb.password}"> <form:errors path="password"
					cssClass="err" /></td>
		</tr>
	
		<tr>
			<th>성별</th>
		<% String[] gender = {"여자","남자"}; %>
		<td>
		<c:forEach var="gender" items="<%=gender%>">
			<input type="radio" name="gender" value="${gender}"
				<c:if test="${mb.gender eq gender}">checked</c:if>>${gender}
		</c:forEach>
		</td>
		</tr>

		<tr>
			<th>취미</th>
			<td>
	<%
         String[] hobbies = {"마라톤", "영화감상", "게임", "공부"};
      %> 
     	<c:set var="hobby" value="<%=hobbies %>"/>
		<c:forEach var="i" begin="0" end="${fn:length(hobby)-1 }">
			<input type="checkbox" name="hobby" value="${hobby[i]}"
				<c:if test = "${fn:contains(mb.hobby, hobby[i]) }">checked</c:if>>
				${hobby[i]}
		</c:forEach>
		<form:errors path="hobby" cssClass="err" />
			</td>
		</tr>
		
		<tr>
		<th>좋아하는음식</th>
		<td>
		   <%
				String[] food = {"피자","치킨","햄버거","삼겹살"};
			%> 
            <select id="food" name="food">  
                <c:forEach var="fd" items="<%=food%>">
					<option value="${fd}" <c:if test="${mb.food eq fd}">selected</c:if>>${fd}</option>
				</c:forEach>
            </select>
		</td>
		</tr>


		<tr>
			<td colspan="2" align="center">
			<input type="submit" value="수정하기" id="btnSubmit" style="margin: auto;">
			</td>
		</tr>
		</table>
	</form:form>
