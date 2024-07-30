<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<%
    String depPlandTimeStr = (String) request.getAttribute("depPlandTime");
    java.util.Date depPlandTimeDate = null;
    if (depPlandTimeStr != null) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        try {
            depPlandTimeDate = sdf.parse(depPlandTimeStr);
        } catch (java.text.ParseException e) {
            e.printStackTrace();
        }
    }
%>
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
        .scrollable-table {
	        max-height: calc(100% - 60px);
	        overflow-y: auto;
	        border: 1px solid #ddd;
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
	    .fixed-header {
	        position: sticky;
	        top: 0;
	        z-index: 1;
	        background-color: white;
	    }
	    
	    .content-schedule {
        	border: 1px solid #ddd;
       		height: 700px;
    	}
    	
    	.content-search {
			height: 700px;    	
    	} 
    	.content-message {
	        margin-top: 50px;
	    }
	
	    .alert-message {
	        color: #6c757d;
	        margin-bottom: 10px;
	        font-size: 1rem;
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
                <span class="inactive">노선조회</span>
                <span class="icon inactive"> >>></span>
                <span class="active">배차조회</span>
                <span class="icon"> >>></span>
                <span class="inactive">좌석선택</span>
                <span class="icon inactive"> >>></span>
                <span class="inactive">예매정보</span>
            </div>    
        </div>
    
        <div class="row" style="margin-top: 30px;">
            <div class="col-md-3">
                <div class="p-3 mb-3 text-white content-search" style="background-color: #007bff; border-radius: 0.5rem;">
                    <h5 class="text-left mb-4 mt-3 ms-2"><fmt:formatDate value="<%= depPlandTimeDate %>" pattern="yy.MM.dd (E)" /></h5>
                    <div class="ms-2 mb-4 d-flex align-items-center">
                        <img src="<c:url value='/resources/assets/image/출발아이콘.png' />" style="width:50px; height:50px;">
                        <span style="font-size: 1.8rem; margin-left: 10px;">${depPlaceName}</span>
                    </div>
                    <div class="ms-2 d-flex align-items-center">
                        <img src="<c:url value='/resources/assets/image/도착아이콘.png' />" style="width:50px; height:50px;">
                        <span style="font-size: 1.8rem; margin-left: 10px;">${arrPlaceName}</span>
                    </div>
                    <div class="d-flex justify-content-end" style="border-bottom: 1px solid white; padding-bottom: 5px;">
                        <a href="station.train?dep_station_id=${dep_station_id}&arr_station_id=${arr_station_id}&depPlandTime=${depPlandTime}&personQty=${personQty}" class="d-flex align-items-center mt-3 text-decoration-none" style="color: white;">
                            <img src="<c:url value='/resources/assets/image/수정아이콘.png' />" style="width:20px; height:20px; margin-right: 5px;">
                            <span>수정</span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <div class="p-3 mb-3 justify-content-center content-schedule" style="background-color: #FFFFFF; border-radius: 0.5rem;">
                    <h2 class="text-center mb-3">열차 운행 일정</h2>
                    <div class="scrollable-table">
                        <form id="scheduleForm" method="post" action="seat.train">
                            <table border="1" class="table table-striped table-bordered">
                                <thead class="text-center thead-dark fixed-header">
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
                                    <c:choose>
                                        <c:when test="${empty trainSchedules}">
                                            <tr>
                                                <td colspan="7" class="text-center">해당 운행일정은 없습니다</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
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
                                                    <td class="text-start"><div class="ms-1">${schedule.train_type}</div></td>
													<td class="text-end"><div class="me-1">${schedule.train_no}</div></td>
                                                    <td class="text-center"><fmt:formatDate value="${schedule.depPlandTime}" pattern="HH"/>:<fmt:formatDate value="${schedule.depPlandTime}" pattern="mm"/></td>
                                                    <td class="text-center"><fmt:formatDate value="${schedule.arrPlandTime}" pattern="HH"/>:<fmt:formatDate value="${schedule.arrPlandTime}" pattern="mm"/></td>
                                                    <td class="text-end"><fmt:formatNumber value="${schedule.adult_charge}" type="number" pattern="#,###"/>원</td>
                                                    <td class="text-center">${schedule.seat_available}</td>
                                                    <td class="text-center">${schedule.duration}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                            <input type="hidden" id="schedule_id" name="schedule_id">
                            <input type="hidden" name="dep_station_id" value="${dep_station_id}">
                            <input type="hidden" name="arr_station_id" value="${arr_station_id}">
                            <input type="hidden" name="depPlandTime" value="${depPlandTime}">
                            <input type="hidden" name="personQty" value="${personQty}">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="content-message ms-2">
            <div class="alert-message">
                · 예매를 원하시는 고객은 일정을 더블클릭하여 주시기 바랍니다.
            </div>
            <div class="alert-message">
                · 당일출발 차량의 경우 출발시간 30분 전까지 홈페이지 예매가 가능합니다.
            </div>
            <div class="alert-message">
                · 다른 열차일정을 조회하시려면 수정버튼을 눌러주시기 바랍니다.
            </div>
            <div class="alert-message">
                · 승차권 부정 사용 시 운임의 10배 부가운임을 요구할 수 있습니다.
            </div>
            <div class="alert-message">
                · 소요(도착)시간은 도로 사정에 따라 지연될 수 있습니다.
            </div>
        </div>
    </div>
    
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
    
    <%@include file="/resources/include/footer.jsp" %>
