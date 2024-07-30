package reservation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;

@Controller
public class AllReservationController {
	private final String command = "showAllMyReservation.rv";
	private final String getPage = "showAllMyReservation";
	private final String loginPage = "redirect:/loginForm.mb";
	
	
	@Autowired
	private ReservationDao rdao;
	
	@Autowired
	ServletContext servletContext; 
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String showAllMyReservationList(Model model, HttpSession session) {
		
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		if(loginInfo == null) {
			return loginPage;
		} else {
			int user_id = loginInfo.getUser_id();
			System.out.println("showAllMyReservation user_id : " + user_id);
	
			List<ReservationBean> reservationList = rdao.showAllMyReservationList(user_id);
			
			List<ReservationBean> reservationListNotDone = rdao.showAllMyReservationlistWithoutPay(user_id);
			
			List<ReservationBean> reservationCanceled = rdao.showAllMyReservationlistCanceled(user_id);
			
			model.addAttribute("reservationList", reservationList);
			model.addAttribute("reservationList2", reservationListNotDone);
			model.addAttribute("reservationList3", reservationCanceled);
			return getPage;
		}
	}
}
