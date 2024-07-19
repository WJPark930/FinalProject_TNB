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
public class KakaoLoginSuccessController {
	private final String command = "kakaoLoginSuccess.mb";
	private final String gotoPage = "KakaoInsertForm";
	private final String gotoMyPage = "../../main";
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(command)
	public ModelAndView kakaoLogin(
			@RequestParam(value="code", required = false) String code,
			@RequestParam(value="access_token", required = false) String access_token,
			@RequestParam(value="user_nickname", required = false) String user_nickname,
			@RequestParam(value="user_email", required = false) String user_email,
			Model model, HttpSession session, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("access_token : " + access_token);
		System.out.println("user_nickname : " + user_nickname);
		System.out.println("user_email : " + user_email);
		
	       // 여기서 이메일 중복 체크
			/*
			 * if (memberDao.checkDuplicateEmail(user_email)) {
			 * model.addAttribute("errorMessage", "이메일이 중복되었습니다."); return "userLoginForm";
			 * // 중복 시 에러 페이지로 이동 }
			 */
		MemberBean mb = memberDao.findByEmail(user_email);
		if(mb == null) {
			System.out.println("새로 정보 입력받아야 함");
			mav.addObject("access_token", access_token);
			mav.addObject("user_name", user_nickname);
			mav.addObject("user_email", user_email);
			mav.setViewName(gotoPage);
		} else {
			System.out.println("이미 가입된 회원");
			session.setAttribute("loginInfo", mb);
			mav.setViewName(gotoMyPage);
		}
		
		
		return mav;
	}
	

}