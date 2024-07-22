<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
trainReservationConfirm.jsp<br>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>예약 목록</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-4">예약 목록</h2>

    <!-- 예약 정보 표시 영역 -->
    <div class="mb-4">
        <h3>예약 정보</h3>
        <p><strong>출발역:</strong> ${schedule.depPlaceName}</p>
        <p><strong>도착역:</strong> ${schedule.arrPlaceName}</p>
        <p><strong>날짜:</strong> ${depPlandTime}</p>
        <p><strong>출발 시간:</strong> <fmt:formatDate value="${schedule.depPlandTime}" pattern="HH"/>시<fmt:formatDate value="${schedule.depPlandTime}" pattern="mm"/>분</p>
        <p><strong>도착 시간:</strong> <fmt:formatDate value="${schedule.arrPlandTime}" pattern="HH"/>시<fmt:formatDate value="${schedule.arrPlandTime}" pattern="mm"/>분</p>
        <p><strong>소요 시간:</strong> ${schedule.duration }</p>
        <p><strong>열차 종류:</strong> ${schedule.train_type}</p>
        <p><strong>열차 번호:</strong> ${schedule.train_no}</p>
    </div>

    <div class="mb-4">
        <h3>예약된 좌석</h3>
        <p><strong>어른:</strong> ${adults}명</p>
        <p><strong>어린이:</strong> ${children}명</p>
        <p><strong>경로:</strong> ${seniors}명</p>
        <p><strong>선택한 좌석:</strong> ${selectedSeats}</p>
        <p><strong>총 가격:</strong> ${totalPrice} 원</p>
    </div>
    
    <!-- 예약 확정 폼 -->
    <form action="trainReservationComplete.train" method="post">
        <input type="hidden" name="schedule_id" value="${schedule.schedule_id}" />
        <input type="hidden" name="dep_station_id" value="${dep_station_id}" />
        <input type="hidden" name="arr_station_id" value="${arr_station_id}" />
        <input type="hidden" name="depPlandTime" value="${depPlandTime}" />
        <input type="hidden" name="adults" value="${adults}" />
        <input type="hidden" name="children" value="${children}" />
        <input type="hidden" name="seniors" value="${seniors}" />
        <input type="hidden" name="selectedSeats" value="${selectedSeats}" />
        <input type="hidden" name="totalPrice" value="${totalPrice}" />
        <button type="submit" class="btn btn-primary">예약 확정</button>
    </form>

	<div class="mb-4">
        <a href="seat.train?schedule_id=${schedule.schedule_id}&dep_station_id=${dep_station_id}&arr_station_id=${arr_station_id}&depPlandTime=${depPlandTime}" class="btn btn-secondary mb-3">이전으로 돌아가기</a>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>