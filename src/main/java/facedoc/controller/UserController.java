package facedoc.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.UUID;

@Controller
public class UserController {
    @RequestMapping(value = "/USR0001M01", method = RequestMethod.GET)
    public String USR0001M01(HttpServletRequest request, Model model) throws Exception {
        HttpSession session = request.getSession(true);
        String uuid = (String) session.getAttribute("uuid");
        if(uuid == null) {
            uuid = UUID.randomUUID().toString().replaceAll("-", "");
            session.setAttribute("uuid", uuid);
        }
        return "USR/USR0001M01";
    }

    @RequestMapping(value = "/USR0002M01", method = RequestMethod.GET)
    public String USR0002M01(HttpServletRequest request, Model model) throws Exception {
        HttpSession session = request.getSession(true);
        String uuid = (String) session.getAttribute("uuid");
        if(uuid == null) {
            uuid = UUID.randomUUID().toString().replaceAll("-", "");
            session.setAttribute("uuid", uuid);
        }
        return "USR/USR0002M01";
    }
}
