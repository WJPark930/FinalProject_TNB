<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

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
	    .content-person {
        	border: 1px solid #ddd;
       		height: 190px;
    	}
	    .content-seat {
        	border: 1px solid #ddd;
       		height: 492px;
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
	            <span class="inactive">배차조회</span>
	            <span class="icon inactive"> >>></span>
	            <span class="active">좌석선택</span>
	            <span class="icon"> >>></span>
	            <span class="inactive">예매정보</span>
	        </div>    
	    </div>
	
	    <div class="row" style="margin-top: 30px;">
	    	<div class="col-md-3">
			    <div class="p-3 mb-3 text-white content-search" style="background-color: #007bff; border-radius: 0.5rem;">
			        <h5 class="text-left mb-4 mt-3 ms-2"><fmt:formatDate value="${schedule.depPlandTime}" pattern="yy.MM.dd (E)" /></h5>
			            <div class="ms-2 mb-4 d-flex align-items-center">
						    <img src="<c:url value='/resources/assets/image/출발아이콘.png' />" style="width:50px; height:50px;">
						    <span style="font-size: 1.8rem; margin-left: 10px;">${schedule.depPlaceName}</span>
						</div>
						<div class="ms-2 d-flex align-items-center">
						    <img src="<c:url value='/resources/assets/image/도착아이콘.png' />" style="width:50px; height:50px;">
						    <span style="font-size: 1.8rem; margin-left: 10px;">${schedule.arrPlaceName}</span>
						</div>
						<div class="d-flex justify-content-end mb-4" style="border-bottom: 1px solid white; padding-bottom: 5px;">
						    <a href="station.train?dep_station_id=${dep_station_id}&arr_station_id=${arr_station_id}&depPlandTime=${depPlandTime}&personQty=${personQty}" class="d-flex align-items-center mt-3 text-decoration-none" style="color: white;">
						        <img src="<c:url value='/resources/assets/image/수정아이콘.png' />" style="width:20px; height:20px; margin-right: 5px;">
						        <span>수정</span>
						    </a>
						</div>
						
						<div class="ms-2">
					        <p><strong>열차 종류 </strong> ${schedule.train_type}</p>
					        <p><strong>열차 번호 </strong> ${schedule.train_no}</p>
							<p><strong>출발 시간 </strong> <fmt:formatDate value="${schedule.depPlandTime}" pattern="HH"/>시<fmt:formatDate value="${schedule.depPlandTime}" pattern="mm"/>분</p>
					        <p><strong>도착 시간 </strong> <fmt:formatDate value="${schedule.arrPlandTime}" pattern="HH"/>시<fmt:formatDate value="${schedule.arrPlandTime}" pattern="mm"/>분</p>
					        <p class="mb-0"><strong>소요 시간 </strong> ${schedule.duration}</p>
						</div>
						<div class="d-flex justify-content-end mb-4" style="border-bottom: 1px solid white; padding-bottom: 5px;">
						    <a href="trainSchedule.train?dep_station_id=${dep_station_id}&arr_station_id=${arr_station_id}&depPlandTime=${depPlandTime}&personQty=${personQty}" class="d-flex align-items-center mt-3 text-decoration-none" style="color: white;">
						        <img src="<c:url value='/resources/assets/image/수정아이콘.png' />" style="width:20px; height:20px; margin-right: 5px;">
						        <span>수정</span>
						    </a>
						</div>
				        
					    <div id="priceInfo" class="ms-2">
					        <p><strong>어른 1인 </strong> <span id="adultCharge">${schedule.adult_charge}</span> 원</p>
					        <p><strong>어린이 1인 </strong> <span id="childCharge"></span> 원(50% 할인)</p>
					        <p><strong>경로 1인 </strong> <span id="seniorsCharge"></span> 원(30% 할인)</p>
					        <p class="fs-5"><strong>총 금액 &nbsp</strong> <span id="totalPrice">0</span> 원</p>
					    </div>
			    </div>
			</div>
	
			<div class="col-md-9">
			    <form id="seatForm" action="trainConfirm.train" method="post">
			        <!-- 인원 선택 부분 -->
			        <div class="p-3 mb-3 justify-content-center content-person" style="background-color: #FFFFFF; border-radius: 0.5rem;">
			            <h2 class="text-center mb-3 mt-3">인원 선택</h2>
			            <div class="form-row mb-3 d-flex align-items-center justify-content-center">
			                <div class="col-3 me-4">
			                    <label for="adults">어른</label>
			                    <input id="adults" name="adults" class="form-control" placeholder="인원 수" min="0" type="number" value="0" />
			                </div>
			                <div class="col-3 me-4">
			                    <label for="children">어린이</label>
			                    <input id="children" name="children" class="form-control" placeholder="인원 수" min="0" type="number" value="0" />
			                </div>
			                <div class="col-3">
			                    <label for="seniors">경로</label>
			                    <input id="seniors" name="seniors" class="form-control" placeholder="인원 수" min="0" type="number" value="0" />
			                </div>
			            </div>
			            <input type="hidden" name="schedule_id" value="${schedule.schedule_id}">
			            <input type="hidden" name="dep_station_id" value="${dep_station_id}">
			            <input type="hidden" name="arr_station_id" value="${arr_station_id}">
			            <input type="hidden" name="depPlandTime" value="${depPlandTime}">
			            <input type="hidden" id="selectedSeats" name="selectedSeats" value="">
			            <input type="hidden" name="personQty" value="${personQty}">
			        </div>
			        
			        <!-- 좌석 선택 부분 -->
			        <div class="p-3 mb-3 justify-content-center content-seat" style="background-color: #FFFFFF; border-radius: 0.5rem;">
			            <h2 class="text-center mb-4 mt-4">좌석 선택</h2>
			            <div class="mt-4">
			                <div id="seatContainer" class="d-flex flex-wrap justify-content-center">
			                    <!-- 좌석 배열을 만들어서 각 좌석을 출력 -->
			                    <c:forEach var="row" items="${rowList}">
			                        <c:forEach var="i" begin="1" end="10">
									    <c:set var="col" value="${11 - i}" />
									    <c:set var="seat_no" value="${row}${col}" />
									    <c:choose>
									        <c:when test="${reservedSeatNumbers.contains(seat_no)}">
									            <div class="seat reserved" data-seat="${seat_no}">${seat_no}</div>
									        </c:when>
									        <c:otherwise>
									            <div class="seat" data-seat="${seat_no}">${seat_no}</div>
									        </c:otherwise>
									    </c:choose>
									    <c:if test="${col == 1}">
									        <div class="w-100"></div>
									        <c:if test="${row == 'B' || row == 'D'}">
									            <div class="row-separator"></div>
									        </c:if>
									    </c:if>
									</c:forEach>
			                    </c:forEach>
			                </div>
			            </div>
			            <div class="d-flex justify-content-center mt-4">
			                <div class="col-3">
			                    <button id="selectSeatsBtn" class="btn btn-primary w-100">선택완료</button>
			                </div>
			            </div>
			        </div>
			    </form>
			</div>
		</div>
		
		<div class="content-message ms-2">
	        <div class="alert-message">
	            · 어른/어린이/경로 총 인원의 1회 최대 예매 가능 매수는 10매입니다.
	        </div>
	        <div class="alert-message">
	            · 어린이는 만 6세~12세 기준입니다.
	        </div>
	        <div class="alert-message">
	            · 경로는 만 65세 이상 기준입니다.
	        </div>
	        <div class="alert-message">
	            · 만 6세 이하는 보호자석과 동반하거나, 어린이로 예매가능합니다.
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
		$(document).ready(function() {
			// personQty 값을 JavaScript로 전달
	        const personQty = ${personQty != null ? personQty : 10};
	        
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
		        
		     	// 인원 수 제한
		        const total = adults + children + seniors;
		        if (total > personQty) {
		            alert('총 인원은 ' + personQty + '명을 초과할 수 없습니다.');
		            $(this).val(0); // 현재 필드를 0으로 재설정
		            return;
		        }
		
		     	// 인원 수를 변경할 때 선택된 좌석 수를 체크
		        if (selectedSeats.length > total) {
		            alert('선택된 좌석 수가 인원 수보다 많습니다. 좌석 선택을 해제하고 인원을 낮춰주세요.');
		            $(this).val($(this).data('previousValue')); // 이전 값을 복원
		        } else {
		            $(this).data('previousValue', $(this).val()); // 현재 값을 저장
		            // 가격 업데이트 호출
		            updatePrice();
		        }
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

	<%@include file="/resources/include/footer.jsp" %>