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
	    	System.out.println(session.getAttribute("loginInfo")); //loginInfo�� ���� ������ ���� �����ΰ�?
			if(session.getAttribute("loginInfo")==null) { //login����
				session.setAttribute("destination","redirect:/chat"); //�α��� �������� ������ ���� �۾��� �ߴܽ�Ű�� �ȵǱ� ������ ������ �س��� �Ѵ�.
				return "redirect:/loginForm.mb"; //�α��� ���н�, �α��������� �̵�
			}else {
				return gotoPage; //login����
			}
	    }
}
