<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp"%>
 
<h1>숙소관리</h1>
<form action="shopList.sp" method="get"></form>
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

<div class="container-fruid min-vh-100 " id="content_container">
	<div class="content_mypage container">
		<%@include file="/resources/include/admin_aside.jsp"%>

		<div class="content_area">
			<h2>숙소 목록</h2>

			<form action="shopList.sp" method="get" class="search-form" onsubmit="handleStatusKeyword()">
				<select name="whatColumn">
					<option value="all">전체 검색</option>
					<option value="shop_name">시설명</option>
					<option value="region">지역</option>
					<option value="shop_grade">평점</option>
					<option value="shop_status">시설상태</option>
				</select> <input type="text" name="keyword" value=""> <input
					type="submit" style="background-color: #80B156; border: 0px;"
					class="btn btn-success" value="검색">
			</form>

			<div class="table-responsive">
				<table class="table table-bordered table-hover">
					<thead class="table-light">
						<tr class="text-center">
							<th>시설ID</th>
							<th>지역</th>
							<th>시설명</th>
							<th>평점</th>
							<th>삭제</th>
						</tr>
					<thead>
					<tbody>
						<c:forEach var="shop" items="${shopLists}">
							<tr class="text-center">
								<td>${shop.shop_id}</td>
								<td>${shop.region}</td>
								<td>${shop.shop_name}</td>
								<td>${shop.grade}</td>

								<td>
									<button style="border:0px; background-color:transparent" class="bi bi-trash-fill" onclick="confirmDelete(${shop.shop_id}, '${param.pageNumber}', '${param.whatColumn}', '${param.keyword}')"></button>
								</td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="5" class="text-center">${pageInfo.pagingHtml}</td>
						</tr>

					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<%@include file="/resources/include/footer.jsp"%>
