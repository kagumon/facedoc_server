package facedoc.service.sck.dto;

import lombok.Data;
import org.springframework.stereotype.Component;

@Component
@Data
public class SCK0001S01OUT {
    private String socketId;
    private String status;
    private String userName;
}
