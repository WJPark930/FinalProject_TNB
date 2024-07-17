package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.MemberDao;

@Controller
public class FindPasswdController {

	@Autowired
	private MemberDao memberDao;
	private final String command = "findPasswd.mb";
	private final String getPage = "findPasswd";
	
	 @RequestMapping(value = command, method = RequestMethod.GET)
	    public String findPasswd() {
	        return getPage;
	    }

	    @RequestMapping(value = command, method = RequestMethod.POST)
	    public String findPasswd(String user_email, String user_phone, Model model) {
	   
	    	String user_passwd=memberDao.findPassword(user_email,user_phone);
	    	if(user_passwd !=null) {
	    		model.addAttribute("user_passwd", user_passwd);
	    	}else {
	    
	        
	        model.addAttribute("message", "일치하는 정보가 없습니다.");
	    }
	        
	        return "findPasswdResult";
	    }
}

