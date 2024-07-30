<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>

<%@include file="/resources/include/header.jsp" %>
  
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <!-- 페이지 css,js -->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/fonts.css?after">
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/member/login.css?after">
    
    <!-- css 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
    rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
    crossorigin="anonymous"/>

    <!-- 아이콘 부트스트랩 -->
    <link rel="stylesheet" 
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">

    <!-- javascript 부트스트랩 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
    crossorigin="anonymous"></script>

    <!-- javascript sns -->
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
</head>

<script type="text/javascript">
    Kakao.init('9ac9529d219d180efb43107a7afd0d2d'); 
    console.log(Kakao.isInitialized()); 

    function kakaoLogin() {
        Kakao.Auth.login({
            success: function (authObj) {
                console.log(authObj);
                Kakao.Auth.setAccessToken(authObj.access_token); 
                getInfo(authObj.access_token);
            },
            fail: function (err) {
                console.log(err);
            }
        });

        function getInfo(access_token) {
            Kakao.API.request({
                url: '/v2/user/me',
                success: function (response) {
                    let nickname = response.kakao_account.profile.nickname;
                    let account_email = response.kakao_account.email;

                    console.log(response)
                    console.log(access_token)
                    console.log(response.kakao_account.profile.nickname)
                    console.log(response.kakao_account.profile.account_email)
                    location.href = "kakaoLoginSuccess.mb?access_token="+access_token+"&user_nickname="+nickname+"&user_email="+account_email;
                },
                fail: function (error) {
                    console.log(error)
                },
            })
        }
    }

    function openFindEmailPopup() {
        window.open("findEmail.mb", "findEmailPopup", "width=600,height=400,scrollbars=yes,resizable=yes");
    }

    function openFindPasswdPopup() {
        window.open("findPasswd.mb", "findPasswdPopup", "width=600,height=400,scrollbars=yes,resizable=yes");
    }
</script>

<div class="container" id="content_container">
    <div class="login-container">
        <div class="login-box">
        
            <h2>로그인</h2>
            <form method="post" action="loginForm.mb">
                <input type="hidden" name="pageNumber" value="${param.pageNumber}">
                <div class="input_area">
                    <label for="user_email">이메일</label>
                    <input type="text" id="user_email" name="user_email">
                </div>
                <div class="input_area">
                    <label for="user_passwd">비밀번호</label>
                    <input type="password" id="user_passwd" name="user_passwd">
                </div>
                <div class="links">
                    <a href="javascript:openFindEmailPopup()">이메일 찾기</a> | 
                    <a href="javascript:openFindPasswdPopup()">비밀번호 찾기</a>
                </div>
                <div class="input-group">
                    <button class="login_btn" type="submit">로그인</button>
                </div>

                <div class="login_sns">
                    <a href="javascript:kakaoLogin()" class="btn btn-xl kakao_btn">
                        <img src="<%=request.getContextPath()%>/resources/assets/icon/kakao_icon.png">
                        카카오로 로그인
                    </a> 
                    <a href="javascript:navarLogin()" class="btn btn-xl naver_btn">
                        <img src="<%=request.getContextPath()%>/resources/assets/icon/naver_icon.png">
                        네이버로 로그인
                    </a> 
                    <div id="naverIdLogin"  class="input-group" style="display: none;">  
                        <script type="text/javascript">
                            var naverLogin = new naver.LoginWithNaverId({
                                clientId: "kaxCxTA42dKv5heBxA5K",
                                // 본인의 Client ID로 수정, 띄어쓰기는 사용하지 마세요.
                                callbackUrl: "http://localhost:8080/ex/NaverCallBack.mb",
                                  
                                // 본인의 callBack url로 수정하세요.
                                isPopup: true,
                                //로그인팝업
                                loginButton: {color: "green", type: 3, height: 60}
                            });
                            naverLogin.init();
                            function navarLogin(){
                                console.log(1);
                                var btnNaverLogin = document.getElementById("naverIdLogin").firstChild;
                                btnNaverLogin.click();
                            }
                        </script>    
                    </div>
                </div>
                
                
                <%
                String insertuserMember = request.getContextPath()+"/insertuser.mb?user_type="+"G";
                String insertBusinessMember = request.getContextPath()+"/insertuser.mb?user_type="+"B";
                %>
                <div class="register">
                    <a href="<%=insertuserMember%>" class="btn btn-secondary btn-user"><i class="bi bi-person-fill-add"></i>일반 회원가입</a>
                    <a href="<%=insertBusinessMember%>" class="btn btn-success btn-business"><i class="bi bi-house-add-fill"></i>사업자 회원가입</a>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="/resources/include/footer.jsp" %>
