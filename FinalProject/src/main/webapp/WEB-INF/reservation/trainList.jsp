<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
trainList.jsp<br>

<c:if test="${ not empty message }">
    <script type="text/javascript">
        if (!confirm("${ message }")) {
            window.location.href = "showReservation.rv";
        } else {
        	window.location.href = "stationList.train";
        }
    </script>
</c:if>
