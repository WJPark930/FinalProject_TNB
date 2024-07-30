<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/include/commons.jsp"%>
<!DOCTYPE html>
<html>
<head> 
    <meta charset="UTF-8">
    <title>이메일 찾기 결과</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <div class="col-md-6 mx-auto text-center">
            <h1 class="mb-4">이메일 찾기 결과</h1>
            <div class="card">
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty user_email}">
                            <p class="alert alert-success">가입하신 이메일은: ${user_email} 입니다.</p>
                        </c:when>
                        <c:otherwise>
                            <p class="alert alert-danger">${message}</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="mt-4">
                <button onclick="redirectToLogin()" class="btn btn-primary btn-block">로그인</button>
                <button onclick="openFindPasswdPopup()" class="btn btn-secondary btn-block">비밀번호 찾기</button>
            </div>
        </div>
    </div>

    <script>
        function openFindPasswdPopup() {
            window.open("findPasswd.mb", "findPasswdPopup", "width=600,height=400,scrollbars=yes,resizable=yes");
        }

        function redirectToLogin() {
            window.opener.location.href = 'loginForm.mb';
            window.close();
        }
    </script>
</body>
</html>
