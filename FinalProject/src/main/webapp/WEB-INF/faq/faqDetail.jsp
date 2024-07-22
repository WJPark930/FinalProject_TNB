<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FAQ 상세보기</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap JS 및 종속성 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container my-4">
    <h2 class="text-center mb-4">FAQ 상세보기</h2>
    <table class="table table-bordered">
        <tr>
            <th>번호</th>
            <td>${faq.faq_id}</td>
        </tr>
        <tr>
            <th>질문내용</th>
            <td>[${faq.faq_category}] ${faq.question}</td>
        </tr>
        <tr>
            <th>답변내용</th>
            <td>${faq.answer}</td>
        </tr>
        <tr>
            <td colspan="2" class="text-center">
                <button class="btn btn-primary" onClick="goList('${param.whatColumn}', '${param.keyword}')">FAQ 목록</button>
                <button class="btn btn-warning" onClick="goUpdate('${faq.faq_id}', '${param.whatColumn}', '${param.keyword}')">수정하기</button>
                <button class="btn btn-danger" onClick="goDelete('${faq.faq_id}', '${param.whatColumn}', '${param.keyword}')">삭제하기</button>
            </td>
        </tr>
    </table>
</div>

<script type="text/javascript">
    function goList(whatColumn, keyword) {
        location.href = "list.faq?whatColumn=" + whatColumn + "&keyword=" + keyword;
    }
    function goUpdate(faq_id, whatColumn, keyword) {
        location.href = "update.faq?faq_id=" + faq_id + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
    }
    function goDelete(faq_id, whatColumn, keyword) {
        location.href = "delete.faq?faq_id=" + faq_id + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
    }
</script>
</body>
</html>