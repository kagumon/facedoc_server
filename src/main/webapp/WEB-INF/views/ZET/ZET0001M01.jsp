<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String uuid = (String)request.getAttribute("uuid");
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

                stompClient.subscribe(`/topic/call/key`, message =>{
                    stompClient.send(`/app/send/key`, {}, JSON.stringify(myKey));
                });

                stompClient.subscribe(`/topic/send/key`, message => {
                    const key = JSON.parse(message.body);
                    if(otherKeyList.includes(key)) {
                        console.log("already key");
                        return;
                    } else if(myKey !== key && otherKeyList.find((mapKey) => mapKey === myKey) === undefined){
                        otherKeyList.push(key);
                        $("#doctor-list").append("<li>"+key+"</li>");
                    }

                    console.log(otherKeyList);
                });
            });
        }

        const sendKey = async () => {
            await stompClient.send("/app/call/key", {}, {});
        }

        $("document").ready(() => {
            $("#send-key").on("click", sendKey);
            connectSocket();
        });
    </script>
</head>
<body>
    <div id="send-key" style="background-color: olivedrab">로그인하기</div>
    <h1>의사 순서</h1>
    <ol id="doctor-list">
    </ol>
</body>
</html>