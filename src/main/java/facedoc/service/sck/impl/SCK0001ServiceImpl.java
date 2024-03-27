package facedoc.service.sck.impl;

import facedoc.service.sck.SCK0001Service;
import facedoc.service.sck.dto.SCK0001S01IN;
import facedoc.service.sck.dto.SCK0001S01OUT;

public class SCK0001ServiceImpl implements SCK0001Service {
    @Override
    public boolean SCK0001S01(SCK0001S01IN in, SCK0001S01OUT out) throws Exception {
        String Data = in.getSocketId();
        out.setSocketId(Data);
        return true;
    }
}
