package mypage.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import mypage.model.MyShopDao;
import mypage.model.RoomReservationBean;
import shop.model.CategoryBean;
import shop.model.GuideBean;
import shop.model.ReviewBean;
import shop.model.SearchBean;
import shop.model.ShopBean;
import shop.model.ShopDao;

@Controller
public class MyShopInsertController {
	
	private final String command = "/insert_shop.mp";
	private final String getPage = "myshop_insertForm";
	private final String goToPage = "redirect:myshop_list.mp";
	
	@Autowired
	MyShopDao myShopDao;
	
	@Autowired
	ShopDao shopDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView insertform() {
		ModelAndView mav = new ModelAndView();
		
		List<SearchBean> list_service = shopDao.getServiceList();
		List<CategoryBean> list_category = shopDao.getCategoryList();
		
		mav.addObject("list_service",list_service);
		mav.addObject("list_category",list_category);
		mav.setViewName(getPage);
		return mav;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView insert(
			@ModelAttribute("guide") GuideBean guide,
			@ModelAttribute("shop") @Valid ShopBean shop,
			BindingResult result) { 
		ModelAndView mav = new ModelAndView();
		
		System.out.println("getShop_name: "+shop.getShop_name());
		System.out.println("getShop_info: "+shop.getShop_info());
		System.out.println("getCategory_id: "+shop.getCategory_id());
		System.out.println("getService_id: "+shop.getService_id());
		System.out.println("getRegion	: "+shop.getRegion());
		System.out.println("getShop_address: "+shop.getShop_address());
		
		if (result.hasErrors()) {
			System.out.println("### shop insert ¿¡·¯");
	        List<SearchBean> list_service = shopDao.getServiceList();
	        List<CategoryBean> list_category = shopDao.getCategoryList();
	        
	        mav.addObject("list_service", list_service);
	        mav.addObject("list_category", list_category);
	        mav.setViewName(getPage);
	        return mav;
	    }
		
		shop.setShop_info(shop.getShop_info().replaceAll("\r\n","<br>"));
		if(guide.getGuide_content()!=null) {
			guide.setGuide_content(guide.getGuide_content().replaceAll("\r\n","<br>"));			
		}
		
		
		
		mav.setViewName(getPage);
		return mav;
	}
	
}








