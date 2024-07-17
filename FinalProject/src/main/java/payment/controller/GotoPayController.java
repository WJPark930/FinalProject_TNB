package payment.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import payment.model.PaymentBean;
import payment.model.PaymentDao;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;

@Controller
public class GotoPayController {
	private final String command = "payment.pay";
	private final String getPage = "payment";
	
	@Autowired
	private ReservationDao rdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value=command, method = RequestMethod.GET) 
	public String gotoPay(
			@ModelAttribute("payment") PaymentBean pb, Model model) {
		
		System.out.println("order_num : " + pb.getOrder_num());
		System.out.println("user_id : " + pb.getUser_id());
		System.out.println("coupon_num : " + pb.getCoupon_num());
		System.out.println("point_amount : " + pb.getPoint_amount());
		System.out.println("total_price : " + pb.getTotal_price());
		
		ReservationBean rb = rdao.getThisReservation(pb.getOrder_num());
		
		model.addAttribute("order_num", pb.getOrder_num());
		model.addAttribute("user_id", pb.getUser_id());
		model.addAttribute("coupon_num", pb.getCoupon_num());
		model.addAttribute("point_amount", pb.getPoint_amount());
		model.addAttribute("total_price", pb.getTotal_price());
		
		return getPage;
	}
	
	

}
