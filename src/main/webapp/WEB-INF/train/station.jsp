<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp"%>

<style>
    .container-fluid {
        padding: 0;
    }

    #content_container {
        padding-top: 76px;
        padding-bottom: 50px;
        z-index: 50;
    }

    #main_banner_area {
        width: 100%;
        padding-top: 76px;
        position: absolute;
        z-index: 10;
    }

    #main_banner_area img {
        width: 100%;
        height: 500px;
        object-fit: cover;
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

    .content-wrapper {
        height: 300px;
        display: flex;
    }

    .content-search {
        width: 100%;
        height: 200px;
        margin-top: 30px;
        background-color: white;
        border-radius: .5rem;
        padding: 2rem;
        box-shadow: 0 0 .5rem rgba(0, 0, 0, .1);
    }

    .breadcrumb {
        display: flex;
        align-items: center;
        gap: 10px;
        justify-content: center;
        margin: 20px 0;
    }

    .breadcrumb span {
        font-size: 28px;
    }

    .breadcrumb .icon {
        color: white;
    }

    .breadcrumb .active {
        color: white;
    }

    .breadcrumb .inactive {
        color: gray;
    }

    .header-container {
        height: 200px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .header-title {
        color: white;
        text-align: center;
        font-size: 3rem;
        font-family: 'NanumSquare_B';
        margin: 20px 0;
    }

    .content-wrapper {
        margin-bottom: 0;
    }

    .content-message {
        margin-top: 50px;
    }

    .alert-message {
        color: #6c757d;
        margin-bottom: 10px;
        font-size: 1rem;
    }
    
    .form-control.rounded {
        border-radius: 1rem; 
    }

    .input-group-text {
        border-radius: 0;
    }
</style>

<div class="container-fluid">
    <div id="main_banner_area">
        <img src="<%=request.getContextPath()%>/resources/assets/image/기차메인.svg" alt="메인 배너">
    </div>
</div>

<div class="container" id="content_container">

    <div class="header-container">
        <h1 class="header-title">KTX/SRT 기차예매</h1>
        <div class="breadcrumb">
            <span class="active">노선조회</span>
            <span class="icon"> >>></span>
            <span class="inactive">배차조회</span>
            <span class="icon inactive"> >>></span>
            <span class="inactive">좌석선택</span>
            <span class="icon inactive"> >>></span>
            <span class="inactive">예매정보</span>
        </div>
    </div>

    <div class="content-wrapper">
        <div class="content-search">
            <h2 class="text-center mb-4">노선조회</h2>
            <form action="trainSchedule.train" method="get" class="mb-4" onsubmit="return validateForm();">
            	<input type="hidden" name="personQty" value="${personQty}">
                <div class="row justify-content-center align-items-center flex-nowrap" style="margin-top: 40px;">
                    <div class="col-md-6">
                    	<label for="departureStation" style="margin-left: 5px;">출발역</label>
                    	<label for="arrivalStation" style="margin-left: 255px;">도착역</label>
                    </div>
                    <div class="col-md-3">
                    	<label for="date" style="margin-left: 5px;">날짜</label>
                    </div>
                    <div class="col-md-2">
                    </div>
				</div>	
	
                <div class="row justify-content-center align-items-center flex-nowrap" style="margin-top: 0px;">
                
                    <!-- 출발역 및 도착역과 스왑 아이콘 -->
                    <div class="col-md-6 mb-3">
                        <div class="input-group">
                            <input type="text" id="departureStation" class="form-control rounded" placeholder="출발역을 선택하세요" readonly onclick="openPopup('departurePopup')" value="${depStationName}">
							<input type="hidden" id="dep_station_id" name="dep_station_id" value="${dep_station_id}">
                            <span class="input-group-text bg-white border-0">
                                <img src="<c:url value='/resources/assets/image/교환.png' />" alt="swap" onclick="swapStations()" style="cursor:pointer; width:30px; height:30px;">
                            </span>
                            <input type="text" id="arrivalStation" class="form-control rounded" placeholder="도착역을 선택하세요" readonly onclick="openPopup('arrivalPopup')" value="${arrStationName}">
							<input type="hidden" id="arr_station_id" name="arr_station_id" value="${arr_station_id}">
                        </div>
                    </div>

                    <!-- 날짜 선택 -->
                    <div class="col-md-3 mb-3">
                        <input type="date" id="depPlandTime" name="depPlandTime" class="form-control rounded" value="${depPlandTime}" min="${now}" max="${maxDate}" onclick="this.showPicker();" />
                    </div>

                    <!-- 조회 버튼 -->
                    <div class="col-md-2 mb-3 d-flex justify-content-center align-items-center">
                        <button type="submit" class="btn btn-primary btn-custom">조회</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="content-message ms-2">
        <div class="alert-message">
            · 출발역과 도착역과 날짜를 선택하고, 조회버튼을 누르면 원하는 운행일정을 확인 가능합니다.
        </div>
        <div class="alert-message">
            · 당일출발 차량의 경우 출발시간 30분 전까지 홈페이지 예매가 가능합니다.
        </div>
        <div class="alert-message">
            · 1회 최대 예매 매수는 10매입니다.
        </div>
        <div class="alert-message">
            · 승차권 부정 사용 시 운임의 10배 부가운임을 요구할 수 있습니다.
        </div>
        <div class="alert-message">
            · 소요(도착)시간은 도로 사정에 따라 지연될 수 있습니다.
        </div>
    </div>
</div>

<!-- 출발역 선택 팝업 -->
<div class="modal fade" id="departurePopup" tabindex="-1" aria-labelledby="departurePopupLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="departurePopupLabel">출발역 선택</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="departureCity" class="form-label">출발 지역 선택</label>
                    <select id="departureCity" class="form-select" onchange="filterStationsByCity('departureCity', 'departureStationContainer')">
                        <option value="all">전체</option>
                        <c:forEach var="city" items="${cityList}">
                            <option value="${city.cityId}">${city.cityName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div id="departureStationContainer" class="form-group">
                    <c:forEach var="station" items="${stationList}">
                        <button type="button" class="btn btn-outline-primary station-button" data-city-id="${station.cityId}" onclick="selectStation('${station.stationId}', '${station.stationName}', 'dep_station_id', 'departureStation', 'departurePopup')">
                            ${station.stationName}
                        </button>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 도착역 선택 팝업 -->
<div class="modal fade" id="arrivalPopup" tabindex="-1" aria-labelledby="arrivalPopupLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="arrivalPopupLabel">도착역 선택</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="arrivalCity" class="form-label">도착 지역 선택</label>
                    <select id="arrivalCity" class="form-select" onchange="filterStationsByCity('arrivalCity', 'arrivalStationContainer')">
                        <option value="all">전체</option>
                        <c:forEach var="city" items="${cityList}">
                            <option value="${city.cityId}">${city.cityName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div id="arrivalStationContainer" class="form-group">
                    <c:forEach var="station" items="${stationList}">
                        <button type="button" class="btn btn-outline-primary station-button" data-city-id="${station.cityId}" onclick="selectStation('${station.stationId}', '${station.stationName}', 'arr_station_id', 'arrivalStation', 'arrivalPopup')">
                            ${station.stationName}
                        </button>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

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
        document.getElementById(displayId).value = stationName;
        var popup = bootstrap.Modal.getInstance(document.getElementById(popupId));
        popup.hide();
    }

    function swapStations() {
        var departureStation = document.getElementById("dep_station_id");
        var arrivalStation = document.getElementById("arr_station_id");
        var departureStationName = document.getElementById("departureStation");
        var arrivalStationName = document.getElementById("arrivalStation");

        var tempValue = departureStation.value;
        var tempName = departureStationName.value;
        departureStation.value = arrivalStation.value;
        departureStationName.value = arrivalStationName.value;
        arrivalStation.value = tempValue;
        arrivalStationName.value = tempName;
    }

    function openPopup(popupId) {
        var popup = new bootstrap.Modal(document.getElementById(popupId));
        popup.show();
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
</script>

<%@include file="/resources/include/footer.jsp"%>