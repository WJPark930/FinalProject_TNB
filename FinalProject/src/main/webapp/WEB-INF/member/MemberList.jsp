<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>  

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

<script type="text/javascript">
	function insert(){
		location.href="insert.mb";
	}
	
	function update(id, pageNumber, keyword, whatColumn) {
		location.href = "update.mb?id=" + id + "&pageNumber=" + pageNumber + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
	}
</script>
<center>
<br><br><br><br>
<h2>회원 리스트 화면</h2><br>
</center>
<form action="list.mb" align="center">
		<select name="whatColumn">
			<option value="all">전체검색
			<option value="gender">성별
			<option value="hobby">취미
		</select>
		<input type="text" name="keyword">
		<input type="submit" value="검색">
</form>

<table border="1" align="center">
    	<tr>
    		<td colspan="10" align="right">
    			<input type="button" value="추가하기" onClick="insert()">
    		</td>
    	</tr>
    	<tr>
    		<th>ID</th>
    		<th>이름</th>
    		<th>비번</th>
    		<th>성별</th>
    		<th>취미</th>
    		<th>음식</th>
    		<th>삭제</th>
    		<th>수정</th>
    	</tr>
    	
    	<c:forEach var="ml" items="${memberLists}">		
    		<tr>
    			<td>${ml.id}</td>
    			<td>${ml.name}</a></td>
    			<td>${ml.password}</td>
    			<td>${ml.gender}</td>
    			<td>${ml.hobby}</td>
    			<td>${ml.food}</td>

    			<td><a href="delete.mb?id=${ml.id}&pageNumber=${pageInfo.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}">삭제</a></td>
    			<td><input type="button" name="update" value="수정하기" onClick="update('${ml.id}', '${pageInfo.pageNumber}', '${param.keyword}', '${param.whatColumn}')"></td>
    		</tr>		
    	</c:forEach>
    	
    	
    	<tr>
    		<td colspan="9" align="center"> ${pageInfo.pagingHtml }</td>
    	</tr>
    </table>

