<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../common/common.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
</head>
<body>
    <h1>비밀번호 찾기</h1>
    <form method="post" action="findPasswd.mb">
        <table>
            <tr>
                <th>이메일</th>
                <td><input type="text" name="user_email"></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><input type="text" name="user_phone"></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="비밀번호 찾기"></td>
            </tr>
        </table>
    </form>
</body>
</html>