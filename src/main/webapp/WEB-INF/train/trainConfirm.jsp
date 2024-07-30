<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

	<style>
		#content_container {
			padding-top: 76px;
			padding-bottom: 50px;
		}
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
	    .content-reservation{
	    	border: 1px solid #ddd;
	    	height: 550px;
	    }
	    .info-divider {
		    border-left: 2px solid #ddd;
		    height: auto;
		    margin: 0 20px;
		}
		.info-section p {
	        font-size: 1.1rem; 
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
	            <span class="inactive">배차조회</span>
	            <span class="icon inactive"> >>></span>
	            <span class="inactive">좌석선택</span>
	            <span class="icon inactive"> >>></span>
	            <span class="active">예매정보</span>
	        </div>    
	    </div>
	    
	    <div class="row justify-content-center">
		    <div class="col-md-9">
		        <div class="p-3 mb-3 content-reservation bg-white rounded shadow-sm">
		            <div class="d-flex justify-content-between">
		                <!-- 예약 정보 표시 영역 -->
		                <div class="w-50 me-4">
		                    <h2 class="text-center mb-4 mt-4">운행 정보</h2>
		                    <div class="ms-4 info-section">
		                        <p><strong>출발역:</strong> ${schedule.depPlaceName}</p>
		                        <p><strong>도착역:</strong> ${schedule.arrPlaceName}</p>
		                        <p><strong>날짜:</strong> ${depPlandTime}</p>
		                        <p><strong>출발 시간:</strong> <fmt:formatDate value="${schedule.depPlandTime}" pattern="HH"/>시<fmt:formatDate value="${schedule.depPlandTime}" pattern="mm"/>분</p>
		                        <p><strong>도착 시간:</strong> <fmt:formatDate value="${schedule.arrPlandTime}" pattern="HH"/>시<fmt:formatDate value="${schedule.arrPlandTime}" pattern="mm"/>분</p>
		                        <p><strong>소요 시간:</strong> ${schedule.duration}</p>
		                        <p><strong>열차 종류:</strong> ${schedule.train_type}</p>
		                        <p><strong>열차 번호:</strong> ${schedule.train_no}</p>
		                    </div>
		                </div>
		
		                <div class="vr"></div>
		
		                <div class="w-50 ms-4">
		                    <h2 class="text-center mb-4 mt-4">인원/좌석 정보</h2>
		                    <div class="ms-4 info-section">
		                        <p><strong>어른:</strong> ${adults}명</p>
		                        <p><strong>어린이:</strong> ${children}명</p>
		                        <p><strong>경로:</strong> ${seniors}명</p>
		                        <p><strong>선택한 좌석:</strong> ${selectedSeats}</p>
		                        <p><strong>총 가격:</strong> <fmt:formatNumber value="${totalPrice}" type="number" pattern="#,##0"/> 원</p>
		                    </div>
		                </div>
		            </div>
		
		            <!-- 예약 확정 폼 -->
		            <form action="trainReservation.rv" method="post">
		                <input type="hidden" name="schedule_id" value="${schedule.schedule_id}" />
		                <input type="hidden" name="dep_station_id" value="${dep_station_id}" />
		                <input type="hidden" name="arr_station_id" value="${arr_station_id}" />
		                <input type="hidden" name="depPlandTime" value="${depPlandTime}" />
		                <input type="hidden" name="adults" value="${adults}" />
		                <input type="hidden" name="children" value="${children}" />
		                <input type="hidden" name="seniors" value="${seniors}" />
		                <input type="hidden" name="selectedSeats" value="${selectedSeats}" />
		                <input type="hidden" name="totalPrice" value="${totalPrice}" />
		                <div class="row mt-4">
		                    <div class="col d-flex justify-content-center">
		                        <button type="submit" class="btn btn-primary w-50">예약 확정</button>
		                    </div>
		                    <div class="col d-flex justify-content-center">
		                        <a href="seat.train?schedule_id=${schedule.schedule_id}&dep_station_id=${dep_station_id}&arr_station_id=${arr_station_id}&depPlandTime=${depPlandTime}&personQty=${personQty}" class="btn btn-secondary w-50">인원/좌석변경</a>
		                    </div>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
		
		<div class="row justify-content-center">
		    <div class="col-md-9">
				<div class="content-message ms-2">
		            <div class="alert-message">
		                · 예약을 원하시는 고객은 운행 정보와 좌석 정보를 확인하시고 예약 확정 버튼을 눌러주시기 바랍니다.
		            </div>
		            <div class="alert-message">
		                · 인원 및 좌석을 변경하시려면 인원/좌석변경 버튼을 눌러주시기 바랍니다.
		            </div>
		            <div class="alert-message">
		                · 승차권 부정 사용 시 운임의 10배 부가운임을 요구할 수 있습니다.
		            </div>
		            <div class="alert-message">
		                · 소요(도착)시간은 도로 사정에 따라 지연될 수 있습니다.
		            </div>
		    	</div>
		    </div>
        </div>
	</div>

	<%@include file="/resources/include/footer.jsp" %>