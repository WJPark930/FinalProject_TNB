package event.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import event.model.CouponBean;
import event.model.CouponDao;
import event.model.EventDao;
import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class showMyCouponController {
	private final String command = "showAllMyCoupon.ev";
	private final String gotoPage = "showAllMyCoupon";
	private final String loginPage = "redirect:/loginForm.mb";
	
	@Autowired
	private CouponDao cdao;
	
	@Autowired
	private EventDao edao;
	
	@Autowired
	private MemberDao mdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String showAllMyCoupon(Model model, HttpSession session, @RequestParam(value = "message", required = false ) String message) {
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		
		if(loginInfo == null) {
			return loginPage;
			
		}else {
			int user_id = loginInfo.getUser_id();
			System.out.println("showMyCoupon user_id : " + user_id);
			
			List<CouponBean> CouponAll = cdao.showAllMyCouponWithEventInfo(user_id);
			List<CouponBean> CouponCanUse = cdao.showAllMyCouponWithEventInfo_CanUse(user_id);
			List<CouponBean> CouponUsed = cdao.showAllMyCouponWithEventInfo_Used(user_id);
			
			System.out.println("message : " + message);
			MemberBean mb = mdao.getMemberByUser_id(user_id);
			
			model.addAttribute("couponAll", CouponAll);
			model.addAttribute("couponList", CouponCanUse);
			model.addAttribute("couponList2", CouponUsed);
			model.addAttribute("mb", mb);
			model.addAttribute("message", message);
		
		}
		return gotoPage;
	}
	
}
