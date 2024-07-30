package payment.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;
import payment.model.PaymentBean;
import payment.model.PaymentDao;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
import reservation.model.RoomReservationBean;
import reservation.model.RoomReservationDao;
import reservation.model.TrainReservationBean;
import reservation.model.TrainReservationDao;
import shop.model.GuideBean;
import shop.model.ReviewBean;
import shop.model.ReviewDao;
import shop.model.ServiceBean;
import shop.model.ShopBean;
import shop.model.ShopDao;
import shop.model.ShopRoomBean;

@Controller
public class GotoDetailPaymentController {
	
	private final String command = "gotoDetailPayment.pay";
	private final String gotoPage = "detailPayment";
	private final String loginPage = "redirect:/loginForm.mb";
	
	@Autowired
	private PaymentDao pdao;
	
	@Autowired
	private RoomReservationDao rrdao;
	
	@Autowired
	private TrainReservationDao trdao;
	
	@Autowired
	private MemberDao mdao;
	
	@Autowired
	private ShopDao shopDao;
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private ReservationDao rdao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String gotoDetailView(@RequestParam(value = "order_num", required = true) int order_num, Model model, HttpSession session) {
		
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		if(loginInfo == null) {
			return loginPage;
		} else {
			System.out.println("gotoDetailPayment order_num : " + order_num);
			
			PaymentBean pb = null;
			RoomReservationBean rrb = null;
			TrainReservationBean trb = null;
			MemberBean mb = null;
			ReservationBean rb = null;
			
			pb = pdao.getThisPayment(order_num);
			rrb = rrdao.getThisRoomReservation(order_num);
			trb = trdao.isReservationWithTrain(order_num);
			mb = mdao.getMember(pb.getUser_id());
			rb = rdao.showDetailPayment(order_num);
			
			model.addAttribute("pb", pb);
			model.addAttribute("rrb", rrb);
			model.addAttribute("trb", trb);
			model.addAttribute("mb", mb);
			model.addAttribute("rb", rb);
			
			String shopId = String.valueOf(rrb.getShop_id());
			
			ShopBean shop_info = shopDao.getShopInfo(shopId);
			List<String> shop_image = shopDao.getShopImage(shopId);
			List<ServiceBean> shop_service = shopDao.getShopService(shopId);
			List<GuideBean> shop_guide = shopDao.getShopGuide(shopId);
			/* List<ShopRoomBean> shop_room = shopDao.getShopRoom(map); */
			List<ShopRoomBean> room_image = shopDao.getRoomImage(shopId);
			List<ReviewBean> shop_review = reviewDao.getShopReview(shopId);
			List<ReviewBean> review_image = reviewDao.getShopReviewImage(shopId);
			
			ShopRoomBean srb = new ShopRoomBean();
			ShopRoomBean srb2 = new ShopRoomBean();
			srb.setShop_id(Integer.parseInt(shopId));
			srb.setRoom_id(rrb.getRoom_id());
			srb2 = shopDao.getRoomInfo(srb); 
	
			
			model.addAttribute("order_num", pb.getOrder_num());
			model.addAttribute("user_id", pb.getUser_id());
			model.addAttribute("coupon_num", pb.getCoupon_num());
			model.addAttribute("point_amount", pb.getPoint_amount());
			model.addAttribute("total_price", pb.getTotal_price());
			
			
	        ReviewBean review = rdao.getReviewById(order_num);
	        model.addAttribute("review", review);

			model.addAttribute("shop_info",shop_info);
			model.addAttribute("shop_image",shop_image);
			model.addAttribute("shop_service",shop_service);
			model.addAttribute("shop_guide",shop_guide);
			model.addAttribute("room_image",room_image);
			model.addAttribute("shop_review",shop_review);
			model.addAttribute("review_image",review_image);
			
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
