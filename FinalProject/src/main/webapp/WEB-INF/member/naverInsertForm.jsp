<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %> 

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
    .err {
        color: red;
        font-size: 9pt;
    }
    .success {
        color: blue;
        font-size: 9pt;
    }
    .address-input {
        width: 80%;
        display: inline-block;
    }
    .find-button {
        display: inline-block;
        margin-left: 10px;
    }
    .profile-container {
        display: flex;
        align-items: center;
    }
    .profile-image {
        width: 100px;
        height: 100px;
        border: 1px solid #ccc;
        margin-left: 10px;
        display: inline-block;
        background-image: url('resources/images/default.jpg'); /* 기본 이미지 경로 설정 */
        background-size: cover;
        background-position: center;
        cursor: pointer;
    }
    .profile-input {
        display: none;
    }
    .profile-filename {
        margin-left: 10px;
    }
</style>

<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }

                if (data.userSelectedType === 'R') {
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    addr += extraAddr;
                }

                document.getElementById('zonecode').value = data.zonecode;
                document.getElementById('user_addr1').value = addr;
                document.getElementById('user_addr2').focus();
            }
        }).open();
    }

 

    // 닉네임 중복 체크 함수
  function checkNickname() {
    var nickname = document.getElementById('user_nickname').value;

    if (nickname.trim() === '') { // 값이 공백인 경우
        nicknameMessage.textContent = ""; // 에러 메시지 초기화
        return;
    }

        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'checkNickname.mb?user_nickname=' + encodeURIComponent(nickname), true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                if (xhr.responseText === 'true') {
                    alert('이미 사용중인 닉네임입니다.');
                    nicknameMessage.textContent = "닉네임을 입력해주세요.";
                    nicknameMessage.className = 'err'; // 빨간색으로 설정
                } else {
                    alert('사용 가능한 닉네임입니다.');
                    nicknameMessage.textContent = "사용 가능한 닉네임입니다.";
                    nicknameMessage.className = 'success'; // 파란색으로 설정
                }
            }
        };
        xhr.send();
    }
    

    function validateForm() {
        var profileInput = document.getElementById('profileInput');

        // 이미지 선택 여부 확인
        if (profileInput.files.length === 0) {
            // 이미지를 선택하지 않았을 경우 확인 창 표시
            if (!confirm("이미지를 선택하지 않았습니다. 기본 이미지로 설정하시겠습니까?")) {
                return false; // 취소 시 폼 제출 중단
            } else {
                // 기본 이미지 설정
                var defaultImage = new File([], "default.jpg", { type: "image/jpeg" });
                var dataTransfer = new DataTransfer();
                dataTransfer.items.add(defaultImage);
                profileInput.files = dataTransfer.files;
            }
        }
        return true; // 이미지 선택이나 확인 창 취소 시 폼 제출 계속 진행
    }

    function openFileSelector() {
        document.getElementById('profileInput').click();
    }

    function displaySelectedFile(event) {
        var input = event.target;
        var file = input.files[0];

        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.querySelector('.profile-image').style.backgroundImage = 'url(' + e.target.result + ')';
            };
            reader.readAsDataURL(file);
            document.getElementById('profileFilename').textContent = file.name;
        }
    }

    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById('profileInput').addEventListener('change', displaySelectedFile);
    });
    
    function formatPhoneNumber(input) {
        // 현재 입력된 값에서 숫자만 추출
        const cleaned = ('' + input.value).replace(/\D/g, '');
        let formatted = '';

        // 포맷팅 규칙 적용
        if (cleaned.length > 6) {
            formatted = cleaned.replace(/(\d{3})(\d{4})(\d{0,4})/, '$1-$2-$3');
        } else if (cleaned.length > 2) {
            formatted = cleaned.replace(/(\d{3})(\d{0,4})/, '$1-$2');
        } else {
            formatted = cleaned;
        }

        // 입력 값 갱신
        input.value = formatted;
    }
    
</script>
naverinsertForm.jsp<br>

${ user_email } / ${ user_name }

<c:if test="${ user_email != null }">

<h2 align="center">필수 정보 입력</h2>

<form:form modelAttribute="member" method="post" action="naverInsert.mb" enctype="multipart/form-data" onsubmit="return validateForm() && validatePassword()">
<%--   <input type="text" name="from_kakao" value="${from_kakao}" /> --%>
   <input type="hidden" name="user_type" value="G"> 
    <table border="1">
        <tr>
            <th>* 이메일</th>
            <td>
        <input type="text" id="user_email" name="user_email1" value="${user_email}"  onkeyup="checkEmail()" disabled >
           <input type="hidden" id="user_email" name="user_email" value="${user_email}"   >
                <span id="emailMessage" class=""></span>
                <form:errors path="user_email" cssClass="err"/>
            </td>
        </tr>

        <!-- Nickname Field in Form -->
        
           <tr>
            <th>* 이름</th>
            <td>
                <input type="text" id="user_name" name="user_name1" value="${user_name}"  onblur="checkName()" disabled>
                <input type="hidden" id="user_name" name="user_name" value="${user_name}"  >
                <span id="nameMessage" class=""></span>
                <form:errors path="user_name" cssClass="err"/>
            </td>
        </tr>
        <tr>
            <th>* 닉네임</th>
            <td>
                <input type="text" id="user_nickname" name="user_nickname" value="${member.user_nickname}" placeholder="닉네임을 입력해주세요" onblur="checkNickname()">
                <span id="nicknameMessage" class=""></span>
             <form:errors path="user_nickname" cssClass="err"/>
            </td>
        </tr>


        <tr>
            <th>* 비밀번호</th>
            <td>
                <input type="password" value = "1234" disabled>
                <input type="hidden"  id="user_passwd" name="user_passwd" value = "1234">
                <form:errors path="user_passwd" cssClass="err"/>
            </td>
        </tr>



        <tr>
            <th>* 휴대전화번호</th>
            <td>
                <input type="text" name="user_phone" value="${member.user_phone}" placeholder="휴대번호를 입력해주세요" oninput="formatPhoneNumber(this)" maxlength="13">
                <form:errors path="user_phone" cssClass="err"/>
            </td>
        </tr>

        <tr>
            <th>* 생년월일</th>
            <td>
                <input type="date" name="user_birth" value="${member.user_birth}">
                <form:errors path="user_birth" cssClass="err"/>
            </td>
        </tr>

        <tr>
            <th>* 성별</th>
            <td>
                <%
                String[] user_gender = { "여자", "남자" };
                %> 
                <c:forEach var="gender" items="<%=user_gender%>">
                    <input type="radio" name="user_gender" value="${gender}"
                    <c:if test="${member.user_gender eq gender}">checked</c:if>>${gender}
                </c:forEach>
                <form:errors path="user_gender" cssClass="err"/>
            </td>
        </tr>

        <tr>
            <th>* 주소</th>
            <td>
                <input type="button" id="find_button" value="주소 검색" class="find-button" onclick="execDaumPostcode()"><br>
                <input type="text" name="user_addr1" id="user_addr1" value="${user_addr1}" class="address-input" readonly>
                <input type="text" name="zonecode" id="zonecode" placeholder="우편번호" class="address-input" readonly><br>
                <input type="text" name="user_addr2" id="user_addr2" value="${user_addr2}" class="address-input"><br>
            </td>
        </tr>

        <tr>
            <th>* 프로필사진</th>
            <td>
                <input type="button" value="파일 선택하기" onclick="openFileSelector()"><br>
               ( 파일 선택하지 않으면 기본이미지로 저장)<br>
                <input type="file" id="profileInput" name="upload" class="profile-input">
                <div class="profile-container">
                    <div class="profile-image"></div>
                    <span id="profileFilename" class="profile-filename">기본이미지</span>
                </div>
            </td>
        </tr>

        <tr>
            <th colspan="2" align="center">
                <input type="submit" value="회원가입">
                <input type="button" value="돌아가기" onClick="location.href='loginForm.mb?pageNumber=${param.pageNumber}&whatColumn=${param.whatColumn}&keyword=${keyword}'">
            </th>
        </tr>
    </table>
</form:form>

</c:if>

<c:if test="${ user_email == null }">
<div class="container" id="content_container">
<h2 align="center">필수 정보 입력</h2>

<form:form modelAttribute="member" method="post" action="naverInsert.mb" enctype="multipart/form-data" onsubmit="return validateForm() && validatePassword()">
<%--   <input type="text" name="from_kakao" value="${from_kakao}" /> --%>
   <input type="hidden" name="user_type" value="G"> 
    <table border="1">
        <tr>
            <th>* 이메일</th>
            <td>
        <input type="text" id="user_email" name="user_email1" value="${member.user_email}"  onkeyup="checkEmail()" disabled >
           <input type="hidden" id="user_email" name="user_email" value="${member.user_email}"   >
                <span id="emailMessage" class=""></span>
                <form:errors path="user_email" cssClass="err"/>
            </td>
        </tr>

        <!-- Nickname Field in Form -->
        
           <tr>
            <th>* 이름</th>
            <td>
                <input type="text" id="user_name" name="user_name1" value="${member.user_name}"  onblur="checkName()" disabled>
                <input type="hidden" id="user_name" name="user_name" value="${member.user_name}"  >
                <span id="nameMessage" class=""></span>
                <form:errors path="user_name" cssClass="err"/>
            </td>
        </tr>
        <tr>
            <th>* 닉네임</th>
            <td>
                <input type="text" id="user_nickname" name="user_nickname" value="${member.user_nickname}" placeholder="닉네임을 입력해주세요" onblur="checkNickname()">
                <span id="nicknameMessage" class=""></span>
             <form:errors path="user_nickname" cssClass="err"/>
            </td>
        </tr>


        <tr>
            <th>* 비밀번호</th>
                
            <td>
            	<input type="hidden" name="user_passwd" value="1234" >
                <input type="password" id="user_passwd" name="user_passwd" value="1234" disabled>
                <form:errors path="user_passwd" cssClass="err"/>
            </td>
        </tr>

      

        <tr>
            <th>* 휴대전화번호</th>
            <td>
                <input type="text" name="user_phone" value="${member.user_phone}" placeholder="휴대번호를 입력해주세요" oninput="formatPhoneNumber(this)" maxlength="13">
                <form:errors path="user_phone" cssClass="err"/>
            </td>
        </tr>

        <tr>
            <th>* 생년월일</th>
            <td>
                <input type="date" name="user_birth" value="${member.user_birth}">
                <form:errors path="user_birth" cssClass="err"/>
            </td>
        </tr>

        <tr>
            <th>* 성별</th>
            <td>
                <%
                String[] user_gender = { "여자", "남자" };
                %> 
                <c:forEach var="gender" items="<%=user_gender%>">
                    <input type="radio" name="user_gender" value="${gender}"
                    <c:if test="${member.user_gender eq gender}">checked</c:if>>${gender}
                </c:forEach>
                <form:errors path="user_gender" cssClass="err"/>
            </td>
        </tr>

        <tr>
            <th>* 주소</th>
            <td>
                <input type="button" id="find_button" value="주소 검색" class="find-button" onclick="execDaumPostcode()"><br>
                <input type="text" name="user_addr1" id="user_addr1" value="${user_addr1}" class="address-input" readonly>
                <input type="text" name="zonecode" id="zonecode" placeholder="우편번호" class="address-input" readonly><br>
                <input type="text" name="user_addr2" id="user_addr2" value="${user_addr2}" class="address-input"><br>
            </td>
        </tr>

        <tr>
            <th>* 프로필사진</th>
            <td>
                <input type="button" value="파일 선택하기" onclick="openFileSelector()"><br>
               ( 파일 선택하지 않으면 기본이미지로 저장)<br>
                <input type="file" id="profileInput" name="upload" class="profile-input">
                <div class="profile-container">
                    <div class="profile-image"></div>
                    <span id="profileFilename" class="profile-filename">기본이미지</span>
                </div>
            </td>
        </tr>

        <tr>
            <th colspan="2" align="center">
                <input type="submit" value="회원가입">
                <input type="button" value="돌아가기" onClick="location.href='loginForm.mb?pageNumber=${param.pageNumber}&whatColumn=${param.whatColumn}&keyword=${keyword}'">
            </th>
        </tr>
    </table>
</form:form>
    </div>

</c:if>

 <%@include file="/resources/include/footer.jsp" %> 
