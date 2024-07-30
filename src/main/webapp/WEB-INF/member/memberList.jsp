<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %>
 
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/member/mypage.css?after">


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
    
    function handleStatusKeyword() {
        const whatColumn = document.querySelector('select[name="whatColumn"]').value;
        let keywordInput = document.querySelector('input[name="keyword"]');
        if (whatColumn === 'user_type') {
            if (keywordInput.value.includes('일')) {
                keywordInput.value = 'G';
            } else if (keywordInput.value.includes('사')) {
                keywordInput.value = 'B';
            }
        }
    }
</script>


<div class="container-fluid min-vh-100" id="content_container">
    <div class="content_mypage container">
        <%@ include file="/resources/include/admin_aside.jsp" %> 
        
        <div class="content_area">
            <h2>회원 목록</h2>

            <form action="memberList.mb" method="get" class="search-form">
                <select name="whatColumn">
                    <option value="all">전체 검색</option>
                    <option value="user_gender">성별</option>
                    <option value="user_status">정지여부</option>
                    <option value="user_type">회원구분</option>
                </select>
                <input type="text" name="keyword" value="" placeholder="검색어를 입력하세요">
                <input type="submit" class="btn btn-success" style="background-color: #80B156; border:0px;" value="검색">
            </form>

            <div class="table-container">
                <table style="border: 0px;">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>이메일</th>
                            <th>비밀번호</th>
                            <th>성별</th>
                            <th>회원구분</th>
                            <th>정지여부</th>
                            <th>삭제</th>
                            <!-- <th>수정</th> -->
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="member" items="${memberLists}">
                            <tr>
                                <td><a href="detail.mb?user_id=${member.user_id}&pageNumber=${pageInfo.pageNumber}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}">${member.user_id}</a></td>
                                <td>${member.user_email}</td>
                                <td>${member.user_passwd}</td>
                                <td>${member.user_gender}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${member.user_type == 'G'}">일반회원</c:when>
                                        <c:when test="${member.user_type == 'B'}">사업자회원</c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <input type="radio" name="user_status_${member.user_id}" value="Y" <c:if test="${member.user_status == 'Y'}">checked</c:if> onClick="updateStatus('${member.user_id}', 'Y', '${pageInfo.pageNumber}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')"> Y
                                    <input type="radio" name="user_status_${member.user_id}" value="N" <c:if test="${member.user_status == 'N'}">checked</c:if> onClick="updateStatus('${member.user_id}', 'N', '${pageInfo.pageNumber}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')"> N
                                </td>
                                <td>
                                    <button class="bi bi-trash-fill" style="background-color: ffffff" onclick="confirmDelete(${member.user_id}, '${pageInfo.pageNumber}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')"></button>
                                </td>
							<%--<td>
                                    <button class="bi bi-pencil-square" style="background-color: ffffff" onclick="goUpdate('${member.user_id}', '${pageInfo.pageNumber}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')"></button>
                                </td> --%>
                            </tr>
                            
                        </c:forEach>
                       		 <tr>
                            	<td colspan="8" align="center">
                            		${pageInfo.pagingHtml}
                            	</td>
                            </tr>
                    </tbody>
                </table>             
            </div>
        </div>
    </div>
</div>


</body>
<%@include file="/resources/include/footer.jsp" %>
