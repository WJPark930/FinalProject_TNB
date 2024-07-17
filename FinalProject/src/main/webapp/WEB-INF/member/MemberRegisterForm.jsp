<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>    

<style>
	th{
		background-color: navy;
		color : white;
	}


	table{
		width: 1000px;
	}
	
	td{
		text-align: center;
	}
	
	a{
		text-decoration: none;
		text-align: center;
	}
</style>
<h2 align="center">회원 가입 화면</h2>
<form:form commandName="member" action="insert.mb" method="post">
<table align="center" border="1">
	<tr>
		<th>아이디</th>
		<td>
			<input type="text" name="id" value="${member.id }">
			<form:errors path="id" cssClass="err"/>
		</td>
	</tr>
	<tr>
		<th>이름</th>
		<td>
			<input type="text" name="name" value="${member.name }">
			<form:errors path="name" cssClass="err"/>
		</td>
	</tr>
	<tr>
		<th>비번</th>
		<td>
			<input type="text" name="password" value="${member.password }">
			<form:errors path="password" cssClass="err"/>
		</td>
	</tr>
	<tr>
		<th>성별</th>
		<td>
			<% String[] gender = {"여자","남자"}; %>
				<c:forEach var="gender" items="<%=gender%>">
					<input type="radio" name="gender" value="${gender}" <c:if test="${member.gender eq gender}">checked</c:if>>${gender}
				</c:forEach>
			<form:errors path="gender" cssClass="err"/>
		</td>
	</tr>
	<tr>
		<th>취미</th>
		<td>
			<%String [] hobby = {"마라톤","영화감상","게임","공부"}; %>
			<c:forEach var="hobby" items="<%=hobby %>">
			<input type="checkbox" name="hobby" value="${hobby }" <c:if test="${fn:contains(member.hobby , hobby)}">checked</c:if>>${hobby }
			</c:forEach>
			<form:errors path="hobby" cssClass="err"/>
		</td>
	</tr>

	<tr>
		<th>좋아하는음식</th>
		<td>
			<select name="food">
				<option value="햄버거">햄버거</option>
				<option value="치킨">치킨</option>
				<option value="피자">피자</option>
				<option value="삼겹살">삼겹살</option>
			</select>
		</td>
	</tr>

	<tr>
		<th colspan="2"><input type="submit" value="추가하기"></th>
	</tr>
	</table>
</form:form>
