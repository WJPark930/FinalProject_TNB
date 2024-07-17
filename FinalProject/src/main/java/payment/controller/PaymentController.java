package payment.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import event.model.EventDao;
import member.model.MemberDao;
import payment.model.PaymentBean;
import payment.model.PaymentDao;
import reservation.model.ReservationDao;

@Controller
public class PaymentController {
	private final String command = "payment.pay";
	private final String success = "success";
	private final String approval = "approval.pay";
	private final String approvalPage = "approval";
	private final String gotoPage = "payList";
	
	@Autowired
	private PaymentDao pdao;
	
	@Autowired
	private ReservationDao rdao;
	
	@Autowired
	private EventDao edao;
	
	@Autowired
	private MemberDao mdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView whenSuccess(@ModelAttribute("payment") PaymentBean pb,
			Model model) {
		System.out.println("pb.getOrder_num() : " + pb.getOrder_num());
		System.out.println("pb.getUser_id() : " + pb.getUser_id());
		System.out.println("pb.getCoupon_num() : " + pb.getCoupon_num());
		System.out.println("pb.getPoint_amount() : " + pb.getPoint_amount());
		System.out.println("pb.getTotal_price() : " + pb.getTotal_price());
		
		int cnt1, cnt2, cnt3, cnt4 = -1;
		
		cnt1 = rdao.updatePaymentStatus(pb.getOrder_num());
		System.out.println("cnt1 : " + cnt1);
		if(cnt1 == 1) {
			System.out.println("결제 상태 업데이트 성공");
		}
		
		ModelAndView mav = new ModelAndView();
		
		
		cnt2 = pdao.paymentInsert(pb);
		
		System.out.println("cnt2 : " + cnt2);
		
		if(cnt2 == 1) {
			System.out.println("결제 테이블 추가 완료");
			cnt3 = mdao.decreasePoint(pb);
			if(cnt3 == 1) {
				System.out.println("사용 포인트 감소 완료");
				cnt4 = edao.updateCouponUse_status(pb);
				if(cnt4 == 1) {
					System.out.println("사용 쿠폰 상태 변경 완료");
				}
			}
			
		}
		mav.addObject("pb", pb);
		mav.setViewName(success);
		return mav;
	
	}
	

	@RequestMapping(value = approval, method = RequestMethod.POST)
	public String approval() {
		return approvalPage;
	}
	
	
	
	
	
}
