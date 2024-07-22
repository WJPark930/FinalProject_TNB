<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
trainSchedule.jsp<br>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>열차 운행 일정 목록</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome (아이콘) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .scrollable-table {
            max-height: 600px; /* 스크롤 높이 조절 */
            overflow-y: auto;
        }
        .selectable-row:hover {
            background-color: #f0f0f0;
            cursor: pointer;
        }
        .disabled-row {
            background-color: #e0e0e0 !important;
            color: #a0a0a0;
            pointer-events: none;
        }
    </style>
    <script>
        function submitForm(schedule_id, depPlandTime) {
            const currentDate = new Date();
            const depTime = new Date(depPlandTime);

            // 현재 시간에 30분을 더한 시간
            currentDate.setMinutes(currentDate.getMinutes() + 30);

            // 현재 날짜와 출발 날짜가 같은 경우에만 30분 조건 적용
            if (depTime.toDateString() === currentDate.toDateString() && depTime <= currentDate) {
                alert('출발시간 30분 전까지 예약 가능합니다.');
                return;
            }

            document.getElementById('schedule_id').value = schedule_id;
            document.getElementById('scheduleForm').submit();
        }
    </script>
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3">
                <h4>검색 조건</h4>
                <ul class="list-group">
                    <li class="list-group-item"><strong>출발역:</strong> ${depPlaceName}</li>
                    <li class="list-group-item"><strong>도착역:</strong> ${arrPlaceName}</li>
                    <li class="list-group-item"><strong>출발일:</strong> ${depPlandTime}</li>
                </ul>
                <input type="button" value="이전으로 돌아가기" onClick="location.href='station.train?dep_station_id=${dep_station_id}&arr_station_id=${arr_station_id}&depPlandTime=${depPlandTime}'">
            </div>
            <div class="col-md-9">
                <h2 class="mb-4">열차 운행 일정 목록</h2>
                <div class="scrollable-table">
                    <form id="scheduleForm" method="post" action="seat.train">
                        <table border="1" class="table table-striped table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th>열차종류</th>
                                    <th>열차번호</th>
                                    <th>출발시간</th>
                                    <th>도착시간</th>
                                    <th>운임요금</th>
                                    <th>잔여좌석</th>
                                    <th>소요시간</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="schedule" items="${trainSchedules}">
                                    <c:set var="currentDate" value="<%= new java.util.Date().getTime() %>" />
                                    <c:set var="scheduleDepTime" value="${schedule.depPlandTime.time}" />
                                    <c:choose>
                                        <c:when test="${currentDate >= scheduleDepTime - 30 * 60 * 1000 && fn:substring(schedule.depPlandTime, 0, 10) == fn:substring(depPlandTime, 0, 10)}">
                                            <tr class="selectable-row disabled-row">
                                        </c:when>
                                        <c:otherwise>
                                            <tr class="selectable-row" ondblclick="submitForm('${schedule.schedule_id}', '${schedule.depPlandTime}')">
                                        </c:otherwise>
                                    </c:choose>
                                        <td>${schedule.train_type}</td>
                                        <td>${schedule.train_no}</td>
                                        <td><fmt:formatDate value="${schedule.depPlandTime}" pattern="HH"/>:<fmt:formatDate value="${schedule.depPlandTime}" pattern="mm"/></td>
                                        <td><fmt:formatDate value="${schedule.arrPlandTime}" pattern="HH"/>:<fmt:formatDate value="${schedule.arrPlandTime}" pattern="mm"/></td>
                                        <td><fmt:formatNumber value="${schedule.adult_charge}" type="number" pattern="#,###"/>원</td>
                                        <td>${schedule.seat_available}</td>
                                        <td>${schedule.duration}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <input type="hidden" id="schedule_id" name="schedule_id">
                        <input type="hidden" name="dep_station_id" value="${dep_station_id}">
                        <input type="hidden" name="arr_station_id" value="${arr_station_id}">
                        <input type="hidden" name="depPlandTime" value="${depPlandTime}">
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>