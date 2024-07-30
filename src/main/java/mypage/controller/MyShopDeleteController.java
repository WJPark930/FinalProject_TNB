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

import mypage.model.MyShopDao;
import shop.model.ReviewBean;
import shop.model.ReviewDao;
import shop.model.ShopDao;
import shop.model.ShopRoomBean;

@Controller
public class MyShopDeleteController {
	
	private final String command = "/delete_shop.mp";
	private final String getPage = "redirect:myshop_list.mp";
	
	@Autowired
	MyShopDao myShopDao;
	
	@Autowired
	ShopDao shopDao;
	
	@Autowired
	ReviewDao reviewDao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String delete(
			@RequestParam(value = "shop_id") String shop_id
			) {
		
		//	System.out.println("shop_id: "+shop_id); 
		String uploadPath = servletContext.getRealPath("/resources/assets/image");
		List<ReviewBean> review_image_list = reviewDao.getShopReviewImage(shop_id);
		List<String> shop_image_list = shopDao.getShopImage(shop_id);
		List<ShopRoomBean> room_image_list = shopDao.getRoomImage(shop_id);
		
		int cnt =-1;
		cnt = myShopDao.deleteShop(shop_id); 
		
		if(cnt>0) {
			// 시설이미지 삭제
			for(String image : shop_image_list) {
				System.out.println(image);
				String fullPath = uploadPath+File.separator+image;
				
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
			// 객실이미지 삭제
			for(ShopRoomBean image : room_image_list) {
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
			// 리뷰이미지 삭제
			for(ReviewBean image : review_image_list) {
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
		}
		
		return getPage;
	}
	
	
	
}
