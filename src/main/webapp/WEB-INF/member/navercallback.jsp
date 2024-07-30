<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<body>
 
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script>
    var naverLogin = new naver.LoginWithNaverId({
        clientId: "kaxCxTA42dKv5heBxA5K", // 본인걸로 수정, 띄어쓰기 금지.
        callbackUrl: "https://nid.naver.com/oauth2.0/authorize", // 아무거나 설정
        isPopup: true,
        //팝업 false로 하면 팝업창 안뜨고 메인페이지로 나옴 
        callbackHandle: false
    });
    naverLogin.init();
 
    window.addEventListener('load', function () {
    naverLogin.getLoginStatus(function (status) {
 
    if (status) {
        /* console.log(naverLogin.user); */
        var age = naverLogin.user.getAge();
        var birthday = naverLogin.user.getBirthday();
        var email = naverLogin.user.getEmail();
        var gender = naverLogin.user.getGender();
        var id = naverLogin.user.getId();
        var name = naverLogin.user.getName();
        var nickName = naverLogin.user.getNickName();
 
        $.ajax({
            type: 'post',
            url: 'ajax.mb',
            data: {'n_age':age, 'n_birthday':birthday, 'n_email':email, 'n_gender':gender, 'n_id':id, 'n_name':name, 'n_nickName':nickName},
            dataType: 'text',
            success: function(result) {
                result = result.trim();
                if(result == 'ok') {
                    alert('로그인 성공');
                    
                 //window.opener.location.href = "http://localhost:8080/ex/naverInsert.mb?user_email=" + email + "&user_name=" + name;
                 
                 window.opener.location.href = "http://localhost:8080/ex/naverInsert.mb?user_email=" + email + "&user_name=" + name;
                    window.close();
                } else if(result == 'no') {
                    alert('로그인 실패');  
                    location.replace("http://localhost:8080/ex/NaverFailure.mb");
                }
            },
            error: function(result) {
                console.log('오류 발생');
            }
        });
 
    } else {
        console.log("callback 처리에 실패하였습니다.");
    }
    });
});
</script>
</body>
</html>
