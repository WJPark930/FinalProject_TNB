package payment.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import event.model.CouponDao;
import event.model.EventDao;
import member.model.MemberBean;
import member.model.MemberDao;
import payment.model.PaymentBean;
import payment.model.PaymentDao;
import reservation.model.ReservationDao;
import train.model.SeatDao;

@Controller
public class GotoCancelController {
	private final String command = "gotoCancel.pay";
	private final String gotoPage = "redirect:/showAllMyReservation.rv";
	private final String loginPage = "redirect:/loginForm.mb";
	
	@Autowired
	private PaymentDao pdao;
	
	@Autowired
	private MemberDao mdao;
	
	@Autowired
	private ReservationDao rdao;
	
	@Autowired
	private CouponDao cdao;
	
	@Autowired
	private EventDao edao;
	
	@Autowired
	SeatDao seatDao;
	
	@RequestMapping(command) 
	public String gotoCancel(
			@RequestParam(value = "order_num", required = true) int order_num, HttpSession session) {
		
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		if(loginInfo == null) {
			return loginPage;
		} else {
			System.out.println("cancel order_num : " + order_num);
			int user_id = loginInfo.getUser_id();
			
			PaymentBean pb = null;
			MemberBean mb = new MemberBean();
			
			pb = pdao.getThisPayment(order_num);
			
			mb.setUser_point(pb.getPoint_amount());
			mb.setUser_id(user_id);
			

			seatDao.deleteSeat(order_num);

			int cnt1, cnt2, cnt3, cnt4 = -1;
	
			cnt1 = rdao.updateRefund_status(pb);
			if(cnt1 == 1) {
				System.out.println("refund_status update success");
			} 
			
			cnt2 = pdao.cancelThisPayment(pb);
			if(cnt2 == 1) {
				System.out.println("cancelThisPayment success");
			}
			
			cnt3 = mdao.getPoint(mb);
			if(cnt3 == 1) {
				System.out.println("point return success");
			}
			
			cnt4 = edao.updateCouponUse_status_toNo(pb);
			if(cnt4 == 1) {
				System.out.println("coupon return success");
			}
	
			
			return gotoPage;
		}
	}
}
