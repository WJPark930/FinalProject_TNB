<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
 
	<style>
		#content_container {
			padding-top: 76px;
			padding-bottom: 50px;
		}
	    .btn-primary {
	        background-color: #007bff;
	        border-color: #007bff;
	    }
	
	    .btn-outline-primary {
	        color: #007bff;
	        border-color: #007bff;
	    }
	    .faq-title {
	        font-size: 3rem;
	        font-family: 'NanumSquare_B';
	    }
	    .category-btn {
	        margin: 0.4rem;
	    }
	</style>


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

	<div class="container" id="content_container">
	    <h2 class="text-center mb-4 faq-title">FAQ</h2>
	    
	    <!-- 검색 폼 -->
	    <div class="row justify-content-center">
	        <div class="col-12 col-md-8">
	            <form action="user.faq" method="get" class="search-form">
	                <div class="row mb-2">
	                    <div class="col-12 col-md-3 mb-2 mb-md-0">
	                        <select name="whatColumn" class="form-select">
	                            <option value="all" ${pageInfo.whatColumn == 'all' ? 'selected' : ''}>전체검색</option>
	                            <option value="faq_category" ${pageInfo.whatColumn == 'faq_category' ? 'selected' : ''}>카테고리</option>
	                            <option value="question" ${pageInfo.whatColumn == 'question' ? 'selected' : ''}>질문</option>
	                            <option value="answer" ${pageInfo.whatColumn == 'answer' ? 'selected' : ''}>답변</option>
	                        </select>
	                    </div>
	                    <div class="col-12 col-md-6 mb-2 mb-md-0">
	                        <input type="text" name="keyword" value="${pageInfo.keyword}" class="form-control" placeholder="검색어를 입력하세요">
	                    </div>
	                    <div class="col-12 col-md-3">
	                        <button type="submit" class="btn btn-primary w-100">검색</button>
	                    </div>
	                </div>
	            </form>
	        </div>
	    </div>
	
	    <!-- 카테고리 버튼들 -->
	    <div class="row justify-content-center">
		    <div class="col-12 col-md-8">
			    <div class="text-center mb-2">
			        <button id="btn-all" class="btn btn-outline-primary category-btn" onClick="filterByCategory('')">전체</button>
			        <c:forEach var="category" items="${categoryList}">
			            <button id="btn-${category}" class="btn btn-outline-primary category-btn" onClick="filterByCategory('${category}')">${category}</button>
			        </c:forEach>
			    </div>
		    </div>
	    </div>
		
		<div class="row justify-content-center">
			<div class="col-md-12">
		        <div class="d-flex justify-content-between align-items-center mb-2">
				    <div class="ms-2">
				        <span>글 수: ${pageInfo.totalCount}</span>
				    </div>
				    <div class="me-2">
				        <button class="btn btn-success" onClick="insert()">추가하기</button>
				    </div>
				</div>
			</div>
		</div>
		
	    <div class="accordion" id="faqAccordion">
	    	<div class="row justify-content-center">
		    	<div class="col-md-12">
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
			                        <div class="text-end">
				                        <p class="text-right"><strong>작성일:</strong>
				                            <fmt:parseDate value="${faq.created_date}" pattern="yyyy-MM-dd HH:mm:ss.S" var="createdDate"/>
				                            <fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd HH:mm"/>
				                        </p>
				                        <p class="text-right"><strong>수정일:</strong>
				                            <fmt:parseDate value="${faq.modified_date}" pattern="yyyy-MM-dd HH:mm:ss.S" var="modifiedDate"/>
				                            <fmt:formatDate value="${modifiedDate}" pattern="yyyy-MM-dd HH:mm"/>
				                        </p>
				                        <div class="text-right">
				                            <button class="btn btn-warning btn-sm" onClick="goUpdate('${faq.faq_id}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')">수정</button>
				                            <button class="btn btn-danger btn-sm" onClick="confirmDelete('${faq.faq_id}', '${pageInfo.whatColumn}', '${pageInfo.keyword}')">삭제</button>
				                        </div>
				                	</div>        
			                    </div>
			                </div>
			            </div>
			        </c:forEach>
		    	</div>
			</div>
	    </div>
	</div>

	<%@include file="/resources/include/footer.jsp" %>