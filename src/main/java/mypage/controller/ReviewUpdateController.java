package mypage.controller;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import mypage.model.MyReviewDao;
import mypage.model.RoomReservationBean;
import shop.model.ReviewBean; 
import shop.model.ReviewDao;

@Controller
public class ReviewUpdateController {

	private final String command = "/review_update.mp";
	private final String getPage = "review_update_form";
	private final String goToPage = "redirect:gotoDetailPayment.pay?order_num=";
	
	@Autowired
	ReviewDao reviewDao;
	
	@Autowired
	MyReviewDao mypageReviewDao;
	
	@Autowired
	ServletContext servletContext;
	
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView updateform(
			@RequestParam(value = "review_id") String review_id) {
		ModelAndView mav = new ModelAndView();
		
		ReviewBean review = mypageReviewDao.getReviewById(review_id);
		List<ReviewBean> review_img_list = mypageReviewDao.getReviewImageById(review_id);
		RoomReservationBean reservation = mypageReviewDao.getReservationById(String.valueOf(review.getReservation_id()));
		
		review.setReview_content(review.getReview_content().replaceAll("<br>","\r\n"));
		mav.addObject("reservation", reservation);
		mav.addObject("review_img_list", review_img_list);
		mav.addObject("review", review);
		mav.setViewName(getPage);
		return mav;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView update(			
			@ModelAttribute("reservation") RoomReservationBean reservation,			 
			@ModelAttribute("review") @Valid ReviewBean review,
			BindingResult result) {
		ModelAndView mav = new ModelAndView();
		String uploadPath = servletContext.getRealPath("/resources/assets/image");
		// System.out.println("getSave_image:"+review.getSave_image()); 
		
		List<ReviewBean> review_img_list = mypageReviewDao.getReviewImageById(String.valueOf(review.getReview_id()));
		mav.addObject("review_img_list", review_img_list);
		
		if (result.hasErrors()) {
			System.out.println("에러");
			mav.setViewName(getPage);
			return mav;
		}
		
		review.setReview_content(review.getReview_content().replaceAll("\r\n","<br>"));		
		if(review.getUpload()==null) {
			review.setImage("");
		}

		int cnt = -1;
		cnt = mypageReviewDao.updateReview(review);
		if(cnt>0) {
			// 신규 추가 이미지
			if(review.getUpload()!=null) {
				for(MultipartFile upload : review.getUpload()) {
					MultipartFile multi = upload;
					//System.out.println("###:"+uploadPath+File.separator+multi.getOriginalFilename());
					File destination = new File(uploadPath+File.separator+multi.getOriginalFilename());
					try {
						multi.transferTo(destination);
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			
			for(ReviewBean image : review_img_list) {
				if(review.getSave_image()==null){
					review.setSave_image("");
				}
				if(!review.getSave_image().contains(image.getImage())) {
					System.out.println("삭제된 이미지:"+image.getImage()+" & "+image.getReview_img_id());
					
					// 데이터베이스에 이미지 테이블 삭제
					mypageReviewDao.deleteReviewImage(image);
					
					// 이미지 폴더내 파일 삭제
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
			
			}
			mav.setViewName(goToPage+review.getReservation_id());
			
		}else {
			mav.setViewName(getPage);
		}
		
		return mav;
	}
	
	
}
