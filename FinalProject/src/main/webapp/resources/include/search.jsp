
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 캘린더용 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<script src="<%=request.getContextPath()%>/resources/script/search.js?after"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/shop/search.css?after">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<div id="search_form">
    <div>
        <input type="text" name="keyword" class="search_travel dropdown-toggle"  id="dropdown_search" data-bs-toggle="dropdown" aria-expanded="false" autocomplete='off'
        placeholder="여행지나 숙소를 입력해주세요" style="background-image: url('<%=request.getContextPath()%>/resources/assets/icon/home_icon.svg');"
        value="${search.keyword}">
        <ul class="dropdown-menu search_travel_menu " aria-labelledby="dropdown_search">
        </ul>
    </div>
    <div>
        <div>
            <input type="hidden" name="day1" value="${search.day1}">
            <input type="hidden" name="day2" value="${search.day2}">
            <input type="button" class="search_calender"  id="txtDate"  
            style="background-image: url('<%=request.getContextPath()%>/resources/assets/icon/calender_icon.svg'); text-align: left; padding-top: 14px;"
            value="1"
           	>
        </div>
    </div>
    <div>
        <input type="hidden" name="people" value="<c:if test="${search.people==null}">2</c:if><c:if test="${search.people!=null}">${search.people}</c:if>">
        <input type="button" class="search_people"  href="#collapse_people" role="button" data-bs-toggle="collapse" aria-expanded="false" aria-controls="collapse_people"
        style="background-image: url('<%=request.getContextPath()%>/resources/assets/icon/people_icon.png'); text-align: left; padding-top: 14px;"
        value="인원 <c:if test="${search.people==null}">2</c:if><c:if test="${search.people!=null}">${search.people}</c:if> 명">
        <div  class="collapse" id="collapse_people" style="position: absolute;">
            <div class="card card-body row" >
                    <div class="people_text">인원선택</div>
                    <div class="people_btn">
                        <img onclick="minus_people()" src="<%=request.getContextPath()%>/resources/assets/icon/minus_btn.svg"/>
                        <span id="people_count"><c:if test="${search.people==null}">2</c:if><c:if test="${search.people!=null}">${search.people}</c:if></span>
                        <img onclick="plus_people()" src="<%=request.getContextPath()%>/resources/assets/icon/plus_btn.svg"/>
                    </div>
            </div>
        </div>
    </div>
    <div>
        <input type="submit" value="검색" class="search_btn " onclick="return check_search()">
    </div>
</div>