package event.controller;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import event.model.CouponBean;
import event.model.CouponDao;

@Controller
public class showMyCoupon {
	private final String command = "showAllMyCoupon.ev";
	private final String gotoPage = "showAllMyCoupon";
	
	@Autowired
	private CouponDao cdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String showAllMyCoupon(@RequestParam(value = "user_id", required = true) int user_id, Model model) {
		System.out.println("showMyCoupon user_id : " + user_id);
		
		List<CouponBean> couponList = cdao.showAllMyCoupon(user_id);
		
		model.addAttribute("couponList", couponList);
		
		return gotoPage;
	}
	
}
