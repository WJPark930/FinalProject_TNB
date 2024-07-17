<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
shopList.jsp<br>


<h1>숙소관리</h1>
<form action="shopList.sp" method="get">
</form>
<script type="text/javascript">

function goUpdate(shop_id, pageNumber, whatColumn, keyword) {
    location.href = "shop.sp?shop_id=" + shop_id + "&pageNumber=" + pageNumber + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
}

function confirmDelete(shop_id, pageNumber, whatColumn, keyword) {
    if (confirm("삭제하시겠습니까?")) {
        alert("삭제 성공");
        location.href = "delete.sp?shop_id=" + shop_id + "&pageNumber=" + pageNumber + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
    } else {
        alert("삭제 실패");
    }
}

function updateStatus(shop_id, status, pageNumber, whatColumn, keyword) {
    let message = status === 'Y' ? '시설을 정지하시겠습니까?' : '시설을 정상으로 수정하시겠습니까?';
    if (confirm(message)) {
        location.href = "updateStatus.sp?shop_id=" + shop_id + "&status=" + status + "&pageNumber=" + pageNumber + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
    } else {
        // 상태 변경을 취소한 경우, 기존 상태로 되돌리기
        document.querySelector('input[name="shop_status_' + shop_id + '"][value="' + (status === 'Y' ? 'N' : 'Y') + '"]').checked = true;
    }
}

function handleStatusKeyword() {
    const whatColumn = document.querySelector('select[name="whatColumn"]').value;
    let keywordInput = document.querySelector('input[name="keyword"]');
    if (whatColumn === 'shop_status') {
        if (keywordInput.value.includes('정')) {
            keywordInput.value = 'Y';
        } else if (keywordInput.value.includes('운')) {
            keywordInput.value = 'N';
        }
    }
}
</script>

<center>
<h2>숙소 리스트 화면(${pageInfo.totalCount})</h2>
현재 클릭한 페이지번호 : ${pageInfo.pageNumber}<br>
<form action="shopList.sp" method="get" onsubmit="handleStatusKeyword()">
    <select name="whatColumn">
        <option value="all">전체 검색</option>
        <option value="shop_name">시설명</option>
        <option value="shop_region">지역</option>
        <option value="shop_grade">평점</option>
        <option value="shop_status">시설상태</option>
    </select>
    <input type="text" name="keyword" value="">
    <input type="submit" value="검색">
</form>
</center>

<table border="1" align="center">
<tr align ="center">
    <th>시설ID</th>
    <th>지역</th>
    <th>시설명</th>
    <th>평점</th>
    <th>시설상태</th>   
    <th>삭제</th>
    <!-- <th>수정</th> -->
</tr>




<c:forEach var="shop" items="${shopLists}">
<tr align="center">
<td>${shop.shop_id}</td>
<td>${shop.shop_region}</td>
<td>${shop.shop_name}</td>
<td>${shop.shop_grade}</td>
  <td>
<input type="radio" name="shop_status_${shop.shop_id}" value="Y" <c:if test="${shop.shop_status == 'Y'}">checked</c:if> onClick="updateStatus('${shop.shop_id}', 'Y', '${pageInfo.pageNumber}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')"> 정지
<input type="radio" name="shop_status_${shop.shop_id}" value="N" <c:if test="${shop.shop_status == 'N'}">checked</c:if> onClick="updateStatus('${shop.shop_id}', 'N', '${pageInfo.pageNumber}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')"> 운영중
    </td>

<td>
<button onclick="confirmDelete(${shop.shop_id}, '${param.pageNumber}', '${param.whatColumn}', '${param.keyword}')">삭제</button>
            </td>
<%-- <td><input type="button" value="수정" onClick="goUpdate('${shop.shop_id}', '${pageInfo.pageNumber}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')"></td>
 --%></tr>
</c:forEach>
</table>

<p align="center">${pageInfo.pagingHtml}</p>


