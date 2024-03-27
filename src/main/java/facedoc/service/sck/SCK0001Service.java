package facedoc.service.sck;

import facedoc.service.sck.dto.SCK0001S01IN;
import facedoc.service.sck.dto.SCK0001S01OUT;

public interface SCK0001Service {
    /* 소켓 ID로 해당 유저 상태 조회 */
    public boolean SCK0001S01(SCK0001S01IN in, SCK0001S01OUT out) throws Exception;
}
