package facedoc.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TestController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String testScreen(HttpServletRequest request, Model model) throws Exception {
        /* 사용할 서비스와 뷰 지정 */
        String service_name = "ZET/";
        String view_name = "ZET0001M01";

        /* 로깅 */
        
        /* jsp에 넘길 데이터 입력 */
        request.setAttribute("data", 5);
        
        /* session에 값 입력 */
        // 작성 필요
        
        return service_name + view_name;
    }
}
