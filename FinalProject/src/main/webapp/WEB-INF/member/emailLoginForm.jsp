<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>이메일 로그인</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .header-title {
            text-align: center;
            margin-bottom: 30px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .card-body {
            padding: 2rem;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header-title">
            <h1>떠나봄</h1>
            <h2>이메일로 시작하기</h2>
        </div>
        <div class="row">
            <div class="col-md-4 mx-auto">
                <div class="card">
                    <div class="card-body">
                      <form method="post" action="loginForm.mb">
<input type="hidden" name="pageNumber" value="${param.pageNumber}">
                            <div class="form-group">
                                <label for="user_email">이메일</label>
                                <input type="email" class="form-control" id="user_email" name="user_email" required>
                            </div>
                            <div class="form-group">
                                <label for="user_passwd">비밀번호</label>
                                <input type="password" class="form-control" id="user_passwd" name="user_passwd" required>
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">로그인</button>
                        </form>
                        <div class="text-center mt-3">
                            <a href="javascript:openFindEmailPopup()">이메일 찾기</a> | <a href="javascript:openFindPasswdPopup()">비밀번호 찾기</a>
                        </div>
                        <div class="text-center mt-3">
                            <a href="registerForm.mb">회원가입</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openFindEmailPopup() {
            window.open("findEmail.mb", "findEmailPopup", "width=600,height=400,scrollbars=yes,resizable=yes");
        }

        function openFindPasswdPopup() {
            window.open("findPasswd.mb", "findPasswdPopup", "width=600,height=400,scrollbars=yes,resizable=yes");
        }
    </script>
</body>
</html>
