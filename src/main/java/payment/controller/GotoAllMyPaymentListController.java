package payment.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.MemberBean;
import payment.model.PaymentBean;
import payment.model.PaymentDao;

@Controller
public class GotoAllMyPaymentListController {
	private final String command = "gotoAllMyPaymentList.pay";
	private final String gotoPage = "allMyPaymentList";
	private final String gotoLogin = "redirect:/loginForm.mb";
	
	@Autowired
	private PaymentDao pdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String gotoList(Model model, HttpSession session) {
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		
		if(loginInfo == null) {
			return gotoLogin;
		} else {
			int user_id = loginInfo.getUser_id();
			System.out.println("gotoAllMyPaymentList user_id : " + user_id);
			
			List<PaymentBean> allMyPaymentList = new ArrayList<PaymentBean>();
			allMyPaymentList = pdao.getPaymentListByUserId(user_id);
			
			System.out.println("allMyPaymentList.size() : " + allMyPaymentList.size());
			
			model.addAttribute("allMyPaymentList", allMyPaymentList);
			
			return gotoPage;
		}
	}
}
