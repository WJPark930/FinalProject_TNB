package mypage.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
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
		
		List<ReviewBean> review_list = null;
		if(session.getAttribute("loginInfo")!=null) {			
			MemberBean member = (MemberBean)session.getAttribute("loginInfo");
			review_list = reviewDao.getMyReview(String.valueOf(member.getUser_id()));
		}
		
		mav.addObject("review_list", review_list);
		mav.setViewName(getPage);
		return mav;
	}
	
	
}
