package mypage.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
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

import mypage.model.MyShopDao;
import shop.model.ShopBean;
import shop.model.ShopRoomBean;

@Controller
public class MyRoomUpdateController {

	private final String command = "/update_room.mp";
	private final String getPage = "myroom_updateForm";
	private final String goToPage = "redirect:myshop_detail.mp?shop_id=";
	
	@Autowired
	MyShopDao myShopDao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView updateForm(
			@RequestParam(value = "shop_id") String shop_id,
			@RequestParam(value = "room_id") String room_id) {
		ModelAndView mav = new ModelAndView();
		Map<String, String> map = new HashMap<String, String>();
		map.put("shop_id", shop_id);
		map.put("room_id", room_id);
		
		ShopRoomBean room = myShopDao.getOneRoom(map);
		List<ShopRoomBean> room_image_list = myShopDao.getOneRoomImage(map);
		
		mav.addObject("room",room);
		mav.addObject("room_image_list",room_image_list);
		mav.setViewName(getPage);
		return mav;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView updateForm(
			@ModelAttribute("room") @Valid ShopRoomBean room,
			BindingResult result,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String uploadPath = servletContext.getRealPath("/resources/assets/image");
		Map<String, String> map = new HashMap<String, String>();
		map.put("shop_id", String.valueOf(room.getShop_id()));
		map.put("room_id", String.valueOf(room.getRoom_id()));
		
		String[] save_image = request.getParameterValues("save_image");
		List<ShopRoomBean> room_image_list = myShopDao.getOneRoomImage(map);
		
		if (result.hasErrors()) {
			System.out.println("### room update 에러");
			
			mav.addObject("room_image_list", room_image_list);
			mav.setViewName(getPage);
			return mav;
		}
		
		int cnt = -1;
		cnt = myShopDao.updateRoom(room);
		if(cnt>0) {
			// 신규 추가 이미지
			if(room.getUpload()!=null) {
				for(MultipartFile upload : room.getUpload()) {
					MultipartFile multi = upload;

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
			
			for(ShopRoomBean image : room_image_list) {
				Boolean flag = false;
				if(save_image != null) {
					for(String save : save_image) {
						System.out.println("save"+save);
						if(image.getRoom_img_id() == Integer.parseInt(save)) {
							flag =true;
						}					
					}					
				}
				
				if(flag == false) {
					System.out.println("삭제 이미지:"+image.getImage()+" & "+image.getRoom_img_id());
					
					String fullPath = uploadPath+File.separator+image.getImage();
					
					myShopDao.deleteRoomImage(image);
					
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
				}else {
					System.out.println("기존 이미지:"+image.getImage()+" & "+image.getRoom_img_id());
				}
			}
			mav.setViewName(goToPage+room.getShop_id());
			
		}else {
			mav.setViewName(getPage);
		}
		System.out.println("###성공"); 
		return mav;
	}
	
}
