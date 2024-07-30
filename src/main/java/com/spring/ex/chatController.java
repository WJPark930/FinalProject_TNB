package com.spring.ex;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class chatController {
	private final String command = "/chat";
	private final String gotoPage = "index";
	
	  @RequestMapping(value = command, method = RequestMethod.GET)
	    public String doAction(HttpSession session) {
	    	System.out.println(session.getAttribute("loginInfo"));
			if(session.getAttribute("loginInfo")==null) {
				session.setAttribute("destination","/chat");
				return "redirect:/loginForm.mb";
			}else {
				return gotoPage;
			}
	    }
}
