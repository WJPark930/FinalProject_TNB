<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp"%>
 
<style>
	.form-check {
		display: inline-block;
	}	

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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<div class="container mt-5">
	<div class="row justify-content-center">
		<div class="col-md-8">
			<div class="card" style="margin-top: 75px;">
				<div class="card-header text-white text-right" style="background-color:#80B156;">
					<label>글 작성</label>
				</div>
				<div class="card-body">
					<form:form commandName="board" action="write.bd" method="post">
						<input type="hidden" name="pageNumber" value="${param.pageNumber}">
						<input type="hidden" name="keyword" value="${param.keyword}">
						<input type="hidden" name="whatColumn" value="${param.whatColumn}">
						<input type="hidden" name="user_id" maxlength="10" value="${sessionScope.loginInfo.user_id}">

						<div class="form-group">
							<label for="user_id">이름</label>
							<input type="hidden" name="user_id" class="form-control" maxlength="10" value="${board.user_id}">
							<input type="text" class="form-control" value="${loginInfo.user_email}" readonly="readonly">
							<form:errors path="user_id" cssClass="err"/>
						</div>

							<div style="margin-bottom:10px;"></div>
							<label>카테고리</label>
							<div class="">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="cate_id" id="cate1" value="1" checked>
									<label class="form-check-label" for="cate1">자유 게시판</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="cate_id" id="cate2" value="2">
									<label class="form-check-label" for="cate2">떠나봄 게시판</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="cate_id" id="cate3" value="3">
									<label class="form-check-label" for="cate3">구인,구직 게시판</label>							
								</div>
							</div>
								<form:errors path="cate_id" cssClass="err"/>

						<div class="form-group" style="margin-bottom:10px;">
							<label for="title">제목</label>
							<input type="text" id="title" name="title" class="form-control">
							<form:errors path="title" cssClass="err"/>
						</div>

						<div class="form-group" style="margin-bottom:10px;">
							<label for="content">내용</label>
							<textarea id="content" name="content" class="form-control" rows="5" style="text-align: left;"></textarea>
							<form:errors path="content" cssClass="err"/>
						</div>

						<div class="form-group" style="margin-bottom:10px;">
							<label for="passwd">비밀번호</label>
							<input type="password" id="passwd" name="passwd" class="form-control">
							<form:errors path="passwd" cssClass="err"/>
						</div>

						<div class="text-center" style="margin-top: 15px;">
							<button type="submit" class="btn btn-success" style="background-color: #80B156; border: 0px;">글 작성</button>
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

<div class="container" style="margin-bottom: 75px;">
    <table class="table table-striped">
        <tr>
            <th colspan="6" style="text-align:center; background-color: #80B156; color:white;">게시물 목록</th>
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
                        <c:when test="${bl.cate_id == 1}">자유 게시판</c:when>
                        <c:when test="${bl.cate_id == 2}">떠나봄 게시판</c:when>
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

		<%-- <tr>
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
		</tr> --%>
    </table>
</div>

<%@ include file="../../resources/include/footer.jsp"%>
