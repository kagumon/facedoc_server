<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String uuid = (String)session.getAttribute("uuid");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="/static/js/sockjs.min.js"></script>
    <script src="/static/js/jquery-3.7.1.min.js"></script>
    <script src="/static/js/stomp.min.js"></script>
    <script>
        const myKey = "<%=uuid%>";

        const connectSocket = async () =>{
            const socket = new SockJS('/signaling');
            stompClient = Stomp.over(socket);
            stompClient.debug = null;

            stompClient.connect({}, function () {
                console.log('Connected to WebRTC server');

                stompClient.subscribe(`/topic/call/key`, (message) =>{
                    stompClient.send(`/app/send/key`, {}, JSON.stringify(myKey));
                });

                stompClient.subscribe(`/topic/peer/req/` + myKey, (message) =>{
                    const result = confirm(message.body + " 환자와 화상상담 진행하시겠습니까?");
                    stompClient.send('/app/peer/res/' + message.body, {}, result ? 1 : 0);
                });

                stompClient.send('/app/call/key', {}, {});
            });
        }

        $("document").ready(async () => {
            await connectSocket();
        });
    </script>
</head>
<body>
<h1>의사 화면</h1>
<h3>나의 session ID : (<%=uuid%>)</h3>
<h3>환자 대기...</h3>
</body>
</html>