package reservation.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import reservation.model.RoomReservationBean;
import reservation.model.RoomReservationDao;

@Controller
public class RoomReservationController {
	private final String command = "roomReserve.rv";
	private final String getPage = "roomReserveForm";
	private final String trainReservationPage = "trainList";
	private final String showAllReservation = "";
	private final String loginPage = "";
	
	@Autowired
	private RoomReservationDao rrdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String gotoForm(@RequestParam(value = "shop_id", required = true ) int shop_id, 
			@RequestParam(value = "room_id", required = true ) int room_id,
			@RequestParam(value = "room_checkin_date", required = true ) String room_checkin_date,
			@RequestParam(value = "room_checkout_date", required = true ) String room_checkout_date,
			@RequestParam(value = "price", required = true ) int price,
			Model model) { 
		System.out.println("shop_id : " + shop_id);
		System.out.println("room_id : " + room_id);
		System.out.println("room_checkin_date : " + room_checkin_date);
		System.out.println("room_checkout_date : " + room_checkout_date);
		System.out.println("price : " + price);
		
		model.addAttribute("shop_id", shop_id);
		model.addAttribute("room_id", room_id);
		model.addAttribute("room_checkin_date", room_checkin_date);
		model.addAttribute("room_checkout_date", room_checkout_date);
		model.addAttribute("price", price);
		
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String roomReservation(@ModelAttribute("roomreserve") RoomReservationBean rrb, 
			Model model) {
		
		System.out.println("rrb.getRoom_checkout_date() : " + rrb.getRoom_checkout_date());
		int cnt = -1;
		String message = null;
		cnt = rrdao.roomReservation(rrb);
				
		if(cnt == 1) {
			message = "철도를 함께 예약하시겠습니까?";
		}
		
		model.addAttribute("message", message);
		return trainReservationPage;
	}
	
}
