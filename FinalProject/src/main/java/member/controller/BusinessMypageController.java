package member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BusinessMypageController {
	
	private final String command = "businessMyPage.mb";
	private final String getPage = "";
	private final String gotoPage = "businessMyPage";
	
	
	@RequestMapping(value=command,method= RequestMethod.GET)
	public String gotoMyPage(@RequestParam(value="user_id", required = true) int user_id,
			HttpSession session) {
		System.out.println("BusinessMyPageController user_id : " + user_id);
		if(session.getAttribute("loginInfo")==null) {
			session.setAttribute("destination","redirect:/businessinsert.mb");
			return "redirect:/memberLoginForm.mb";
		}else {
			
		return gotoPage;
	}
	}

}
