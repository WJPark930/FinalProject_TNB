package member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MemberReservationController {

	private final String command= "/reservationCheck.mb";
	private final String getPage ="memberReservationForm";
	
	  @RequestMapping(value = command, method = RequestMethod.GET)
	    public String showReservationPage(@RequestParam("user_id") String user_id, Model model) {
	        // 여기서 userId를 사용하여 예약 정보를 처리하고, 필요한 데이터를 모델에 추가합니다.
	        // 예약 정보를 DB에서 조회하거나 다른 비즈니스 로직을 수행할 수 있습니다.

	        // 예약 정보를 모델에 추가 (가상의 데이터 예시)
	        model.addAttribute("user_id", user_id);
	        // 여기에 예약 정보를 가져오는 로직을 추가할 수 있습니다.

	        // 예약 확인 페이지로 이동하는 뷰 이름을 반환합니다.
	        return getPage;
	    }

	    // 다른 메소드나 요청 핸들러 추가 가능
	}