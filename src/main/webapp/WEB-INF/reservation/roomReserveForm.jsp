<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@include file="/resources/include/header.jsp" %>
roomReservationForm.jsp<br>
<script>
   function checkData() {
      const quantity = document.querySelector('input[name="room_reserve_quantity"]').value;
      const max = ${ max };
      
      if(quantity == 0) {
         alert("인원수를 입력하세요");
         return false;
      }
      
      if(quantity > max) {
         alert("최대 인원수를 초과했습니다");
         return false;
      }
      
      return confirm("예약하시겠습니까?");
   
   }
   
   window.addEventListener('load', function() {  
       document.querySelector('form[name="form_my"]').submit();

   })
</script>

<form:form commandName="roomreserve" name="form_my" action="roomReservation.rv" method = "post">
   <input type = "text" name = "user_id" value = ${ sessionScope.loginInfo.user_id }>
   <table border = 1>
      <tr>
         <td>shop_id</td>
         <td>
            <input type = "text" name = "shop_id" value = ${ shop_id }>
            <input type = "text" name = "shop_id2" value = "${shop_info.shop_name}">
         </td>
      </tr>
      <tr>
         <td>room_id</td>
         <td>
            <input type = "text" name = "room_id" value = ${ room_id }>
            <input type = "text" name = "room_id2" value = ${ srb.room_name }>
         </td>
      </tr>
      <tr>
         <td>checkin_date</td>
         <td>
            <fmt:parseDate value="${ room_checkin_date }" var="dayFmt" pattern="yyyy-MM-dd"/>
            <fmt:formatDate var="room_checkin_date" value="${ dayFmt }" pattern="yyyy-MM-dd"/>
            <input type="text" name="room_checkin_date" value="${ room_checkin_date }">
         </td>
      </tr>
      <tr>
         <td>checkout_date</td>
         <td>
            <fmt:parseDate value="${ room_checkout_date }" var="dayFmt" pattern="yyyy-MM-dd"/>
            <fmt:formatDate var="room_checkout_date" value="${ dayFmt }" pattern="yyyy-MM-dd"/>
            <input type="text" name="room_checkout_date" value="${ room_checkout_date }">
         </td>
      </tr>
         <tr>
         <td>quantity</td>
         <td>
            <input type="number" id="quantity" name="room_reserve_quantity" value="${ people }">
         </td>
      </tr>

      <tr>
         <td>price</td>
         <td>
            <input type="text" id="price" name="room_total_price" value="${ room_total_price }">
         </td>
      </tr>      
      <tr>
         <td colspan = 2> 
            <input type = "submit" value = "예약하기" onClick = "return checkData()">
         </td>
      </tr>
   </table>
</form:form>
<%@include file="/resources/include/footer.jsp" %>