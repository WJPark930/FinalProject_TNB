package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

	@Controller
	public class KakaoLoginController {
		
		   @Autowired
		    private MemberDao memberDao;
		   
		private final String command = "kakaoLogin.mb";
		
		
		@RequestMapping(command)
		 public String kakaoLogin(@RequestParam("access_token") String accessToken,
                 @RequestParam("user_email") String userEmail,
                 @RequestParam("user_nickname") String userNickname,
                 HttpServletRequest request,
                 HttpSession session) {

			System.out.println("user_email : " + userEmail);
MemberBean existingMember = memberDao.findByEmail(userEmail);

if (existingMember != null) {
session.setAttribute("loginInfo", existingMember);
return "redirect:/memberMypage.mb";
} else {
request.setAttribute("user_email", userEmail);
request.setAttribute("user_nickname", userNickname);
return "member/kakaoInsertForm";
}
}

}
