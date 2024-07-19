<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp"%>

<style>
    .err {
        color: red;
        font-size: 12px;
        font-weight: bold;
        font-style: italic;
    }

    .form-container {
        max-width: 800px;
        margin: auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 8px;
        background-color: #f9f9f9;
    }

    .form-container h3 {
        text-align: center;
        color: navy;
        margin-bottom: 20px;
    }

    .form-container label {
        font-weight: bold;
    }

    .form-container input[type="text"],
    .form-container textarea {
        width: 100%;
        padding: 8px;
        margin: 5px 0 15px 0;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .form-container input[type="submit"],
    .form-container input[type="reset"],
    .form-container input[type="button"] {
        background-color: navy;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-right: 10px;
    }

    .form-container input[type="radio"] {
        margin-right: 5px;
    }

    .form-container .btn-group {
        margin-bottom: 20px;
    }
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<div class="container form-container">
    <h3>글쓰기(원글)</h3>
    <form:form commandName="board" action="write.bd" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>이름:</label>
            <input type="hidden" name="user_id" maxlength="10" value="${sessionScope.loginInfo.user_id}">
            <label>${sessionScope.loginInfo.user_email}</label>
        </div>

        <div class="form-group">
            <label>카테고리:</label>
            <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-secondary active">
                    <input type="radio" name="cate_id" value="1" id="cate1" checked> 전체 게시판
                </label>
                <label class="btn btn-secondary">
                    <input type="radio" name="cate_id" value="2" id="cate2"> 자유 게시판
                </label>
                <label class="btn btn-secondary">
                    <input type="radio" name="cate_id" value="3" id="cate3"> 구인,구직 게시판
                </label>
            </div>
            <form:errors path="cate_id" cssClass="err"/>
        </div>

        <div class="form-group">
            <label>제목:</label>
            <input type="text" name="title" class="form-control">
            <form:errors path="title" cssClass="err"/>
        </div>

        <div class="form-group">
            <label>내용:</label>
            <textarea name="content" rows="5" class="form-control"></textarea>
            <form:errors path="content" cssClass="err"/>
        </div>

        <div class="form-group">
            <label>비밀번호:</label>
            <input type="password" name="passwd" class="form-control">
            <form:errors path="passwd" cssClass="err"/>
        </div>

        <div class="form-group" style="text-align: center;">
            <input type="submit" value="글쓰기" class="btn btn-primary">
            <input type="reset" value="다시작성" class="btn btn-secondary">
            <input type="button" value="목록보기" onClick="location='list.bd?pageNumber=${pageNumber}'" class="btn btn-info">
        </div>
    </form:form>
</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div class="container">
		<table class="table table-striped" border="1" align="center">
			<tr>
				<th colspan="6">게시물 목록</th>
			</tr>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
				<th>수정일</th>
			</tr>
			<c:forEach var="bl" items="${BoardLists}">
				<tr>
					<td>${bl.bid}</td>
					<td align="left"><c:choose>
							<c:when test="${bl.cate_id == 1}">전체 게시판</c:when>
							<c:when test="${bl.cate_id == 2}">자유 게시판</c:when>
							<c:when test="${bl.cate_id == 3}">구인,구직 게시판</c:when>
						</c:choose> <a
						href="content.bd?bid=${bl.bid}&pageNumber=${pageInfo.pageNumber}">${bl.title}</a>
					</td>
					<td>${bl.user_email}</td>
					<td>${bl.readcount}</td>
					<td><fmt:formatDate value="${bl.created_at}"
							pattern="yyyy/MM/dd HH:mm" /></td>
					<td><fmt:formatDate value="${bl.updated_at}"
							pattern="yyyy/MM/dd HH:mm" /></td>
				</tr>
			</c:forEach>

			<tr>
				<td colspan="6" align="center"><c:forEach var="i" begin="${pageInfo.beginPage}" end="${pageInfo.endPage}">
						<c:choose>
							<c:when test="${i eq pageInfo.pageNumber}">
                                ${i}
                            </c:when>
							<c:otherwise>
								<a
									href="list.bd?pageNumber=${i}&pageSize=${pageInfo.pageSize}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach></td>
			</tr>
		</table>
	</div>

<%@ include file="../../resources/include/footer.jsp"%>
