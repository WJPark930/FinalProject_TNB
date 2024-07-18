package event.controller;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import event.model.CouponBean;
import event.model.CouponDao;
import event.model.EventBean;

@Controller
public class EventCouponController {
	private final String command = "eventCoupon.ev";
	private final String gotoPage = "eventList";
	
	@Autowired
	private CouponDao cdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(command)
	public String getCoupon(@ModelAttribute("coupon") CouponBean coupon, Model model) {
		System.out.println("coupon.getEvent_num() : " + coupon.getEvent_num());
		System.out.println("coupon.getUser_id : " + coupon.getUser_id());
		System.out.println("coupon.getKind() : " + coupon.getKind());
		System.out.println("coupon" + coupon.getAmount());
		
		boolean flag = false;
		flag = cdao.didIGetCoupon(coupon);
		
		System.out.println("flag : " + flag);
		
		if(flag) {
			System.out.println("이미 발급 받은 쿠폰");
		} else {
			int cnt = -1;
			cnt = cdao.getThisCoupon(coupon);
			if(cnt > 0) {
				System.out.println("쿠폰 발급 성공");
			}
		}

		return gotoPage;
	}




}
