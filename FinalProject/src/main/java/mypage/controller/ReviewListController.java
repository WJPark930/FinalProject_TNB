package mypage.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import shop.model.ReviewBean;
import shop.model.ReviewDao;



@Controller
public class ReviewListController {

	private final String command = "/review_list.mp";
	private final String getPage = "review_list";
	
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView list(
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		// member 테이블 추가후 수정 해야 하는 부분
		// member bean 이 있어야 아이디 가져올수있음
		if(session.getAttribute("loginInfo")!=null) {			
		}
		List<ReviewBean> review_list = reviewDao.getMyReview("1");
		
		// ---------------------------------------		
		
		mav.addObject("review_list", review_list);
		mav.setViewName(getPage);
		return mav;
	}
	
	
}
