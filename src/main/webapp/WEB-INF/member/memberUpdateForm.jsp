<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/member/login.css?after">
 
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
    .err {
        color: #dc3545;
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
        background-image: url('default-profile.png'); /* 기본 이미지 경로 설정 */
        background-size: cover;
        background-position: center;
        cursor: pointer;
    }
    .profile-input {
        display: none;
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
                }

                document.getElementById('user_addr1').value = addr + ' ' + data.zonecode + extraAddr;
                document.getElementById('user_addr2').focus();
            }
        }).open();
    }

    function validatePassword() {
        var passwd = document.getElementById('user_passwd').value;
        var confirmPasswd = document.getElementById('user_passwd_confirm').value;

        if (passwd !== confirmPasswd) {
            document.getElementById('pwmessage').textContent = "비밀번호가 일치하지 않습니다.";
            return false;
        } else {
            document.getElementById('pwmessage').textContent = "";
            return true;
        }
        
    }
    

<%
    String[] user_gender = { "여자", "남자" };
%> 

</script>
<div class="container-fruid min-vh-100 " id="content_container">
    <div class="content_mypage container">
        <%@include file="/resources/include/my_aside.jsp" %>
        <div class="content_area">
            <form:form commandName="member" method="post" action="update.mb?pageNumber=${pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}" enctype="multipart/form-data" onsubmit="return validatePassword()">
            <input type = "hidden" name = "user_type" value = "G">
            <input type="hidden" name="user_id" value="${member.user_id}">

            <div class="register_content_area register_insert_area profile_area">
                <h3 class="mt-3 pb-3">내 정보</h3>
                <p class="info_title">이메일*</p>
                <div class="info_content">
                    <input type="text" id="user_email" name="user_email" class="register_text_input" value="${member.user_email}" placeholder="이메일을 입력해주세요" onkeyup="checkEmail()">
                    <p><form:errors path="user_email" cssClass="err"/></p>
                </div>
                <p class="info_title">이름*</p>
                <div class="info_content">
                    <input type="text" id="user_name" name="user_name" class="register_text_input" value="${member.user_name}" placeholder="이름을 입력해주세요" onblur="checkName()">
                    <span id="nameMessage" class=""></span>
                    <p><form:errors path="user_name" cssClass="err"/></p>
                </div>
                <p class="info_title">닉네임*</p>
                <div class="info_content">
                    <input type="text" id="user_nickname" name="user_nickname" class="register_text_input" value="${member.user_nickname}" placeholder="닉네임을 입력해주세요" onblur="checkNickname()">
                    <span id="nicknameMessage" class=""></span>
                    <p><form:errors path="user_nickname" cssClass="err"/></p>
                </div>
                <p class="info_title">비밀번호*</p>
                <div class="info_content">
                    <input type="password" id="user_passwd" name="user_passwd"  class="register_text_input" value="${member.user_passwd}" placeholder="비밀번호를 입력해주세요">
                    <p><form:errors path="user_passwd" cssClass="err"/></p>
                </div>
                <p class="info_title">비밀번호 확인*</p>
                <div class="info_content">
                    <input type="password" id="user_passwd_confirm" class="register_text_input" placeholder="비밀번호를 재입력해주세요" onkeyup="validatePassword()">               
                    <div id="pwmessage" class="err"></div>
                </div>
                <p class="info_title">휴대전화번호*</p>
                <div class="info_content">
                    <input type="text" name="user_phone" class="register_text_input" value="${member.user_phone}" placeholder="휴대번호를 입력해주세요" oninput="formatPhoneNumber(this)" maxlength="13">
                    <p><form:errors path="user_phone" cssClass="err"/></p>
                </div>
                <p class="info_title">생년월일*</p>
                <div class="info_content">
                    <fmt:parseDate value="${member.user_birth}" var="dayFmt" pattern="yyyy-MM-dd"/>
                    <fmt:formatDate var="user_birth" value="${dayFmt}" pattern="yyyy-MM-dd"/>
                    <input type="date" name="user_birth"  class="register_text_input date_input" 
                     value="${user_birth}">
                    <p><form:errors path="user_birth" cssClass="err"/></p>
                </div>
                <p class="info_title">성별*</p>
                <div class="info_content">
                    <c:forEach items="<%=user_gender%>" var="gender" varStatus="vs">
                        <input type="radio" class="btn-check" name="user_gender" value="${gender}" 
                        id="btn-check-outlined${vs.index}" autocomplete="off"
                        <c:if test="${member.user_gender eq gender}">checked</c:if> >
                        <label class="btn btn-outline-secondary check_btn" for="btn-check-outlined${vs.index}">${gender}</label>
                    </c:forEach>
                    <p><form:errors path="user_gender" cssClass="err"/></p>
                </div>
                <p class="info_title">주소*</p>
                <div class="info_content">
                    <input type="text" name="user_addr1" id="user_addr1" value="${member.user_addr1}" 
                    class="address-input register_text_input addr_input" readonly>
                    <input type="button" id="find_button" value="주소 검색" class="find-button btn btn-secondary" onclick="execDaumPostcode()"><br>
                    <input type="text" name="zonecode" id="zonecode" placeholder="우편번호" 
                    class="address-input register_text_input addr_input" readonly><br>
                    <input type="text" name="user_addr2" id="user_addr2" value="${member.user_addr2}" 
                    class="address-input register_text_input addr_input"><br>
                </div>
                <p class="info_title">프로필사진*<span>파일 선택하지 않으면 기본이미지로 저장</span></p>
                <div class="info_content">
                    <input type="hidden" name="upload2" value="${member.user_image}">
                    <div class="profile-container">
                        <div class="profile-image"><img src="<%=request.getContextPath() + "/resources/images/" %>${member.user_image}"/></div>
                        <div class="ms-3">
                            <input type="file"  name="upload" value="${member.user_image}">
                        </div>
                    </div>
                </div>
            </div>
            <div class="btn_area profile_area">
                <div class="text-end">
                    <input type="submit" value="정보수정" class="btn btn-primary">
                    <input type="button" value="계정탈퇴" class="btn btn-danger"
                    onclick="delete_check()">           
                </div>
            </div>
            </form:form>
        </div>
    </div>
</div>                


 <script>

   function delete_check(){
      if(confirm("탈퇴하시겠습니까?")){
         location.href='delete.mb?user_id=${member.user_id}&type=leave';
         alert("탈퇴되었습니다.");
      }
   }

</script>

<%@include file="/resources/include/footer.jsp" %>
