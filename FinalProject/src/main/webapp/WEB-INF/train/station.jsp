<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
station.jsp<br>

<!DOCTYPE html>
<html>
<head>
    <title>기차역 선택</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .popup {
            display: none;
            position: fixed;
            z-index: 1050;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
            padding-top: 1rem;
        }
        .popup-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 1rem;
            border-radius: .3rem;
            max-width: 90%;
            box-shadow: 0 0 .5rem rgba(0,0,0,.5);
        }
        .station-button {
            margin: 5px;
        }
        .btn-custom {
            min-width: 150px;
        }
        .station-name {
            font-weight: bold;
        }
        .swap-icon img {
            cursor: pointer;
            width: 30px;
            height: 30px;
        }
    </style>
    <script>
        function filterStationsByCity(selectElementId, stationContainerId) {
            var selectedCity = document.getElementById(selectElementId).value;
            var stationContainer = document.getElementById(stationContainerId);
            var stationButtons = stationContainer.getElementsByTagName("button");

            for (var i = 0; i < stationButtons.length; i++) {
                var stationCityId = stationButtons[i].getAttribute("data-city-id");
                if (selectedCity === "all" || selectedCity === stationCityId) {
                    stationButtons[i].style.display = "inline-block";
                } else {
                    stationButtons[i].style.display = "none";
                }
            }
        }

        function selectStation(stationId, stationName, inputId, displayId, popupId) {
            document.getElementById(inputId).value = stationId;
            document.getElementById(displayId).innerHTML = stationName;
            closePopup(popupId);
        }

        function swapStations() {
            var departureStation = document.getElementById("dep_station_id");
            var arrivalStation = document.getElementById("arr_station_id");
            var departureStationName = document.getElementById("departureStationName");
            var arrivalStationName = document.getElementById("arrivalStationName");

            var tempValue = departureStation.value;
            var tempName = departureStationName.innerHTML;
            departureStation.value = arrivalStation.value;
            departureStationName.innerHTML = arrivalStationName.innerHTML;
            arrivalStation.value = tempValue;
            arrivalStationName.innerHTML = tempName;
        }

        function openPopup(popupId) {
            var popup = document.getElementById(popupId);
            popup.style.display = "block";
        }

        function closePopup(popupId) {
            var popup = document.getElementById(popupId);
            popup.style.display = "none";
        }
        function validateForm() {
            var depStationId = document.getElementById("dep_station_id").value;
            var arrStationId = document.getElementById("arr_station_id").value;
            var depPlandTime = document.getElementById("depPlandTime").value;

            if (!depStationId) {
                alert("출발역을 선택해주세요.");
                return false;
            }
            if (!arrStationId) {
                alert("도착역을 선택해주세요.");
                return false;
            }
            if (!depPlandTime) {
                alert("날짜를 선택해주세요.");
                return false;
            }

            return true;
        }
        window.onload = function() {
            filterStationsByCity("departureCity", "departureStationContainer");
            filterStationsByCity("arrivalCity", "arrivalStationContainer");
        };
    </script>
</head>
<body>

<div class="container mt-5">
    <h2 class="mb-4">노선조회</h2>
    <form action="trainSchedule.train" method="get" class="mb-4" onsubmit="return validateForm();">
        <div class="form-row align-items-center">
            <!-- 출발역 선택 버튼 -->
            <div class="col-md-4 mb-3">
                <label for="departureStationBtn">출발역 선택</label>
                <button type="button" id="departureStationBtn" class="btn btn-primary btn-custom" onclick="openPopup('departurePopup')">출발역 선택</button>
                <input type="hidden" id="dep_station_id" name="dep_station_id" value="${dep_station_id}">
                <div id="departureStationName" class="station-name">${depStationName}</div>
            </div>

            <!-- 스왑 아이콘 -->
            <div class="col-md-1 mb-3 swap-icon">
                <img src="<c:url value='/resources/image/swap.png' />" alt="swap" onclick="swapStations()">
            </div>

            <!-- 도착역 선택 버튼 -->
            <div class="col-md-4 mb-3">
                <label for="arrivalStationBtn">도착역 선택</label>
                <button type="button" id="arrivalStationBtn" class="btn btn-primary btn-custom" onclick="openPopup('arrivalPopup')">도착역 선택</button>
                <input type="hidden" id="arr_station_id" name="arr_station_id" value="${arr_station_id}">
                <div id="arrivalStationName" class="station-name">${arrStationName}</div>
            </div>

            <!-- 날짜 선택 -->
            <div class="col-md-2 mb-3">
                <label for="date">날짜 선택</label>
                <input type="date" id="depPlandTime" name="depPlandTime" class="form-control"
                       value="${depPlandTime}" min="${now}" max="${maxDate}" />
            </div>

            <!-- 조회 버튼 -->
            <div class="col-md-1 mb-3">
                <button type="submit" class="btn btn-success btn-custom">조회</button>
            </div>
        </div>
    </form>
</div>

<!-- 출발역 선택 팝업 -->
<div id="departurePopup" class="popup">
    <div class="popup-content">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <button type="button" class="close" onclick="closePopup('departurePopup')">&times;</button>
                    <h3 class="mb-4">출발역 선택</h3>
                    <div class="form-group">
                        <label for="departureCity">출발 지역 선택</label>
                        <select id="departureCity" class="form-control" onchange="filterStationsByCity('departureCity', 'departureStationContainer')">
                            <option value="all">전체</option>
                            <c:forEach var="city" items="${cityList}">
                                <option value="${city.cityId}">${city.cityName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div id="departureStationContainer" class="form-group">
                        <c:forEach var="station" items="${stationList}">
                            <button type="button" class="btn btn-outline-primary station-button" data-city-id="${station.cityId}"
                                    onclick="selectStation('${station.stationId}', '${station.stationName}', 'dep_station_id', 'departureStationName', 'departurePopup')">
                                ${station.stationName}
                            </button>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 도착역 선택 팝업 -->
<div id="arrivalPopup" class="popup">
    <div class="popup-content">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <button type="button" class="close" onclick="closePopup('arrivalPopup')">&times;</button>
                    <h3 class="mb-4">도착역 선택</h3>
                    <div class="form-group">
                        <label for="arrivalCity">도착 지역 선택</label>
                        <select id="arrivalCity" class="form-control" onchange="filterStationsByCity('arrivalCity', 'arrivalStationContainer')">
                            <option value="all">전체</option>
                            <c:forEach var="city" items="${cityList}">
                                <option value="${city.cityId}">${city.cityName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div id="arrivalStationContainer" class="form-group">
                        <c:forEach var="station" items="${stationList}">
                            <button type="button" class="btn btn-outline-primary station-button" data-city-id="${station.cityId}"
                                    onclick="selectStation('${station.stationId}', '${station.stationName}', 'arr_station_id', 'arrivalStationName', 'arrivalPopup')">
                                ${station.stationName}
                            </button>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>