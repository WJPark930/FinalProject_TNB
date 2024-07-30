<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style> 
    .err {
        color: red;
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
</script>

<h2 align="center">회원수정화면</h2>

<form:form commandName="member" action="MYupdate.mb?pageNumber=${param.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}" enctype="multipart/form-data" onsubmit="return validatePassword()">
    <input type = "hidden" name = "user_type" value = "G">
    <table border=1>
        <tr>
            <th>회원번호</th>
            <td>
                <input type="text" name="user_id" value="${member.user_id}" disabled>
                <input type="hidden" name="user_id" value="${member.user_id}">
            </td>
        </tr>
        <tr>
            <th>* 이메일</th>
            <td>
                <input type="text" name="user_email" value="${member.user_email}">
                <form:errors path="user_email" cssClass="err"/>
            </td>
        </tr>

        <tr>
            <th>* 닉네임</th>
            <td>
                <input type="text" name="user_nickname" value="${member.user_nickname}">
                <form:errors path="user_nickname" cssClass="err"/>
            </td>
        </tr>

        <tr>
            <th>* 비밀번호</th>
            <td>
                <input type="password" id="user_passwd" name="user_passwd" value="${member.user_passwd}">
                <form:errors path="user_passwd" cssClass="err"/>
            </td>
        </tr>
        
        <tr>
            <th>* 비밀번호 확인</th>
            <td>
                <input type="password" id="user_passwd_confirm" placeholder="비밀번호를 재입력해주세요">
                <div id="pwmessage" class="err"></div>
            </td>
        </tr>

        <tr>
            <th>* 휴대전화번호</th>
            <td>
                <input type="text" name="user_phone" value="${member.user_phone}">
                <form:errors path="user_phone" cssClass="err"/>
            </td>
        </tr>

        <tr>
            <th>* 생년월일</th>
            <td>
                <fmt:parseDate value="${member.user_birth}" var="dayFmt" pattern="yyyy-MM-dd"/>
                <fmt:formatDate var="user_birth" value="${dayFmt}" pattern="yyyy-MM-dd"/>
                <input type="date" name="user_birth" value="${user_birth}">
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
                <input type="text" name="user_addr1" id="user_addr1" placeholder="주소 검색해주세요" class="address-input" readonly value="${member.user_addr1}">
                <input type="text" name="user_addr2" id="user_addr2" placeholder="상세주소" class="address-input" value="${member.user_addr2}"><br>
            </td>
        </tr>
        
        <tr>
            <th>* 프로필사진</th>
            <td>
                <img src="<%=request.getContextPath() + "/resources/images/" %>${member.user_image}" width="100" height="100"/> <br><br>
                <input type="file" name="upload" value="${member.user_image}"><br><br>
                <input type="hidden" name="upload2" value="${member.user_image}">
                <form:errors path="user_image" cssClass="err"/>
            </td>
        </tr>
        
        <tr>
    <td>회원 정지 여부</td>
    <td>
        <input type="radio" name="user_status" value="Y" <c:if test="${member.user_status == 'Y'}">checked</c:if> disabled="disabled"> Y
        <input type="radio" name="user_status" value="N" <c:if test="${member.user_status == 'N'}">checked</c:if> disabled="disabled"> N
    </td>
</tr>
        
    </table>
        <tr>
            <th colspan="2" align="center">
                <input type="submit" value="정보수정하기">
                <input type="button" value="돌아가기" onClick="location.href='memberList.mb?pageNumber=${param.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}'">
            </th>
        </tr>
</form:form>
<%@include file="/resources/include/footer.jsp" %>
