package mypage.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
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

import mypage.model.MyShopDao;
import shop.model.CategoryBean;
import shop.model.GuideBean;
import shop.model.SearchBean;
import shop.model.ShopBean;
import shop.model.ShopDao;
import shop.model.ShopRoomBean;

@Controller
public class MyRoomInsertController {

	private final String command = "/insert_room.mp";
	private final String getPage = "myroom_insertForm";
	private final String goToPage = "redirect:myshop_detail.mp?shop_id=";

	@Autowired
	MyShopDao myShopDao;

	@Autowired
	ServletContext servletContext;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView insertform(@RequestParam(value = "shop_id") String shop_id) {
		ModelAndView mav = new ModelAndView();
		
		ShopRoomBean room = new ShopRoomBean();
		room.setShop_id(Integer.parseInt(shop_id));
		mav.addObject("room", room);
		mav.setViewName(getPage);
		return mav;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute("room") @Valid ShopRoomBean room, BindingResult result,
			HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		System.out.println("shop_id: "+room.getShop_id()); 
		 System.out.println("getRoom_name: "+room.getRoom_name());
		 System.out.println("getPrice: "+room.getPrice());
		 System.out.println("getMax_people: "+room.getMax_people());
		 System.out.println("getStandard_people: "+room.getStandard_people());
		 System.out.println("getCheck_in: "+room.getCheck_in());
		 System.out.println("getCheck_out	: "+room.getCheck_out());
		 System.out.println("getRoom_count: "+room.getRoom_count());
		 
		 for(int i=0;i<room.getUpload().length;i++) {
		 System.out.println("##upload"+i+": "+room.getUpload()[i]);
		 System.out.println("##room_image"+i+": "+room.getImage_name()[i]); }
		 

		if (result.hasErrors()) {
			System.out.println("### shop insert 에러");

			mav.setViewName(getPage);
			return mav;
		}

		int cnt = -1;
		cnt = myShopDao.insertRoom(room);

		if (cnt > 0) {
			for (MultipartFile upload : room.getUpload()) {
				MultipartFile multi = upload;

				String uploadPath = servletContext.getRealPath("/resources/assets/image");

				File destination = new File(uploadPath + File.separator + multi.getOriginalFilename());
				try {
					multi.transferTo(destination);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			mav.setViewName(goToPage+room.getShop_id());

		} else {

			mav.setViewName(getPage);
		}
		
		//System.out.println("### 성공");
		return mav;
	}

}
