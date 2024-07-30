package reservation.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import reservation.model.RoomReservationBean;
import reservation.model.RoomReservationDao;
import shop.model.GuideBean;
import shop.model.ReviewBean;
import shop.model.ReviewDao;
import shop.model.ServiceBean;
import shop.model.ShopBean;
import shop.model.ShopDao;
import shop.model.ShopRoomBean;

@Controller
public class RoomReservationController {
	private final String command = "roomReservation.rv";
	private final String getPage = "roomReserveForm";
	private final String roomConfirmPage = "roomConfirm";
	private final String loginPage = "redirect:/loginForm.mb";
	
	@Autowired
	private RoomReservationDao rrdao;
	
	@Autowired
	ShopDao shopDao;
	
	@Autowired
	ReviewDao reviewDao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String gotoForm(@RequestParam(value = "shop_id", required = true ) String shop_id, 
			@RequestParam(value = "room_id", required = true ) int room_id,
			@RequestParam(value = "room_checkin_date", required = true ) String room_checkin_date,
			@RequestParam(value = "room_checkout_date", required = true ) String room_checkout_date,
			@RequestParam(value = "room_price", required = true ) int room_total_price,
			@RequestParam(value = "room_quantity", required = true ) int max,
			@RequestParam(value = "people", required = true ) int people,
			Model model, HttpSession session) { 
		
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		if(loginInfo == null) {
			return loginPage;
		} else {
		
			System.out.println("shop_id : " + shop_id);
			System.out.println("room_id : " + room_id);
			System.out.println("room_checkin_date : " + room_checkin_date);
			System.out.println("room_checkout_date : " + room_checkout_date);
			System.out.println("room_total_price : " + room_total_price);
			System.out.println("max : " + max);
			System.out.println("people : " + people);
			
	
			ShopBean shop_info = shopDao.getShopInfo(shop_id);
			//List<String> shop_image = shopDao.getShopImage(shop_id);
			List<ServiceBean> shop_service = shopDao.getShopService(shop_id);
			List<GuideBean> shop_guide = shopDao.getShopGuide(shop_id);
			/* List<ShopRoomBean> shop_room = shopDao.getShopRoom(map); */
			//List<ShopRoomBean> room_image = shopDao.getRoomImage(shop_id);
			List<ReviewBean> shop_review = reviewDao.getShopReview(shop_id);
			List<ReviewBean> review_image = reviewDao.getShopReviewImage(shop_id);
			String shopImage = shopDao.getThisShopImage(shop_id);
			System.out.println("shopImage : " + shopImage);
			
			ShopRoomBean srb = new ShopRoomBean();
			ShopRoomBean srb2 = new ShopRoomBean();
			
			srb.setShop_id(Integer.parseInt(shop_id));
			srb.setRoom_id(room_id);
			srb2 = shopDao.getRoomInfo(srb); 
			
			System.out.println("srb.getRoom_name : " + srb.getRoom_name());
			
			String roomImage = shopDao.getThisRoomImage(srb);
			System.out.println("roomImage : " + roomImage);
			
			
			model.addAttribute("shop_id", shop_id);
			model.addAttribute("room_id", room_id);
			model.addAttribute("room_checkin_date", room_checkin_date);
			model.addAttribute("room_checkout_date", room_checkout_date);
			model.addAttribute("room_total_price", room_total_price);
			model.addAttribute("max", max);
			model.addAttribute("people", people);
			
			model.addAttribute("shop_info",shop_info);
			//model.addAttribute("shop_image",shop_image);
			model.addAttribute("shop_service",shop_service);
			model.addAttribute("shop_guide",shop_guide);
			//model.addAttribute("room_image",room_image);
			model.addAttribute("shop_review",shop_review);
			model.addAttribute("review_image",review_image);
			
			model.addAttribute("shopImage", shopImage);
			model.addAttribute("roomImage", roomImage);
			model.addAttribute("srb", srb2);
			
			
			return getPage;
		}
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String roomReservation(@ModelAttribute("roomreserve") RoomReservationBean rrb, 
			Model model) throws ParseException {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date checkinDate = sdf.parse(rrb.getRoom_checkin_date());
	    Date checkoutDate = sdf.parse(rrb.getRoom_checkout_date());
		
	    long diffInMillies = Math.abs(checkoutDate.getTime() - checkinDate.getTime());
	    long diffInDays = diffInMillies / (24 * 60 * 60 * 1000);
	    
	    int totalPrice = rrb.getRoom_total_price() * (int) diffInDays;
	    
	    rrb.setRoom_total_price(totalPrice);
	    	
		System.out.println("rrb.getRoom_checkout_date() : " + rrb.getRoom_checkout_date());
		int cnt = -1;
		String message = null;
		cnt = rrdao.roomReservation(rrb);
				
		rrb = rrdao.getRecentReservation();
		
		model.addAttribute("rrb", rrb);
		
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
		
		srb.setShop_id(rrb.getShop_id());
		srb.setRoom_id(rrb.getRoom_id());
		srb2 = shopDao.getRoomInfo(srb); 
		
		System.out.println("srb.getRoom_name : " + srb.getRoom_name());
		
		String shopImage = shopDao.getThisShopImage(String.valueOf(rrb.getShop_id()));
		System.out.println("shopImage : " + shopImage);
		
		String roomImage = shopDao.getThisRoomImage(srb);
		System.out.println("roomImage : " + roomImage);
		
		model.addAttribute("shop_info",shop_info);
		model.addAttribute("shop_id", shopId);
		model.addAttribute("room_id", rrb.getRoom_id());
		model.addAttribute("shopImage", shopImage);
		model.addAttribute("roomImage", roomImage);

		model.addAttribute("srb", srb2);
		
		return roomConfirmPage;
	}
	
}
