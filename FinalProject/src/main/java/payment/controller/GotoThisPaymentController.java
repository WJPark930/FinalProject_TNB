package payment.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import payment.model.PaymentBean;
import payment.model.PaymentDao;

@Controller
public class GotoThisPaymentController {
	private final String command = "gotoThisPayment.pay";
	private final String gotoPage = "thisPayment";
	
	@Autowired
	private PaymentDao pdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(command)
	public String gotoPage(@RequestParam(value = "order_num", required = true) int order_num, 
			@RequestParam(value = "tid", required = true) String tid, 
			Model model) {
		System.out.println("gotoThisPayment order_num : " + order_num);
		System.out.println("gotoThisPayment tid : " + tid);
		
		PaymentBean pb = null;
		pb = pdao.getThisPayment(order_num);
		
		model.addAttribute("pb", pb);
		return gotoPage;
	}
}
