<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	function memberList() {
		location.href="list.mb"; 
	}
	
	function register(){
		location.href="insert.mb";
	} 
</script>

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
<br><br><br><br><br><br><br><br><br>
<center>
<h2>로그인 화면</h2>
</center>
<form method="post" action="loginForm.mb">
<!-- loginForm.mb =>MemberLoginController -->
<input type="hidden" name="pageNumber" value="${param.pageNumber}">
	<table border="1" width="40%" height="120px" align="center">
		<tr>
			<th>아이디</th>
			<td><input type="text" name="id" value="kim"></td>
		</tr>
		
		<tr>
			<th>비번</th>
			<td><input type="password" name="password" value="1234"></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="로그인">
				<input type="reset" value="취소">
				<input type="button" value="회원가입" onClick="register()">
				<input type="button" value="회원 목록보기" onClick="memberList()">
			</td>
		</tr>
	</table>
</form>