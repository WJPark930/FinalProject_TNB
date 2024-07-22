<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
seat.jsp<br>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>좌석 예약</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .seat {
            width: 50px;
            height: 50px;
            margin: 5px;
            text-align: center;
            line-height: 50px;
            border: 1px solid #ccc;
            cursor: pointer;
        }
        .seat.selected {
            background-color: #5cb85c;
            color: white;
        }
        .seat.reserved {
            background-color: #d9534f;
            color: white;
            cursor: not-allowed;
        }
        .row-separator {
            height: 20px;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-4">좌석 예약</h2>
    
    <div class="mb-4">
        <a href="trainSchedule.train?dep_station_id=${dep_station_id}&arr_station_id=${arr_station_id}&depPlandTime=${depPlandTime}" class="btn btn-secondary mb-3">이전으로 돌아가기</a>
    </div>

    <!-- 예약 정보 표시 영역 -->
    <div class="mb-4">
        <h3>예약 정보</h3>
        <p><strong>출발역:</strong> ${schedule.depPlaceName}</p>
        <p><strong>도착역:</strong> ${schedule.arrPlaceName}</p>
        <p><strong>날짜:</strong> ${depPlandTime}</p>
        <p><strong>출발 시간:</strong> <fmt:formatDate value="${schedule.depPlandTime}" pattern="HH"/>시<fmt:formatDate value="${schedule.depPlandTime}" pattern="mm"/>분</p>
        <p><strong>도착 시간:</strong> <fmt:formatDate value="${schedule.arrPlandTime}" pattern="HH"/>시<fmt:formatDate value="${schedule.arrPlandTime}" pattern="mm"/>분</p>
        <p><strong>열차 번호:</strong> ${schedule.train_no}</p>
    </div>

    <!-- 좌석 선택 폼 -->
    <form id="seatForm" action="trainReservationConfirm.train" method="post">
	    <div class="form-row mb-3">
	        <div class="col">
	            <label for="adults">어른</label>
	            <input id="adults" name="adults" class="form-control" placeholder="인원 수" min="0" type="number" value="0" />
	        </div>
	        <div class="col">
	            <label for="children">어린이</label>
	            <input id="children" name="children" class="form-control" placeholder="인원 수" min="0" type="number" value="0" />
	        </div>
	        <div class="col">
	            <label for="seniors">경로</label>
	            <input id="seniors" name="seniors" class="form-control" placeholder="인원 수" min="0" type="number" value="0" />
	        </div>
	        <div class="col align-self-end">
	            <button id="selectSeatsBtn" class="btn btn-primary">선택완료</button>
	        </div>
	    </div>
	
	    <!-- 가격 계산 영역 -->
	    <div id="priceInfo" class="mb-4">
	        <h3>가격 정보</h3>
	        <p><strong>어른 1인 가격:</strong> <span id="adultCharge">${schedule.adult_charge}</span> 원</p>
	        <p><strong>어린이 1인 가격:</strong> <span id="childCharge"></span> 원 (어른 가격의 50%)</p>
	        <p><strong>경로 1인 가격:</strong> <span id="seniorsCharge"></span> 원 (어른 가격의 70%)</p>
	        <p><strong>총 가격:</strong> <span id="totalPrice">0</span> 원</p>
	    </div>
	
	    <input type="hidden" name="schedule_id" value="${schedule.schedule_id}">
	    <input type="hidden" name="dep_station_id" value="${dep_station_id}">
	    <input type="hidden" name="arr_station_id" value="${arr_station_id}">
	    <input type="hidden" name="depPlandTime" value="${depPlandTime}">
	    <input type="hidden" id="selectedSeats" name="selectedSeats" value="">
	    
	    <div class="mt-4">
	        <h3>좌석 선택</h3>
	        <div id="seatContainer" class="d-flex flex-wrap">
	            <!-- 좌석 배열을 만들어서 각 좌석을 출력 -->
	            <c:forEach var="row" items="${rowList}">
	                <c:forEach var="col" begin="1" end="10">
	                    <c:set var="seat_no" value="${row}${col}" />
	                    <c:choose>
	                        <c:when test="${reservedSeatNumbers.contains(seat_no)}">
	                            <div class="seat reserved" data-seat="${seat_no}">${seat_no}</div>
	                        </c:when>
	                        <c:otherwise>
	                            <div class="seat" data-seat="${seat_no}">${seat_no}</div>
	                        </c:otherwise>
	                    </c:choose>
	                    <c:if test="${col == 10}">
	                        <div class="w-100"></div>
	                        <c:if test="${row == 'B' || row == 'D'}">
	                            <div class="row-separator"></div>
	                        </c:if>
	                    </c:if>
	                </c:forEach>
	            </c:forEach>
	        </div>
	    </div>
	</form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script>
	$(document).ready(function() {
	    // 어른, 어린이, 경로 가격 초기화
	    const adultCharge = parseInt('${schedule.adult_charge}'.replace(/,/g, ''));
	    const childCharge = Math.ceil(adultCharge * 0.5 / 100) * 100;  // 100원 단위로 올림
	    const seniorsCharge = Math.ceil(adultCharge * 0.7 / 100) * 100;  // 100원 단위로 올림
		
	    $('#adultCharge').text(adultCharge.toLocaleString('ko-KR'));
	    $('#childCharge').text(childCharge.toLocaleString('ko-KR'));
	    $('#seniorsCharge').text(seniorsCharge.toLocaleString('ko-KR'));
	
	    let selectedSeats = [];
	    let selectedAdults = 0;
	    let selectedChildren = 0;
	    let selectedSeniors = 0;
	
	    $('.seat').on('click', function() {
	        if ($(this).hasClass('reserved')) {
	            alert('이미 예약된 좌석입니다.');
	            return;
	        }
	        const totalAdults = parseInt($('#adults').val()) || 0;
	        const totalChildren = parseInt($('#children').val()) || 0;
	        const totalSeniors = parseInt($('#seniors').val()) || 0;
			
	        if ($(this).hasClass('selected')) {
	            $(this).removeClass('selected');
	            selectedSeats = selectedSeats.filter(seat => seat !== $(this).data('seat'));
	
	            // 선택 취소 시 가격 감소
	            updateCountAndPrice(-1);
	        } else {
	            if (selectedSeats.length < (totalAdults + totalChildren + totalSeniors)) {
	                $(this).addClass('selected');
	                selectedSeats.push($(this).data('seat'));
	                selectedSeats.sort();
	
	                // 선택 시 가격 증가
	                updateCountAndPrice(1);
	            } else {
	                alert('선택한 인원 수 만큼만 좌석을 선택할 수 있습니다.');
	            }
	        }
	    });
	
	    $('#selectSeatsBtn').on('click', function(e) {
	        e.preventDefault();
	        const adults = parseInt($('#adults').val()) || 0;
	        const children = parseInt($('#children').val()) || 0;
	        const seniors = parseInt($('#seniors').val()) || 0;
	        const totalSeats = adults + children + seniors;
	
	        if (totalSeats === 0) {
	            alert('인원을 선택하세요.');
	        } else if (selectedSeats.length !== totalSeats) {
	            alert('선택한 인원 수만큼의 좌석을 선택하세요.');
	        } else {
	            $('#selectedSeats').val(selectedSeats.join(','));
	            $('#seatForm').submit(); 
	        }
	    });
	
	    // 인원 수가 변경될 때 가격 업데이트 호출
	    $('input[type="number"]').on('input', function() {
	        const adults = parseInt($('#adults').val()) || 0;
	        const children = parseInt($('#children').val()) || 0;
	        const seniors = parseInt($('#seniors').val()) || 0;
	
	     	// 각 인원 수가 0 미만으로 설정되지 않도록 제한
	        if (adults < 0 || children < 0 || seniors < 0) {
	            $(this).val(0); // 현재 필드를 0으로 재설정
	            return;
	        }
	        
	        // 인원 수가 10명을 초과하지 않도록 제한
	        const total = adults + children + seniors;
	        if (total > 10) {
	            alert('총 인원은 10명을 초과할 수 없습니다.');
	            $(this).val(0); // 현재 필드를 0으로 재설정
	            return;
	        }
	
	        // 인원 수를 변경할 때 가격과 선택된 좌석 수를 업데이트
	        updatePrice();
	    });
	
	    // 인원 수와 선택된 좌석 수에 따라 가격 업데이트
	    function updateCountAndPrice(countChange) {
	        const adults = parseInt($('#adults').val()) || 0;
	        const children = parseInt($('#children').val()) || 0;
	        const seniors = parseInt($('#seniors').val()) || 0;
	
	        // 현재 선택된 좌석 수에 따라 어른, 어린이, 경로 인원 수를 업데이트
	        if (countChange > 0) {
	            if (selectedAdults < adults) {
	                selectedAdults++;
	            } else if (selectedChildren < children) {
	                selectedChildren++;
	            } else if (selectedSeniors < seniors) {
	                selectedSeniors++;
	            }
	        } else if (countChange < 0) {
	            if (selectedSeniors > 0) {
	                selectedSeniors--;
	            } else if (selectedChildren > 0) {
	                selectedChildren--;
	            } else if (selectedAdults > 0) {
	                selectedAdults--;
	            }
	        }
	
	        // 가격 업데이트
	        updatePrice();
	    }
	
	    // 가격 계산 함수
	    function updatePrice() {
	        const totalAdultCharge = selectedAdults * adultCharge;
	        const totalChildCharge = selectedChildren * childCharge;
	        const totalSeniorsCharge = selectedSeniors * seniorsCharge;
	
	        // 총 가격을 100원 단위에서 올림
	        const totalCharge = Math.ceil((totalAdultCharge + totalChildCharge + totalSeniorsCharge) / 100) * 100;
	        $('#totalPrice').text(totalCharge.toLocaleString('ko-KR'));
	    }
	
	    // 초기 가격 계산 호출
	    updatePrice(); // 초기 가격 계산 호출
	});
</script>
</body>
</html>