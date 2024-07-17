package member.controller;

import org.springframework.stereotype.Controller;

@Controller

public class NaverLoginController {

 
    public String naverController(){
        return "/login/naverLogin";
    }

}