package mypage.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import mypage.model.MyShopDao;
import shop.model.ReviewBean;
import shop.model.ShopRoomBean;

@Controller
public class MyRoomDeleteController {

	private final String command = "/delete_room.mp";
	private final String getPage = "redirect:myshop_detail.mp?shop_id=";

	@Autowired
	MyShopDao myShopDao;

	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String delete(
			@RequestParam(value = "shop_id") String shop_id,
			@RequestParam(value = "room_id") String room_id) {
		String uploadPath = servletContext.getRealPath("/resources/assets/image");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("shop_id", shop_id);
		map.put("room_id", room_id);
		List<ShopRoomBean> room_image_list = myShopDao.getOneRoomImage(map);
		
		int cnt =-1;
		cnt = myShopDao.deleteRoom(map); 
		
		if(cnt>0) {
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
		}
		
		return getPage+shop_id;
	}
	
}
