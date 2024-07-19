package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class NaverCallBackController {
	   @Autowired
	    private MemberDao memberDao;
	   
	private final String command = "NaverCallBack.mb";
	private final String gotoCallback = "navercallback";
	private final String gotoPage = "naverLogin.mb";
	
	@RequestMapping(command)
	public String gotoCallback(Model model) {
		return gotoCallback;
	}
	
	
	   
	/*
	 * @RequestMapping(gotoPage) public String naverLogin(
	 * 
	 * @RequestParam("user_email") String user_email,
	 * 
	 * @RequestParam("user_name") String user_name, HttpServletRequest request,
	 * HttpSession session) {
	 * 
	 * 
	 * System.out.println("user_email : " + user_email); MemberBean existingMember =
	 * memberDao.findByEmail(user_email);
	 * 
	 * if (existingMember != null) { session.setAttribute("loginInfo",
	 * existingMember); return "redirect:/memberMypage.mb"; } else {
	 * request.setAttribute("user_email", user_email);
	 * request.setAttribute("user_name", user_name); return
	 * "member/naverInsertForm"; } }
	 */

			}
