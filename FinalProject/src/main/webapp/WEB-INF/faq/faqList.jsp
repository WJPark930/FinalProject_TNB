<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
faqList.jsp<br>

<style>
    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
    }

    .btn-outline-primary {
        color: #007bff;
        border-color: #007bff;
    }
</style>

<head>
    <meta charset="UTF-8">
    <title>FAQ 목록</title>
</head>

<script type="text/javascript">
    function insert() {
        location.href = "insert.faq";
    }

    function goUpdate(faq_id, whatColumn, keyword) {
        location.href = "update.faq?faq_id=" + faq_id + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
    }

    function filterByCategory(category) {
        location.href = "list.faq?whatColumn=faq_category&keyword=" + encodeURIComponent(category);
    }

    function confirmDelete(faq_id, whatColumn, keyword) {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "delete.faq?faq_id=" + faq_id + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
        }
    }
</script>

<div class="container my-4">
    <h2 class="text-center mb-4">FAQ 목록 화면 (${pageInfo.totalCount})</h2>
    <form action="list.faq" method="get" class="form-inline justify-content-center mb-4">
        <select name="whatColumn" class="form-control mr-2">
            <option value="all" ${pageInfo.whatColumn == 'all' ? 'selected' : ''}>전체검색</option>
            <option value="faq_category" ${pageInfo.whatColumn == 'faq_category' ? 'selected' : ''}>카테고리</option>
            <option value="question" ${pageInfo.whatColumn == 'question' ? 'selected' : ''}>질문</option>
            <option value="answer" ${pageInfo.whatColumn == 'answer' ? 'selected' : ''}>답변</option>
        </select>
        <input type="text" name="keyword" value="${pageInfo.keyword}" class="form-control mr-2">
        <button type="submit" class="btn btn-primary">검색</button>
    </form>

    <div class="text-center mb-4">
        <!-- 전체 버튼 -->
        <button id="btn-all" class="btn category-btn" onClick="filterByCategory('')">전체</button>
        <!-- 카테고리 버튼들 -->
        <c:forEach var="category" items="${categoryList}">
            <button id="btn-${category}" class="btn category-btn" onClick="filterByCategory('${category}')">${category}</button>
        </c:forEach>
    </div>

    <div class="text-right mb-3">
        <button class="btn btn-success" onClick="insert()">추가하기</button>
    </div>

    <div class="accordion" id="faqAccordion">
        <c:forEach var="faq" items="${faqList}">
            <div class="accordion-item">
                <h2 class="accordion-header" id="heading${faq.faq_id}">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${faq.faq_id}" aria-expanded="false" aria-controls="collapse${faq.faq_id}">
                        Q: [${faq.faq_category}] ${faq.question}
                    </button>
                </h2>
                <div id="collapse${faq.faq_id}" class="accordion-collapse collapse" aria-labelledby="heading${faq.faq_id}" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        <p><a href="detail.faq?faq_id=${faq.faq_id}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}">A: ${faq.answer}</a></p>
                        <p class="text-right"><strong>작성일:</strong>
                            <fmt:parseDate value="${faq.created_date}" pattern="yyyy-MM-dd HH:mm:ss.S" var="createdDate"/>
                            <fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd HH:mm"/>
                        </p>
                        <p class="text-right"><strong>수정일:</strong>
                            <fmt:parseDate value="${faq.modified_date}" pattern="yyyy-MM-dd HH:mm:ss.S" var="modifiedDate"/>
                            <fmt:formatDate value="${modifiedDate}" pattern="yyyy-MM-dd HH:mm"/>
                        </p>
                        <div class="text-right">
                            <button class="btn btn-danger btn-sm" onClick="confirmDelete('${faq.faq_id}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')">삭제</button>
                            <button class="btn btn-warning btn-sm" onClick="goUpdate('${faq.faq_id}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')">수정</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>