package reservation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import reservation.model.ReservationBean;
import reservation.model.ReservationDao;

@Controller
public class AllReservationController {
	private final String command = "showAllMyReservation.rv";
	private final String getPage = "showAllMyReservation";
	
	
	@Autowired
	private ReservationDao rdao;
	
	@Autowired
	ServletContext servletContext; 
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String showAllMyReservationList(@RequestParam(value = "user_id", required = true) int user_id, Model model) {
		
		System.out.println("showAllMyReservation user_id : " + user_id);

		List<ReservationBean> reservationList = rdao.showAllMyReservationList(user_id);
		
		model.addAttribute("reservationList", reservationList);
		
		return getPage;
	}
}
