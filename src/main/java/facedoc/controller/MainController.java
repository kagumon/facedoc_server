package facedoc.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String mainController(HttpServletRequest request, Model model) throws Exception {
        return "MAN/MAN0001M01";
    }

    @RequestMapping(value = "/screen/{serviceId}", method = RequestMethod.GET)
    public String screenController(HttpServletRequest request,
                                   Model model,
                                   @PathVariable(name="serviceId") String serviceId) throws Exception {
        return "redirect:/" + serviceId;
    }

}
