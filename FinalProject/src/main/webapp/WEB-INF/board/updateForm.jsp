<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/resources/include/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<style>


	.err {
		color: red;
		font-size: 12px;
		font-weight: bold;
		font-style: italic;
	}

	table {
		width: 1000px;
	}

	td {
		text-align: center;
	}

	a {
		text-decoration: none;
		text-align: center;
	}
</style>

<div class="container mt-5">
	<div class="row justify-content-center">
		<div class="col-md-8">
			<div class="card">
				<div class="card-header bg-success text-white text-right">
					<a href="list.bd?pageNumber=${param.pageNumber}" class="text-white">글 목록</a>
				</div>
				<div class="card-body">
					<form:form commandName="board" action="update.bd" method="post">
						<input type="hidden" name="bid" value="${board.bid}">
						<input type="hidden" name="pageNumber" value="${param.pageNumber}">
						<input type="hidden" name="keyword" value="${param.keyword}">
						<input type="hidden" name="whatColumn" value="${param.whatColumn}">

						<div class="form-group">
							<label for="user_id">이름</label>
							<input type="text" id="user_id" name="user_id" class="form-control" maxlength="10" value="${board.user_id}">
							<form:errors path="user_id" cssClass="err"/>
						</div>

						
							<label>카테고리</label>
							<div class="form-check">
								<input class="form-check-input" type="radio" name="cate_id" id="cate1" value="1" <c:if test="${board.cate_id eq 1}">checked</c:if>>
								<label class="form-check-label" for="cate1">전체 게시판</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="radio" name="cate_id" id="cate2" value="2" <c:if test="${board.cate_id eq 2}">checked</c:if>>
								<label class="form-check-label" for="cate2">자유 게시판</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="radio" name="cate_id" id="cate3" value="3" <c:if test="${board.cate_id eq 3}">checked</c:if>>
								<label class="form-check-label" for="cate3">구인,구직 게시판</label>							
							</div>
								<form:errors path="cate_id" cssClass="err"/>

						<div class="form-group">
							<label for="title">제목</label>
							<input type="text" id="title" name="title" class="form-control" value="${board.title}">
							<form:errors path="title" cssClass="err"/>
						</div>

						<div class="form-group">
							<label for="content">내용</label>
							<textarea id="content" name="content" class="form-control" rows="5">${board.content}</textarea>
							<form:errors path="content" cssClass="err"/>
						</div>

						<div class="form-group">
							<label for="passwd">비밀번호</label>
							<input type="password" id="passwd" name="passwd" class="form-control">
							<form:errors path="passwd" cssClass="err"/>
						</div>

						<div class="text-center">
							<button type="submit" class="btn btn-success">글 수정</button>
							<button type="reset" class="btn btn-secondary">다시작성</button>
							<button type="button" class="btn btn-secondary" onClick="location='list.bd?pageNumber=${param.pageNumber}'">목록보기</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
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
				<td align="left">
					<c:choose>
						<c:when test="${bl.cate_id == 1}">전체 게시판</c:when>
						<c:when test="${bl.cate_id == 2}">자유 게시판</c:when>
						<c:when test="${bl.cate_id == 3}">구인,구직 게시판</c:when>
					</c:choose>
					<a href="content.bd?bid=${bl.bid}&pageNumber=${pageInfo.pageNumber}">${bl.title}</a>
				</td>
				<td>${bl.user_email}</td>
				<td>${bl.readcount}</td>
				<td><fmt:formatDate value="${bl.created_at}" pattern="yyyy/MM/dd HH:mm"/></td>
				<td><fmt:formatDate value="${bl.updated_at}" pattern="yyyy/MM/dd HH:mm"/></td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="6">
				<c:forEach var="i" begin="${pageInfo.beginPage}" end="${pageInfo.endPage}">
					<c:choose>
						<c:when test="${i eq pageInfo.pageNumber}">${i}</c:when>
						<c:otherwise>
							<a href="list.bd?pageNumber=${i}&pageSize=${pageInfo.pageSize}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</td>
		</tr>
	</table>
</div>

<%@ include file="../../resources/include/footer.jsp"%>
