package mypage.controller;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
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

import member.model.MemberBean;
import mypage.model.MyReviewDao;
import mypage.model.RoomReservationBean;
import shop.model.ReviewBean; 
import shop.model.ReviewDao;
import shop.model.ShopBean;

@Controller
public class ReviewInsertController {

	private final String command = "/review_insert.mp";
	private final String getPage = "review_insert_form";
	private final String goToPage = "redirect:gotoDetailPayment.pay?order_num=";
	
	@Autowired
	ReviewDao reviewDao;
	
	@Autowired
	MyReviewDao mypageReviewDao;
	
	@Autowired
	ServletContext servletContext;
	
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView insertform(
			@RequestParam(value = "reservation_id") String reservation_id,
			@RequestParam(value = "shop_name") String shop_name) {
		ModelAndView mav = new ModelAndView();
		
		RoomReservationBean reservation = mypageReviewDao.getReservationById(reservation_id);
		
		mav.addObject("shop_name", shop_name);
		mav.addObject("reservation", reservation);
		mav.setViewName(getPage);
		return mav;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView insert(
			@RequestParam(value = "shop_name") String shop_name,
			@ModelAttribute("reservation") @Valid RoomReservationBean reservation,
			@ModelAttribute("review") @Valid ReviewBean review, 
			BindingResult result,
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("shop_name", shop_name);
		//System.out.println("review.image:"+review.getImage());
		
		if (result.hasErrors()) {
			System.out.println("에러");
			mav.setViewName(getPage);
			return mav;
		}
		
		if(session.getAttribute("loginInfo") != null) {
			MemberBean member = (MemberBean)session.getAttribute("loginInfo");
			review.setUser_id(member.getUser_id());
		}
		
		//  개행 적용
		review.setReview_content(review.getReview_content().replaceAll("\r\n","<br>"));
		//System.out.println("content:"+review.getReview_content());
		
		int cnt = -1;
		cnt = mypageReviewDao.insertReview(review);
		
		if(cnt>0) {
			for(MultipartFile upload : review.getUpload()) {
				MultipartFile multi = upload;
				
				String uploadPath = servletContext.getRealPath("/resources/assets/image");
				
				File destination = new File(uploadPath+File.separator+multi.getOriginalFilename());
				try {
					multi.transferTo(destination);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			mav.setViewName(goToPage+reservation.getOrder_num());
			
		}else {
			mav.setViewName(getPage);
		}
		
		return mav;
	}
	
	
}
