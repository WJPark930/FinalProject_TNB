package member.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class NaverLoginSuccessController {
	private final String command = "naverLoginSuccess.mb";
	private final String gotoPage = "naverInsertForm";
	private final String gotoMypage ="../../main";
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(command)
	public ModelAndView naverLogin(
			@RequestParam("user_email") String user_email,
			@RequestParam("user_name") String user_name,
			Model model,HttpSession session, HttpServletResponse response) {
		
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("naverLoginSuccess user_email : " + user_email);
		System.out.println("naverLoginSuccess user_name : " + user_name);
		

		
		MemberBean mb = memberDao.findByEmail(user_email);
		
		if(mb.getUser_email() != null) {
			System.out.println("이미 가입된 회원");
			session.setAttribute("loginInfo",mb);
			mav.setViewName(gotoMypage);
		}else {
			System.out.println("새로 정보 입력받아야함");
			mav.addObject("user_name",user_name);
			mav.addObject("user_email",user_email);
			mav.setViewName(gotoPage);	
		}
	return mav;
	}
}
