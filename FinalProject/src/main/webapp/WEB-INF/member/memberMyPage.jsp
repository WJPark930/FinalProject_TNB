<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>

memberMyPage.jsp<br>

<h2>마이페이지</h2>

<table border="1" align="center">
    <tr>
        <th>회원정보변경</th>
        <th>예약확인</th>
        <th>리뷰쓰기</th>
        <th>커뮤니티</th>
        <th>보유쿠폰</th>
    </tr>
    <tr>
        <td><a href="MYupdate.mb?user_id=${sessionScope.loginInfo.user_id}">회원정보변경</a></td>
        <td><a href="reservationCheck.mb?user_id=${sessionScope.loginInfo.user_id}">예약확인</a></td>
        <td><a href="review.mb?user_id=${sessionScope.loginInfo.user_id}">리뷰쓰기</a></td>
        <td><a href="community.mb?user_id=${sessionScope.loginInfo.user_id}">커뮤니티</a></td>
        <td><a href="mycopon.mb?user_id=${sessionScope.loginInfo.user_id}">보유쿠폰</a></td>
    </tr>
</table>
