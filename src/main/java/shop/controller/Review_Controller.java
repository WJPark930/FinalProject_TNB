package shop.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import shop.model.ReviewDao;

@Controller
public class Review_Controller {

	private final String command = "/review.sh";
	private final String com_recommend = "/recommend.sh";
	
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(value = com_recommend, method = RequestMethod.POST)
	@ResponseBody
	public void recommend(
			@RequestParam(value = "like") String like,
			@RequestParam(value = "review_id") String review_id,
			@RequestParam(value = "user_id") String user_id){
		System.out.println(review_id);
		System.out.println(user_id);
		Map<String, String> map = new HashMap<String, String>();
		map.put("review_id", review_id);
		map.put("user_id", user_id);
		
		if(like.equals("unlike")){
			reviewDao.reviewLike(map);
		}else{
			reviewDao.reviewUnlike(map);
		}
		
	}
	
}
