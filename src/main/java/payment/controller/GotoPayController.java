package payment.controller;

import java.sql.SQLIntegrityConstraintViolationException;
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
import payment.model.PaymentDao;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
import reservation.model.RoomReservationBean;
import reservation.model.RoomReservationDao;
import reservation.model.TrainReservationBean;
import reservation.model.TrainReservationDao;
import shop.model.ShopBean;
import shop.model.ShopDao;
import shop.model.ShopRoomBean;

@Controller
public class GotoPayController {
	private final String command = "gotoPay.pay";
	private final String gotoPage = "thisReservation";
	private final String loginPage = "redirect:/loginForm.mb";
	
	@Autowired
	private PaymentDao pdao;
	
	@Autowired
	private ReservationDao rdao;
	
	@Autowired
	private EventDao edao;
	
	@Autowired
	private MemberDao mdao;
	
	@Autowired
	private CouponDao cdao;
	
	@Autowired
	private ShopDao shopDao;
	
	@Autowired
	private RoomReservationDao rrdao;
	
	@Autowired
	private TrainReservationDao trdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value=command, method = RequestMethod.GET) 
	public String gotoPay(
			@RequestParam(value = "room_reservation_num", required = true) int order_num,
			Model model, HttpSession session) {
		
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		
		if(loginInfo == null) {
			return loginPage;
		} else {
			int user_id = loginInfo.getUser_id();
			System.out.println("gotoPayController user_id : " + user_id);
			System.out.println("gotoPayController order_num : " + order_num);
			
			ReservationBean rbCheck = rdao.getThisReservation(order_num);
			RoomReservationBean rrb = rrdao.getThisRoomReservation(order_num);
			TrainReservationBean trb = trdao.isReservationWithTrain(order_num);
			
			int cnt1, cnt2 = -1;
			
			if(rbCheck == null) {
				cnt1 = rdao.roomreservation(rrb);
				if(cnt1 > 0) {
					System.out.println("room to reservation table success");
					if(trb != null) {
						cnt2 = rdao.trainreservation(trb);
						if(cnt2 > 0) {
							System.out.println("train to reservation table success");
						}
					} else {
						System.out.println("no train reservation");
					}
				
				}
			}
			
			MemberBean mb = mdao.getMemberByUser_id(user_id);
			
			
			ReservationBean rb = rdao.getThisReservation(order_num);
			
			ShopBean shop_info = shopDao.getShopInfo(String.valueOf(rb.getShop_id()));
			List<CouponBean> couponList = cdao.showCanUseCoupon(rb.getUser_id());
	
			ShopRoomBean srb = new ShopRoomBean();
			ShopRoomBean srb2 = new ShopRoomBean();
					
			srb.setShop_id(rb.getShop_id());
			srb.setRoom_id(rb.getRoom_id());
			srb2 = shopDao.getRoomInfo(srb); 
			
			model.addAttribute("mb", mb);
			model.addAttribute("rb", rb);
			model.addAttribute("couponList", couponList);
			model.addAttribute("shop_info", shop_info);
			model.addAttribute("srb", srb2);
			
			String shopImage = shopDao.getThisShopImage(String.valueOf(rrb.getShop_id()));
			System.out.println("shopImage : " + shopImage);
			
			String roomImage = shopDao.getThisRoomImage(srb);
			System.out.println("roomImage : " + roomImage);
			
			model.addAttribute("shopImage", shopImage);
			model.addAttribute("roomImage", roomImage);
		
			return gotoPage;
		}
		
	}
	
	

}
