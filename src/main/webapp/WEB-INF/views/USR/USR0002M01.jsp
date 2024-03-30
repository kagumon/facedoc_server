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
        let localStream = undefined;
        let localStreamElement = document.querySelector('#localStream');
        let otherKeyList = [];
        const myKey = "<%=uuid%>";

        const connectSocket = async () =>{
            const socket = new SockJS('/signaling');
            stompClient = Stomp.over(socket);
            stompClient.debug = null;

            stompClient.connect({}, function () {
                console.log('Connected to WebRTC server');
                stompClient.subscribe(`/topic/send/key`, message => {
                    const key = JSON.parse(message.body);
                    if(myKey !== key && otherKeyList.find((mapKey) => mapKey === myKey) === undefined && !otherKeyList.includes(key)){
                        otherKeyList.push(key);
                        $("#doctor-list").append("<li class='doctor-li' id='" + key + "'>" + key + "와 연결하기</li>\n");
                    }
                });

                stompClient.subscribe('/topic/peer/res/' + myKey, message => {
                    console.log(message.body=="1");
                });

                stompClient.send("/app/call/key", {}, {});
            });
        }

        $("document").ready(() => {
            connectSocket();
            $(document).on('click', '.doctor-li', (e) => {
                stompClient.send("/app/peer/req/" + e.target.id, {}, myKey);
            });
        });
    </script>

    <style>
        li {
            background-color: aqua;
        }
    </style>
</head>
<body>
<h1>환자 화면</h1>
<h3>나의 session ID : (<%=uuid%>)</h3>
<h3>의사 순서</h3>
<ol id="doctor-list">
</ol>
</body>
</html>