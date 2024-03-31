<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String doctor_uuid = (String)request.getAttribute("doctor_uuid");
    String patient_uuid = (String)request.getAttribute("patient_uuid");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="/static/js/sockjs.min.js"></script>
    <script src="/static/js/jquery-3.7.1.min.js"></script>
    <script src="/static/js/stomp.min.js"></script>

    <script>
        let d_pc = null;
        let localStreamElement = document.querySelector('#localStream');
        let localStream = undefined;
        const myKey = "<%=patient_uuid%>";
        const otherKey = "<%=doctor_uuid%>";

        const startCam = async () =>{
            if(navigator.mediaDevices !== undefined){
                await navigator.mediaDevices.getUserMedia({ audio: true, video : true })
                    .then(async (stream) => {
                        console.log('Stream found');
                        //웹캠, 마이크의 스트림 정보를 글로벌 변수로 저장한다.
                        localStream = stream;
                        // Disable the microphone by default
                        stream.getAudioTracks()[0].enabled = true;
                        localStreamElement.srcObject = localStream;
                        // Connect after making sure that local stream is availble

                    }).catch(error => {
                        console.error("Error accessing media devices:", error);
                    });
            }
        }

        // 소켓 연결
        const connectSocket = async () =>{
            const socket = new SockJS('/signaling');
            stompClient = Stomp.over(socket);
            stompClient.debug = null;
            stompClient.connect({}, function () {
                console.log('Connected to WebRTC server');

                //iceCandidate peer 교환을 위한 subscribe
                stompClient.subscribe(`/topic/peer/iceCandidate/<%=patient_uuid%>`, candidate => {
                    const key = JSON.parse(candidate.body).key
                    const message = JSON.parse(candidate.body).body;
                    const rtcIcecandidate = new RTCIceCandidate({candidate     : message.candidate,
                                                                 sdpMLineIndex : message.sdpMLineIndex,
                                                                 sdpMid        : message.sdpMid});
                    d_pc.addIceCandidate(rtcIcecandidate);
                });

                //answer peer 교환을 위한 subscribe
                stompClient.subscribe(`/topic/peer/answer/<%=patient_uuid%>`, answer =>{
                    const message = JSON.parse(answer.body).body;
                    d_pc.setRemoteDescription(new RTCSessionDescription(message));
                });
            });
        }
        const createPeerConnection = () =>{
            const pc = new RTCPeerConnection();
            try {
                pc.addEventListener('icecandidate', (event) =>{ onIceCandidate(event); });
                pc.addEventListener('track', (event) =>{ onTrack(event); });

                if(localStream !== undefined){
                    localStream.getTracks().forEach(track => {
                        pc.addTrack(track, localStream);
                    });
                }
                console.log('PeerConnection created');
            } catch (error) {
                console.error('PeerConnection failed: ', error);
            }
            return pc;
        }

        let sendOffer = (pc) => {
            pc.createOffer().then(offer =>{
                setLocalAndSendMessage(pc, offer);
                stompClient.send('/app/peer/offer/'+otherKey, {}, JSON.stringify({
                    key : myKey,
                    body : offer
                }));
                console.log('Send offer');
            });
        };

        const setLocalAndSendMessage = (pc ,sessionDescription) =>{
            pc.setLocalDescription(sessionDescription);
        }

        //onIceCandidate
        let onIceCandidate = (event) => {
            if (event.candidate) {
                console.log('ICE candidate');
                stompClient.send('/app/peer/iceCandidate/'+otherKey,{}, JSON.stringify({
                    key : myKey,
                    body : event.candidate
                }));
            }
        };

        let onTrack = (event) => {
            const video =  document.createElement('video');
            video.autoplay = true;
            video.controls = true;
            video.id = otherKey;
            video.srcObject = event.streams[0];
            document.getElementById('remoteStreamDiv').appendChild(video);
        };

        $("document").ready(async () => {
            await connectSocket();
            $("#connect").click(()=>{
                d_pc=createPeerConnection();
                sendOffer(d_pc);
            });
        });
    </script>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<h1>환자 화상상담 화면</h1>
<h3>의사 ID : (<%=doctor_uuid%>)</h3>
<h3>환자 ID : (<%=patient_uuid%>)</h3>

<div id="connect">연결하기</div>

<hr>

<video id="localStream" autoplay playsinline controls style="display: none;"></video>
<div id="remoteStreamDiv"></div>
</body>
</html>