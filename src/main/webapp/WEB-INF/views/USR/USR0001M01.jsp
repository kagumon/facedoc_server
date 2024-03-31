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
        let p_key = null;
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
                    $("#request").show();
                    $("#ok").show();
                    $("#no").show();
                    p_key=message.body;
                });

                stompClient.send('/app/call/key', {}, {});
            });
        }

        $("document").ready(async () => {
            await connectSocket();
            init();
            $("#ok").click(()=>{ stompClient.send('/app/peer/res/' + p_key, {}, 1); location.href = "/USR0001M02/"+p_key});
            $("#no").click(()=>{ stompClient.send('/app/peer/res/' + p_key, {}, 0); init()});
        });

        function init() {
            p_key = null;
            $("#request").hide();
            $("#ok").hide();
            $("#no").hide();
        }
    </script>
</head>
<body>
<h1>의사 화면</h1>
<h3>나의 session ID : (<%=uuid%>)</h3>
<h3>환자 대기...</h3>
<div id="request">요청이 들어왔습니다.</div>
<div id="ok">상담 승인</div>
<div id="no">상담 거절</div>
</body>
</html>