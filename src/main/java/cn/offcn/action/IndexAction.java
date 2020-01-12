package cn.offcn.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/main")
public class IndexAction {

    @RequestMapping("/{page}")
    public String forwardPage(@PathVariable("page") String page) {

        return "main/" + page;
    }

}