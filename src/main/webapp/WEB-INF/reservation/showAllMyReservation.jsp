<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/resources/include/header.jsp" %>

<style>
    #content_container {
        padding: 50px 0px;
    }
    .list_area {
        margin-bottom: 40px;
    }
    .reservation-item {
        border: 1px solid #ddd;
        padding: 15px;
        margin-bottom: 15px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .reservation-item:hover {
        background-color: #f9f9f9;
    }
    .reservation-info {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin: 15px 0;
    }
    .reservation-info div {
        flex: 1;
        padding: 0 10px;
    }
    .reservation-info .wide {
        flex: 1.4;
        padding-left: 0px;
    }
    .reservation-info .narrow {
        flex: 0.6;
    }
    .reservation-info div:last-child {
        flex: 0;
    }
    .reservation-info h5 {
        margin: 0 0 5px;
    }
    .reservation-info p {
        margin: 0;
    }
    .vertical-info p {
        margin: 0;
    }
    .total-price {
        font-weight: bold;
        font-size: 18px;
    }
    .icon-trash{
    	font-size: 28px;
    }
</style>

<div class="container" id="content_container">
    <div class="content_mypage">
        <%@include file="/resources/include/my_aside.jsp" %>
        <div class="content_area">
            <div class="list_area">
                <h3 class="mb-3 title-text">예약중인 내역</h3>
                <c:if test="${empty reservationList}">
                    <p class="mt-4">해당 내역이 존재하지 않습니다.</p>
                </c:if>
                <c:forEach var="reservation" items="${reservationList}">
                    <div class="reservation-item" onclick="gotoDetailPayment('${reservation.order_num}')">
                        <div class="reservation-info">
                            <div class="wide">
                                <h5>${reservation.shop_name}</h5>
                                <p>${reservation.room_name}</p>
                            </div>
                            <div>
                                <p>
                                    <fmt:parseDate value="${reservation.room_checkin_date}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedCheckinDate" />
                                    <fmt:formatDate value="${parsedCheckinDate}" pattern="yy년 M월 d일" />
                                </p>
                                <p>
                                    ~
                                </p>
                                <p>
                                    <fmt:parseDate value="${reservation.room_checkout_date}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedCheckoutDate" />
                                    <fmt:formatDate value="${parsedCheckoutDate}" pattern="yy년 M월 d일" />
                                </p>
                            </div>
                            <div class="narrow">
                                <p>예약인원: ${reservation.room_reserve_quantity}</p>
                            </div>
                            <div class="vertical-info">
                                <p>
                                    <c:if test="${reservation.train_no != 0}">
                                        교통예약: 있음
                                    </c:if>
                                    <c:if test="${reservation.train_no == 0}">
                                        교통예약: 없음
                                    </c:if>
                                </p>
                            </div>
                            <div>
                                <p class="total-price">총 금액</p>
                                <p class="total-price"><fmt:formatNumber value="${reservation.total_price}" type="number" groupingUsed="true"/></p>
                            </div>
                            <div>
                                <i class="bi bi-trash icon-trash" onclick="event.stopPropagation(); gotoCancel('${reservation.order_num}')"></i>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="list_area">
                <h3 class="mb-3 title-text">취소된 내역</h3>
                <c:if test="${empty reservationList3}">
                    <p class="mt-4">해당 내역이 존재하지 않습니다.</p>
                </c:if>
                <c:forEach var="reservation3" items="${reservationList3}">
                    <div class="reservation-item">
                        <div class="me-4 reservation-info">
                            <div>
                                <h5>${reservation3.shop_name}</h5>
                                <p>${reservation3.room_name}</p>
                            </div>
                            <div>
                                <p>
                                    <fmt:parseDate value="${reservation3.room_checkin_date}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedCheckinDate3" />
                                    <fmt:formatDate value="${parsedCheckinDate3}" pattern="yy년 M월 d일" />
                                </p>
                                <p>
                                    ~
                                </p>
                                <p>
                                    <fmt:parseDate value="${reservation3.room_checkout_date}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedCheckoutDate3" />
                                    <fmt:formatDate value="${parsedCheckoutDate3}" pattern="yy년 M월 d일" />
                                </p>
                            </div>
                            <div class="narrow">
                                <p>예약인원: ${reservation3.room_reserve_quantity}</p>
                            </div>
                            <div>
                                <p>
                                    <c:if test="${reservation3.train_no != 0}">
                                        교통예약: 있음
                                    </c:if>
                                    <c:if test="${reservation3.train_no == 0}">
                                        교통예약: 없음
                                    </c:if>
                                </p>
                            </div>
                            <div>
                                <p class="total-price">총 금액</p>
                                <p class="total-price"><fmt:formatNumber value="${reservation3.total_price}" type="number" groupingUsed="true"/></p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
    function gotoDetailPayment(order_num) {
        location.href = "gotoDetailPayment.pay?order_num=" + order_num;
    }

    function gotoCancel(order_num) {
        if (confirm("정말로 취소하시겠습니까?")) {
            location.href = "gotoCancel.pay?order_num=" + order_num;
        }
    }
</script>

<%@include file="/resources/include/footer.jsp" %>
