<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %>

<style>
    #content_container {
        padding: 50px 0px;
        padding-bottom: 50px;
    }
    .card-text {
        margin-top: 2px;
        margin-bottom: 2px;
        text-align: left; 
    }
    .card-img-container {
        width: 100%;
        height: 200px;
        overflow: hidden;
    }
    .card-img-top {
        width: 100%;
        height: 200px;
        object-fit: cover;
    }
    .title-text {
       font-family: 'NanumSquare_B';
       text-align: left;
       margin: 20px 0 50px 10px; 
   }
</style>

<% String message = request.getParameter("message"); %>
<%
if (message != null) {
    out.println("<script>alert('" + message + "');</script>");
}
%>

<div class="container" id="content_container">
    <div class="content_mypage">
        <%@include file="/resources/include/my_aside.jsp" %>
        <div class="content_area">
            <!-- 발급받은 쿠폰 섹션 -->
            <div class="row mb-3">
                <div class="col-12">
                    <div class="coupon-section">
                        <h3 class="mb-4 title-text" style="padding-bottom: 20px;">보유중인 쿠폰</h3>
                        <c:choose>
                            <c:when test="${empty couponList}">
                                <p>사용 가능한 쿠폰이 없습니다</p>
                            </c:when>
                            <c:otherwise>
                                <div class="row">
                                    <c:forEach var="coupon" items="${couponList}">
                                        <c:set var="endDateStr" value="${coupon.event_end_date}" />
                                        <c:set var="dateParsed" value="${fn:trim(endDateStr)}" />
                                        <c:if test="${not empty dateParsed}">
                                            <%
                                                String dateStr = (String) pageContext.getAttribute("dateParsed");
                                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                                                java.util.Date date = sdf.parse(dateStr);
                                                java.text.SimpleDateFormat newSdf = new java.text.SimpleDateFormat("yy-MM-dd");
                                                String formattedDate = newSdf.format(date);
                                                pageContext.setAttribute("formattedDate", formattedDate);
                                            %>
                                            <div class="col-md-3 col-sm-6 col-12">
                                                <div class="card mb-4">
                                                    <div class="card-img-container">
                                                        <img src="<%= request.getContextPath()+"/resources/uploadEventImage/" %>${coupon.event_image}" class="card-img-top" alt="쿠폰 이미지">
                                                    </div>
                                                    <div class="card-body text-left">
                                                        <p class="card-text">쿠폰 번호 : ${coupon.coupon_num}</p>
                                                        <p class="card-text">${coupon.event_title}</p>
                                                        <p class="card-text">할인 종류 : ${coupon.kind}</p>
                                                        <c:choose>
                                                            <c:when test="${coupon.kind == '비율 할인'}">
                                                                <p class="card-text">할인 비율 : ${coupon.amount}%</p>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <p class="card-text">할인 금액 : <fmt:formatNumber value="${coupon.amount}" type="number" groupingUsed="true"/>원</p>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <p class="card-text">사용 기한 : ${formattedDate}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <!-- 사용한 쿠폰 섹션 -->
            <div class="row mb-5">
                <div class="col-12">
                    <div class="coupon-section">
                        <h3 class="mb-4 title-text" style="padding-bottom: 20px;">사용한 쿠폰</h3>
                        <c:choose>
                            <c:when test="${empty couponList2}">
                                <p>사용한 쿠폰이 없습니다</p>
                            </c:when>
                            <c:otherwise>
                                <div class="row">
                                    <c:forEach var="coupon" items="${couponList2}">
                                        <c:set var="endDateStr2" value="${coupon.event_end_date}" />
                                        <c:set var="dateParsed2" value="${fn:trim(endDateStr2)}" />
                                        <c:if test="${not empty dateParsed2}">
                                            <%
                                                String dateStr2 = (String) pageContext.getAttribute("dateParsed2");
                                                java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                                                java.util.Date date2 = sdf2.parse(dateStr2);
                                                java.text.SimpleDateFormat newSdf2 = new java.text.SimpleDateFormat("yy-MM-dd");
                                                String formattedDate2 = newSdf2.format(date2);
                                                pageContext.setAttribute("formattedDate2", formattedDate2);
                                            %>
                                            <div class="col-md-3 col-sm-6 col-12">
                                                <div class="card mb-2">
                                                    <div class="card-img-container">
                                                        <img src="<%= request.getContextPath()+"/resources/uploadEventImage/" %>${coupon.event_image}" class="card-img-top" alt="쿠폰 이미지">
                                                    </div>
                                                    <div class="card-body text-left">
                                                        <p class="card-text">쿠폰 번호 : ${coupon.coupon_num}</p>
                                                        <p class="card-text">${coupon.event_title}</p>
                                                        <p class="card-text">할인 종류 : ${coupon.kind}</p>
                                                        <c:choose>
                                                            <c:when test="${coupon.kind == '비율 할인'}">
                                                                <p class="card-text">할인 비율 : ${coupon.amount}%</p>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <p class="card-text">할인 금액 : <fmt:formatNumber value="${coupon.amount}" type="number" groupingUsed="true"/>원</p>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/resources/include/footer.jsp" %>
