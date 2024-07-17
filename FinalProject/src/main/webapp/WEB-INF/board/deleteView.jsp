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
    

    
    
    
    <center>
    	<h2>글 삭제</h2>
    </center>
    
    <form action="delete.bd" method="post">
    	<input type = "hidden" name = "bid" value="${param.bid}">
    	<input type = "hidden" name = "pageNumber" value = "${param.pageNumber}">
    	<table border=1 align="center">
    		<tr>
    			<th>
    				비밀번호를 입력해 주세요
    			</th>
    		</tr>
    		
    		<tr>
    			<td>
    				비밀번호 : &nbsp; <input type="text" name="passwd">
    				<form:errors path="passwd" cssClass="err"/>
    			</td>
    		</tr>
    		
    		<tr>
    			<td>
    				<input type="submit" value="글삭제"> &nbsp; <input type="button" value="글 목록" onClick="location.href='list.bd?pageNumber=${pageInfo.pageNumber}'">
    			</td>
    		</tr>
    		
    	</table>
    </form>