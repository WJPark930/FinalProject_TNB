package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberDao;


@Controller
public class KakaoLoginSuccessController {
	private final String command = "kakaoLoginSuccess.mb";
	private final String gotoPage = "KakaoInsertForm";
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(command)
	public String kakaoLogin(
			@RequestParam(value="code", required = false) String code,
			@RequestParam(value="access_token", required = false) String access_token,
			@RequestParam(value="user_nickname", required = false) String user_nickname,
			@RequestParam(value="user_email", required = false) String user_email,
			Model model) {
		
		
		System.out.println("access_token : " + access_token);
		System.out.println("user_nickname : " + user_nickname);
		System.out.println("user_email : " + user_email);
		
	       // 여기서 이메일 중복 체크
			/*
			 * if (memberDao.checkDuplicateEmail(user_email)) {
			 * model.addAttribute("errorMessage", "이메일이 중복되었습니다."); return "userLoginForm";
			 * // 중복 시 에러 페이지로 이동 }
			 */

        // 중복되지 않은 경우에는 KakaoInsertForm으로 이동
		model.addAttribute("access_token", access_token);
		model.addAttribute("user_name", user_nickname);
		model.addAttribute("user_email", user_email);
		// model.addAttribute("from_kakao", true);
		return gotoPage;
	}
}