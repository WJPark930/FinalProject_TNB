<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

	<style>
		#content_container {
			padding-top: 76px;
			padding-bottom: 50px;
		} 
	    .faq-title {
	        font-size: 2rem;
	        font-family: 'NanumSquare_B';
	    }
	</style>
	
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

	<div class="container" id="content_container">
	    <h2 class="text-center mt-4 mb-4 faq-title">FAQ 상세보기</h2>
	    
	    <div class="row justify-content-center">
	        <div class="col-12 col-md-8">
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
			                <button class="btn btn-secondary" onClick="goList('${param.whatColumn}', '${param.keyword}')">FAQ 목록</button>
			                <button class="btn btn-warning" onClick="goUpdate('${faq.faq_id}', '${param.whatColumn}', '${param.keyword}')">수정하기</button>
			                <button class="btn btn-danger" onClick="goDelete('${faq.faq_id}', '${param.whatColumn}', '${param.keyword}')">삭제하기</button>
			            </td>
			        </tr>
			    </table>
			</div>
		</div>
	</div>


	<%@include file="/resources/include/footer.jsp" %>