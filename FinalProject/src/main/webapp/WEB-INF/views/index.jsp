<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>

<style>
    body {
        padding: 20px;
        background-color: #f8f9fa;
    }

    .chat-container {
        max-width: 600px;
        margin: 0 auto;
        background-color: #ffffff;
        border: 1px solid #dee2e6;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .chat-header {
        padding: 10px 20px;
        border-bottom: 1px solid #dee2e6;
        background-color: #80B156;
        color: #ffffff;
        border-top-left-radius: 5px;
        border-top-right-radius: 5px;
    }

    .chat-messages {
        max-height: 400px;
        overflow-y: auto;
        padding: 10px 20px;
    }

    .message {
        margin-bottom: 10px;
        padding: 10px;
        border-radius: 5px;
        max-width: 80%;
    }

    .message-sent {
        background-color: #80B156;
        color: #ffffff;
        align-self: flex-end;
        margin-left: auto;
        text-align: right;
    }

    .message-received {
        background-color: #f2f2f2;
        color: #000000;
        align-self: flex-start;
        margin-right: auto;
    }

    .message-body {
        word-wrap: break-word;
    }

    .chat-input {
        display: flex;
        margin-top: 10px;
        padding: 0 20px;
        align-items: center;
    }

    .chat-input input[type=text] {
        flex: 1;
        padding: 10px;
        border-top-left-radius: 5px;
        border-bottom-left-radius: 5px;
        border-top-right-radius: 0;
        border-bottom-right-radius: 0;
        border: 1px solid #ced4da;
    }

    .chat-input button {
        padding: 10px 20px;
        border-top-left-radius: 0;
        border-bottom-left-radius: 0;
        border-top-right-radius: 5px;
        border-bottom-right-radius: 5px;
        border: 1px solid #ced4da;
        background-color: #80B156;
        color: #ffffff;
    }
</style>

</head>
<body>
    <div class="container chat-container" style="width: 40%" align="center">
        <div class="chat-header">
            <h2 class="my-2">테스트</h2>
        </div>
        <div class="chat-messages" id="messageArea"></div>
    </div>
    <div class="chat-input" style="width: 40%; margin: auto;" align="center">
        <input type="text" id="message" class="form-control" placeholder="메세지를 입력하세요...">
        <button type="button" id="sendBtn" class="btn">전송</button>
    </div>
   <!-- 파일첨부는 3MB넘어가면 안된다~ 그리고 이 문제를 해결하기 위해 일반적으로 AWS S3 이용함 -->

<script type="text/javascript">
    $("#sendBtn").click(function() {
        sendMessage();
    });

    let sock = new SockJS("http://192.168.0.223:8080/ex/echo/");
    sock.onmessage = onMessage;
    sock.onclose = onClose;

    // 메시지 전송
    function sendMessage() {
        var message = $("#message").val();
        sock.send(message);
        displayMessage(message, true);
        $('#message').val('');
    }

    // 서버로부터 메시지를 받았을 때
    function onMessage(msg) {
        var message = msg.data;
        displayMessage(message, false);
    }

    // 서버와 연결을 끊었을 때
    function onClose(evt) {
        displayMessage("Connection closed", false);
    }

    // Display a message in the chat area
    function displayMessage(message, isSent) {
        var messageClass = isSent ? "message message-sent" : "message message-received";
        var messageElement = $('<div class="' + messageClass + '"><div class="message-body">' + message + '</div></div>');
        $("#messageArea").append(messageElement);
        $("#messageArea").scrollTop($("#messageArea")[0].scrollHeight);
    }
</script>

</body>
</html>

