<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
    <%@include file="/resources/include/header.jsp" %>
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/mypage/review.css?after">

    <div class="container-fruid min-vh-100 " id="content_container">

        <div class="content_mypage container">
        
             <%@include file="/resources/include/my_aside.jsp" %>
             
            <div class="content_area">
            
                <h2>리뷰 내역</h2>
                <form action="review_insert.mp" method="get">
                	<input type="hidden" name="shop_name" value="서울신라호텔">
                    <input type="hidden" name="reservation_id" value="1">
                    <input type="submit" value="임시 추가 버튼"> 
                </form>
                <table border="1">
                    <c:forEach items="${review_list}" var="review">
                        <tr>
                            <td>${review.shop_name}</td>
                            <td>${review.grade}점</td>
                            <td>${review.recommend}명 추천</td>
                            <fmt:parseDate value="${review.review_date}" var="review_date" pattern="yyyy-MM-dd"/>
                            <td><fmt:formatDate value="${review_date}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <a href="review_update.mp?review_id=${review.review_id}" class="btn">수정</a>
                            </td>                           
                            <td>
                                <a href="review_delete.mp?review_id=${review.review_id}" class="btn">삭제</a>
                            </td>                           
                        </tr>
                    </c:forEach>
                </table>
                
            </div>
        </div>

    </div>    
    
    <%@include file="/resources/include/footer.jsp" %>