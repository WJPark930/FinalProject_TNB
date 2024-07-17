<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>


userLoginForm.jsp<br>
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
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>


</head>
<body>
    <div class="">
        <div class="">        
            <div class="">                
                <a href="javascript:kakaoLogin()" class="btn btn-xl mx-0 mx-lg-2 ">
                    <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222" alt="카카오 로그인 버튼" />
                </a> 
            </div>
        </div>
    </div>

    <script type="text/javascript">

		Kakao.init('9ac9529d219d180efb43107a7afd0d2d'); 
		console.log(Kakao.isInitialized()); 
        //카카오로그인
        
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

<%
	String naverLogin = request.getContextPath() + "/naverLogin.mb";
%>

<a href="<%= naverLogin %>"><input type = "button" value = "네이버로그인"></a>


<form method="post" action="loginForm.mb">
<input type="hidden" name="pageNumber" value="${param.pageNumber}">
<table border="1" >

<tr>
<td>이메일</td>
<td><input type="text" name="user_email" ></td>
</tr>

<tr>
			<td>비밀번호</td>
			<td><input type="password" name="user_passwd" value=""></td>
		</tr>
		<tr>
		
		<td colspan="2">
		<input type="submit" value="로그인">
		
		</td>

</table>
  <div>
        <a href="javascript:openFindEmailPopup()">이메일 찾기</a> | <a href="javascript:openFindPasswdPopup()">비밀번호 찾기</a>
    </div>

</form>
<!--   <br>
    <button onclick="openFindEmailPopup()">이메일 찾기</button>
    <br>
    <button>비밀번호 찾기</butto n>-->
</body>
</html>