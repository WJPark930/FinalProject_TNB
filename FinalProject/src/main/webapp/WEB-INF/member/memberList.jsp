<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
memberList.jsp<br>

<script type="text/javascript">
    function insert() {
        location.href = "insertuser.mb";
    }

    function goUpdate(user_id, pageNumber, whatColumn, keyword) {
        location.href = "update.mb?user_id=" + user_id + "&pageNumber=" + pageNumber + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
    }

    function updateStatus(user_id, status, pageNumber, whatColumn, keyword) {
        let message = status === 'Y' ? '회원을 정지하시겠습니까?' : '회원을 정상으로 수정하시겠습니까?';
        if (confirm(message)) {
            location.href = "updateStatus.mb?user_id=" + user_id + "&status=" + status + "&pageNumber=" + pageNumber + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
        } else {
            // 상태 변경을 취소한 경우, 기존 상태로 되돌리기
            document.querySelector('input[name="user_status_' + user_id + '"][value="' + (status === 'Y' ? 'N' : 'Y') + '"]').checked = true;
        }
    }
    
    function confirmDelete(userId, pageNumber, whatColumn, keyword) {
        if (confirm("삭제하시겠습니까?")) {
            alert("삭제 성공");
            location.href = "delete.mb?user_id=" + userId + "&pageNumber=" + pageNumber + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
        } else {
            alert("삭제 실패");
        }
    }
</script>

<center>
<h2>회원 리스트 화면(${pageInfo.totalCount})</h2>
현재 클릭한 페이지번호 : ${pageInfo.pageNumber}<br>
<form action="memberList.mb" method="get">
    <select name="whatColumn">
        <option value="all">전체 검색</option>
        <option value="user_gender">성별</option>
        <option value="user_status">정지여부</option>
        <option value="user_type">회원구분</option>
    </select>
    <input type="text" name="keyword" value="">
    <input type="submit" value="검색">
</form>
</center>

<table border="1" align="center">

<tr align="center">
    <th>ID</th>
    <th>이메일</th>
    <th>비밀번호</th>
    <th>성별</th>
    <th>회원구분</th>
    <th>정지여부</th>
    <th>삭제</th>
    <th>수정</th>
</tr>

<c:forEach var="member" items="${memberLists}">
<tr align="center">
    <td><a href="detail.mb?user_id=${member.user_id}&pageNumber=${pageInfo.pageNumber}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}">${member.user_id}</a></td>
    <td>${member.user_email}</td>
    <td>${member.user_passwd}</td>
    <td>${member.user_gender}</td>
    <td>${member.user_type}</td>
    <td>
        <input type="radio" name="user_status_${member.user_id}" value="Y" <c:if test="${member.user_status == 'Y'}">checked</c:if> onClick="updateStatus('${member.user_id}', 'Y', '${pageInfo.pageNumber}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')"> Y
        <input type="radio" name="user_status_${member.user_id}" value="N" <c:if test="${member.user_status == 'N'}">checked</c:if> onClick="updateStatus('${member.user_id}', 'N', '${pageInfo.pageNumber}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')"> N
    </td>
<td>
                <button onclick="confirmDelete(${member.user_id}, '${param.pageNumber}', '${param.whatColumn}', '${param.keyword}')">삭제</button>
            </td>
                <td><input type="button" value="수정" onClick="goUpdate('${member.user_id}', '${pageInfo.pageNumber}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')"></td>
</tr>
</c:forEach>
</table>

<p align="center">${pageInfo.pagingHtml}</p>
