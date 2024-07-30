package reservation.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import event.model.CouponBean;
import event.model.CouponDao;
import member.model.MemberBean;
import member.model.MemberDao;
import payment.model.PaymentDao;
import reservation.model.ReservationDao;
import reservation.model.RoomReservationBean;
import reservation.model.RoomReservationDao;
import reservation.model.TrainReservationBean;
import reservation.model.TrainReservationDao;

@Controller
public class ThisReservationController {
	private final String command = "showReservation.rv";
	private final String getPage = "showThisReservation";
	
	@Autowired
	private RoomReservationDao rrdao;
	
	@Autowired
	private TrainReservationDao trdao;
	
	@Autowired
	private ReservationDao rdao;
	
	@Autowired
	private CouponDao cdao;
	
	@Autowired
	private MemberDao mdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(command)
	public String reservationList(HttpServletRequest request, Model model) {
		
		Map<String, String> map = new HashMap<String , String>();
		String url = request.getContextPath() + this.command;
		int cnt = -1;
		int cnt2 = -1;
		RoomReservationBean rrb = rrdao.getRecentReservation();
		System.out.println("max num rrb : " + rrb.getRoom_reservation_num());
		
		TrainReservationBean trb = trdao.isReservationWithTrain(rrb.getRoom_reservation_num());
		if(trb == null) {
			System.out.println("no train reservation");
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			try {
				Date room_checkin_date = formatter.parse(rrb.getRoom_checkin_date());
				Date room_checkout_date = formatter.parse(rrb.getRoom_checkout_date());
			
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			cnt = rdao.roomreservation(rrb);
			System.out.println("rdao.roomreservation: " + cnt);
			model.addAttribute("rrb", rrb);
			
		} else {
			System.out.println("not insert yet");
			cnt = rdao.roomreservation(rrb);
			
			if(cnt == 1) {
				System.out.println("room insert success");
				cnt2 = rdao.trainreservation(trb);
				if(cnt2 == 1) {
					System.out.println("train insert success");
				} else if (cnt2 == 0) {
					System.out.println("not found data");
				} else if (cnt2 == -1) {
					System.out.println("train insert fail");
				}
			}
			
			model.addAttribute("rrb", rrb);
			model.addAttribute("trb", trb);
		}
		
		
		List<CouponBean> couponList = cdao.showCanUseCoupon(rrb.getUser_id());
		System.out.println("ThisReservationController couponList.size() : " + couponList.size());
		model.addAttribute("couponList", couponList);
		
		MemberBean mb = mdao.getMemberByUser_id(rrb.getUser_id());
		model.addAttribute("mb", mb);
		
		return getPage;
	}
}
