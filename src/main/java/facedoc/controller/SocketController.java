package facedoc.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;


@Slf4j
@RestController
public class SocketController {
    @MessageMapping("/peer/req/{uuid}")
    @SendTo("/topic/peer/req/{uuid}")
    public String DoctorReqHandleOffer(@Payload String offer,
                                       @DestinationVariable(value = "uuid") String uuid) {
        log.info("[OFFER] {}", uuid);
        return offer;
    }
    @MessageMapping("/peer/res/{uuid}")
    @SendTo("/topic/peer/res/{uuid}")
    public String PatientReqHandleOffer(@Payload String offer,
                                        @DestinationVariable(value = "uuid") String uuid) {
        log.info("[OFFER] {}", uuid);
        return offer;
    }

    //offer 정보를 주고 받기 위한 websocket
    //camKey : 각 요청하는 캠의 key , roomId : 룸 아이디
    @MessageMapping("/peer/offer/{uuid}")
    @SendTo("/topic/peer/offer/{uuid}")
    public String PeerHandleOffer(@Payload String offer,
                                  @DestinationVariable(value = "uuid") String uuid) {
        log.info("[OFFER] {} : {}", uuid, offer);
        return offer;
    }

    //iceCandidate 정보를 주고 받기 위한 webSocket
    //camKey : 각 요청하는 캠의 key , roomId : 룸 아이디
    @MessageMapping("/peer/iceCandidate/{uuid}")
    @SendTo("/topic/peer/iceCandidate/{uuid}")
    public String PeerHandleIceCandidate(@Payload String candidate,
                                         @DestinationVariable(value = "uuid") String uuid) {
        log.info("[ICECANDIDATE] {} : {}", uuid, candidate);
        return candidate;
    }

    @MessageMapping("/peer/answer/{uuid}")
    @SendTo("/topic/peer/answer/{uuid}")
    public String PeerHandleAnswer(@Payload String answer,
                                   @DestinationVariable(value = "uuid") String uuid) {
        log.info("[ANSWER] {} : {}", uuid, answer);
        return answer;
    }

    //camKey 를 받기위해 신호를 보내는 webSocket
    @MessageMapping("/call/key")
    @SendTo("/topic/call/key")
    public String callKey(@Payload String message) {
        log.info("[Key] : {}", message);
        return message;
    }

    //자신의 camKey 를 모든 연결된 세션에 보내는 webSocket
    @MessageMapping("/send/key")
    @SendTo("/topic/send/key")
    public String sendKey(@Payload String message) {
        return message;
    }
}


/*
@Slf4j
@RestController
public class SocketController {
    //offer 정보를 주고 받기 위한 websocket
    //camKey : 각 요청하는 캠의 key , roomId : 룸 아이디
    @MessageMapping("/peer/offer/{uuid}")
    @SendTo("/topic/peer/offer/{uuid}")
    public String PeerHandleOffer(@Payload String offer, @DestinationVariable(value = "roomId") String roomId,
                                  @DestinationVariable(value = "camKey") String camKey) {
        log.info("[OFFER] {} : {}", camKey, offer);
        return offer;
    }

    //iceCandidate 정보를 주고 받기 위한 webSocket
    //camKey : 각 요청하는 캠의 key , roomId : 룸 아이디
    @MessageMapping("/peer/iceCandidate/{uuid}")
    @SendTo("/topic/peer/iceCandidate/{uuid}")
    public String PeerHandleIceCandidate(@Payload String candidate, @DestinationVariable(value = "roomId") String roomId,
                                         @DestinationVariable(value = "camKey") String camKey) {
        log.info("[ICECANDIDATE] {} : {}", camKey, candidate);
        return candidate;
    }

    //

    @MessageMapping("/peer/answer/{uuid}")
    @SendTo("/topic/peer/answer/{uuid}")
    public String PeerHandleAnswer(@Payload String answer, @DestinationVariable(value = "roomId") String roomId,
                                   @DestinationVariable(value = "camKey") String camKey) {
        log.info("[ANSWER] {} : {}", camKey, answer);
        return answer;
    }

    //camKey 를 받기위해 신호를 보내는 webSocket
    @MessageMapping("/call/key")
    @SendTo("/topic/call/key")
    public String callKey(@Payload String message) {
        log.info("[Key] : {}", message);
        return message;
    }

    //자신의 camKey 를 모든 연결된 세션에 보내는 webSocket
    @MessageMapping("/send/key")
    @SendTo("/topic/send/key")
    public String sendKey(@Payload String message) {
        return message;
    }
}
*/