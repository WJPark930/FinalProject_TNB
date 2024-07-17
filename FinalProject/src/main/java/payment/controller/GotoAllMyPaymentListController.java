package payment.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import payment.model.PaymentBean;
import payment.model.PaymentDao;

@Controller
public class GotoAllMyPaymentListController {
	private final String command = "gotoAllMyPaymentList.pay";
	private final String gotoPage = "allMyPaymentList";
	
	@Autowired
	private PaymentDao pdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String gotoList(@RequestParam(value = "user_id", required = true) int user_id, Model model) {
		System.out.println("gotoAllMyPaymentList user_id : " + user_id);
		
		List<PaymentBean> allMyPaymentList = new ArrayList<PaymentBean>();
		allMyPaymentList = pdao.getPaymentListByUserId(user_id);
		
		System.out.println("allMyPaymentList.size() : " + allMyPaymentList.size());
		
		model.addAttribute("allMyPaymentList", allMyPaymentList);
		
		return gotoPage;
	}
}
