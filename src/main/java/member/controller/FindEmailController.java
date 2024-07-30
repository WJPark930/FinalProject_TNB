package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.MemberDao;

@Controller
public class FindEmailController {
	
	
	@Autowired
	private MemberDao memberDao;
	private final String command = "findEmail.mb";
	private final String getPage = "findEmail";
	
	@RequestMapping(value=command, method=RequestMethod.GET)
    public String findEmail() {
        return getPage;
    }

	 @RequestMapping(value = command, method = RequestMethod.POST)
	    public String findEmail(String user_name, String user_phone, Model model) {
	        String user_email = memberDao.findEmail(user_name, user_phone);
	        
	        if (user_email != null) {
	            model.addAttribute("user_email", user_email);
	        } else {
	            model.addAttribute("message", "일치하는 정보가 없습니다.");
	        }
	        
	        return "findEmailResult";
	    }
	}
