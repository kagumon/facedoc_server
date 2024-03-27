package facedoc.controller;

import facedoc.service.sck.dto.SCK0001S01IN;
import facedoc.service.sck.dto.SCK0001S01OUT;
import facedoc.service.sck.impl.SCK0001ServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/test")
public class TestController {
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String dataPrintTest(HttpServletRequest request, Model model) throws Exception {
        SCK0001S01IN in = new SCK0001S01IN();
        SCK0001S01OUT out = new SCK0001S01OUT();
        SCK0001ServiceImpl service = new SCK0001ServiceImpl();

        in.setSocketId("test");

        service.SCK0001S01(in, out);

        request.setAttribute("data", out.getSocketId());
        return "ZET/ZET0001M01";
    }
}
