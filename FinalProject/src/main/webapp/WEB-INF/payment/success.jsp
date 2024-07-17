<%@page import="payment.model.PaymentBean"%>
<%@page import="payment.model.PaymentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../common/common.jsp" %> 
<title>success</title>
</head>
<body>

${ pb.order_num }/${ pb.user_id }/${ pb.payment_num }/${ pb.total_price }

<%
    // 결제 API에서 전송된 데이터를 추출
    String authResultCode = request.getParameter("authResultCode");
    String authResultMsg = request.getParameter("authResultMsg");
    String tid = request.getParameter("tid");
    String clientId = request.getParameter("clientId");
    String orderId = request.getParameter("orderId");
    String amount = request.getParameter("amount");
    String mallReserved = request.getParameter("mallReserved");
    String authToken = request.getParameter("authToken");
    String signature = request.getParameter("signature");
    
    
    System.out.println("authResultCode : " + authResultCode);
    System.out.println("authResultMsg : " + authResultMsg);
    System.out.println("tid : " + tid);
    System.out.println("clientId : " + clientId);
    System.out.println("orderId : " + orderId);
    System.out.println("amount : " + amount);
    System.out.println("mallReserved : " + mallReserved);
    System.out.println("authToken : " + authToken);
    System.out.println("signature : " + signature);
    

    int order_num = Integer.parseInt(orderId);
    int total_price = Integer.parseInt(amount);
    
        
	String approvalUrl = "http://localhost:8080/ex/approval.pay?";
        
	String urlParameters = "authToken=" + URLEncoder.encode(authToken, "UTF-8") +
							"&clientId=" + URLEncoder.encode(clientId, "UTF-8") +
							"&orderId=" + URLEncoder.encode(orderId, "UTF-8") +
							"&amount=" + URLEncoder.encode(amount, "UTF-8") +
							"&signature=" + URLEncoder.encode(signature, "UTF-8");

		// 결제 승인 요청 보내기
	URL url = new URL(approvalUrl);
	HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	connection.setRequestMethod("POST");
	connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
	connection.setDoOutput(true);
		
	try{ 
		DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
		wr.writeBytes(urlParameters);
		wr.flush();
		wr.close();
	} catch(IOException e) {
		System.out.println("IOException 발생");
	}
		// 응답 처리
	int responseCode = connection.getResponseCode();
	BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
	String inputLine;
	StringBuffer response2 = new StringBuffer();
		
	while ((inputLine = in.readLine()) != null) {
		response2.append(inputLine);
	}
	in.close();
		
		// 승인 응답을 파싱하여 처리
	String approvalResponse = response.toString();
		// 응답 처리 로직을 여기에 추가
	
	int cnt = -1;	
		
	if (responseCode == 200) {
		
%>
		<script type="text/javascript">
			alert('결제 성공');			
		</script>
  
<%	
		response.sendRedirect("gotoThisPayment.pay?order_num="+order_num+"&tid="+tid);
	} else {
 %>
		<script type="text/javascript">
			alert('결제 실패');
		</script>
<%	}
		
    
%>

</body>
</html>
