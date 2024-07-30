package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberDao;

@Controller
public class SessionLogoutController {
    private final String getPage = "SkipPage";
    @Autowired
    MemberDao memberDao;
    
    @RequestMapping(value="/logoutSession.mb")
    public ModelAndView logoutsession(@RequestParam(value="user_id", required = false) int user_id,
            Model model) {
//    	System.out.println("회원 수정하기 누르면 넘어오는 user_id : " + user_id);
    	ModelAndView mav = new ModelAndView();
    	model.addAttribute("user_id",user_id);
    	mav.setViewName(getPage);
    	return mav;
    }
}
