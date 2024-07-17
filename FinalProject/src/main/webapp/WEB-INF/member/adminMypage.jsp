<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>

adminMyPage.jsp<br>

<h2>마이페이지</h2>

<table border="1" align="center">
    <tr>
        <th>모든 회원 리스트</th>
        <th>숙소관리</th>
        <th>F A Q</th>
        <th>커뮤니티</th>
        <th>이벤트</th>
    </tr>
    <tr>
        <td><a href="memberList.mb?user_id=${sessionScope.loginInfo.user_id}">멤버리스트확인</a></td>
        <td><a href="shopList.sh?user_id=${sessionScope.loginInfo.user_id}">숙소관리</a></td>
        <td><a href="FAQList.mb?user_id=${sessionScope.loginInfo.user_id}">F A Q</a></td>
        <td><a href="community.mb?user_id=${sessionScope.loginInfo.user_id}">커뮤니티</a></td>
        <td><a href="eventList.mb?user_id=${sessionScope.loginInfo.user_id}">이벤트</a></td>
    </tr>
</table>
