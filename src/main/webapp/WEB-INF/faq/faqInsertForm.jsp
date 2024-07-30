<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
 
    <style type="text/css">
    	#content_container {
			padding-top: 76px;
			padding-bottom: 50px;
		}
        .err {
            font-size: 9pt;
            color: red;
            font-weight: bold;
        }
        .faq-title {
	        font-size: 2rem;
	        font-family: 'NanumSquare_B';
	    }
    </style>
    
    <script type="text/javascript">
	    function goList() {
	        location.href = "list.faq";
	    }
	</script>
	
	<div class="container" id="content_container">
	    <h2 class="text-center mt-4 mb-4 faq-title">FAQ 신규작성</h2>
	
	    <% String[] faq_category = {"숙소","교통","조회/변경/취소","커뮤니티","채팅","결제","회원","기타"}; %>
	
		<div class="row justify-content-center">
	        <div class="col-12 col-md-8">
			    <form:form commandName="faq" method="post" action="insert.faq">
			        <table class="table table-bordered">
			            <tr>
			                <th>카테고리</th>
			                <td>
			                    <select name="faq_category" class="form-select">
			                        <option value="">카테고리를 선택하세요</option>
			                        <c:set var="faq_category" value="<%=faq_category %>"/>
			                        <c:forEach var="i" begin="0" end="${fn:length(faq_category)-1 }">
			                            <option value="${faq_category[i]}" <c:if test="${faq.faq_category eq faq_category[i] }">selected</c:if>>${faq_category[i]}</option>
			                        </c:forEach>
			                    </select>
			                    <form:errors path="faq_category" cssClass="err"/>
			                </td>
			            </tr>
			            <tr>
			                <th>질문</th>
			                <td>
			                    <input type="text" name="question" value="${faq.question}" size="45" class="form-control">
			                    <form:errors path="question" cssClass="err"/>
			                </td>
			            </tr>
			            <tr>
			                <th>답변</th>
			                <td>
			                    <textarea name="answer" rows="10" cols="45" class="form-control">${faq.answer}</textarea>
			                    <form:errors path="answer" cssClass="err"/>
			                </td>
			            </tr>
			            <tr>
			                <td colspan="2" class="text-center">
			                    <button type="submit" class="btn btn-success">작성</button>
			                    <button type="button" class="btn btn-secondary" onClick="goList()">FAQ 목록</button>
			                </td>
			            </tr>
			        </table>
			    </form:form>
			</div>
		</div>
	</div>

	<%@include file="/resources/include/footer.jsp" %>