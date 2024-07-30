<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	    function filterByCategory(category) {
	        location.href = "user.faq?whatColumn=faq_category&keyword=" + encodeURIComponent(category);
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
	    <div class="text-center mb-4">
	        <button id="btn-all" class="btn btn-outline-primary category-btn" onClick="filterByCategory('')">전체</button>
	        <c:forEach var="category" items="${categoryList}">
	            <button id="btn-${category}" class="btn btn-outline-primary category-btn" onClick="filterByCategory('${category}')">${category}</button>
	        </c:forEach>
	    </div>

        <!-- FAQ 아코디언 -->
        <div class="accordion" id="faqAccordion">
	    	<div class="row justify-content-center">
				
		            <c:forEach var="faq" items="${faqList}">
		                <div class="accordion-item">
		                    <h2 class="accordion-header" id="heading${faq.faq_id}">
		                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${faq.faq_id}" aria-expanded="false" aria-controls="collapse${faq.faq_id}">
		                            Q: [${faq.faq_category}] ${faq.question}
		                        </button>
		                    </h2>
		                    <div id="collapse${faq.faq_id}" class="accordion-collapse collapse" aria-labelledby="heading${faq.faq_id}" data-bs-parent="#faqAccordion">
		                        <div class="accordion-body">
		                            <p>A: ${faq.answer}</p>
		                        </div>
		                    </div>
		                </div>
		            </c:forEach>
		        </div>
	        </div>
        </div>
    </div>
	
	<%@include file="/resources/include/footer.jsp" %>