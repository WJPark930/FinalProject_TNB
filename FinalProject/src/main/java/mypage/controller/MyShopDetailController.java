package mypage.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import mypage.model.MyShopDao;
import shop.model.GuideBean;
import shop.model.ServiceBean;
import shop.model.ShopBean;
import shop.model.ShopDao;
import shop.model.ShopRoomBean;

@Controller
public class MyShopDetailController {
	
	private final String command = "/myshop_detail.mp";
	private final String getPage = "myshop_detailView";
	
	@Autowired
	MyShopDao myShopDao;
	
	@Autowired
	ShopDao shopDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView view(
			@RequestParam(value = "shop_id") String shop_id) {
		ModelAndView mav = new ModelAndView();
		
		ShopBean shop_info = shopDao.getShopInfo(shop_id);
		List<String> shop_image = shopDao.getShopImage(shop_id);
		List<ServiceBean> shop_service = shopDao.getShopService(shop_id);
		List<GuideBean> shop_guide = shopDao.getShopGuide(shop_id);
		List<ShopRoomBean> shop_room = myShopDao.getMyShopRoom(shop_id);
		
		mav.addObject("shop_room",shop_room);
		mav.addObject("shop_guide",shop_guide);
		mav.addObject("shop_service",shop_service);
		mav.addObject("shop_image",shop_image);
		mav.addObject("shop_info",shop_info);
		mav.setViewName(getPage);
		return mav;
	}

}
