package mypage.controller;

import java.io.File;
import java.util.List; 

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import mypage.model.MyReviewDao;
import shop.model.ReviewBean;

@Controller
public class ReviewDeleteController {

	private final String command = "/review_delete.mp";
	private final String getPage = "redirect:review_list.mp";
	
	@Autowired
	MyReviewDao mypageReviewDao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView deleteReview(
			@RequestParam(value = "review_id") String review_id) {
		ModelAndView mav = new ModelAndView();
		// System.out.println("review_id:"+review_id);
		String uploadPath = servletContext.getRealPath("/resources/assets/image");
		
		List<ReviewBean> image_list = mypageReviewDao.getReviewImageById(review_id); 
		  
		for(ReviewBean image : image_list) {
			System.out.println(image.getImage());
			String fullPath = uploadPath+File.separator+image.getImage();
			
			File file = new File(fullPath);
		 	if(file.exists()){
		 		if(file.delete()){
		 			System.out.println("파일 삭제");
		 		}else{
		 			System.out.println("파일삭제 실패");
		 		}
		 	}else{
		 			System.out.println("파일없음");
		 	}
			
		}
		
		mypageReviewDao.deleteReview(review_id); 
		
		mav.setViewName(getPage);		
		return mav;
	}
	
	
}
