<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    
</head>
<body>
<div class="container mt-5">
<div class="col-md-6 mx-auto text-center">
    <h1>비밀번호 찾기</h1>
    </div>
      <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card">
                    <div class="card-body">
    
    <form method="post" action="findPasswd.mb">
    <div class="form-group">
              <label for="user_name">이메일</label>
                                <input type="text" name="user_email" id="user_email" class="form-control" required>
                            </div>
 <div class="form-group">
                                <label for="user_phone">전화번호</label>
                                <input type="text" name="user_phone" id="user_phone" class="form-control" required>
                 </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary btn-block">비밀번호 찾기</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>