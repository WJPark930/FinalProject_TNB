<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>

loginSuccess.jsp<br>

<%-- <script>
	function gotoMyPage() {
		//alert('1');
		alert(${sessionScope.loginInfo.user_id});
		location.href = "memberMyPage.mb?user_id=${sessionScope.loginInfo.user_id}" ;
	}

</script>


<input type = "button" value = "마이페이지" onClick = "gotoMyPage()">

<form:form commandName="member" action="update2.mb" enctype="multipart/form-data" onsubmit="return validatePassword()">
</form:form> --%>

<script>
    function gotoMyPage() {
        var userId = '${sessionScope.loginInfo.user_id}';
        var email = '${sessionScope.loginInfo.user_email}';
        var userType = '${sessionScope.loginInfo.user_type}';

       // alert("userType : " + userType)
        if (email === 'admin') {
            location.href = 'gotoAdminPage.mb?user_id=' + userId;
        } else if (userType === 'G') {
            location.href = 'memberMyPage.mb?user_id=' + userId;
        } else if (userType === 'B') {
            location.href = 'businessMyPage.mb?user_id=' + userId;
        } else {
            alert('유효하지 않은 사용자 유형입니다.');
        }
    }
</script>

<input type="button" value="마이페이지" onClick="gotoMyPage()">

<form:form commandName="member" action="" enctype="multipart/form-data" onsubmit="return validatePassword()">
</form:form>