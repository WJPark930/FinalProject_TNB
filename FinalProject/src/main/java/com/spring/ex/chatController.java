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
	    	System.out.println(session.getAttribute("loginInfo")); //loginInfo로 세션 설정한 값이 무엇인가?
			if(session.getAttribute("loginInfo")==null) { //login실패
				session.setAttribute("destination","redirect:/chat"); //로그인 페이지로 가더라도 원래 작업을 중단시키면 안되기 때문에 저장을 해놔야 한다.
				return "redirect:/loginForm.mb"; //로그인 실패시, 로그인폼으로 이동
			}else {
				return gotoPage; //login성공
			}
	    }
}
