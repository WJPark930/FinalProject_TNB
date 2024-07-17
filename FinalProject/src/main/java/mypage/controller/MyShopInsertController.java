package mypage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
			@ModelAttribute("shop") @Valid ShopBean shop,
			BindingResult result,
			HttpServletRequest request) { 
		ModelAndView mav = new ModelAndView();
		
		// 가이드는 ,를 포함할 수 있기에 따로 배열로 받아준다.
		String[] guide_title = request.getParameterValues("guide_title");
		String[] guide_content = request.getParameterValues("guide_content");
		List<GuideBean> list_guide = new ArrayList<GuideBean>();

        
		//System.out.println("getShop_name: "+shop.getShop_name());
		//System.out.println("getShop_info: "+shop.getShop_info());
		//System.out.println("getCategory_id: "+shop.getCategory_id());
		//System.out.println("getCategory_name: "+shop.getCategory_name());
		//System.out.println("getRegion	: "+shop.getRegion());
		//System.out.println("getShop_address: "+shop.getShop_address());
		System.out.println("guide_title:"+guide_title);
		
		if (result.hasErrors()) {
			System.out.println("### shop insert 에러");
	        List<SearchBean> list_service = shopDao.getServiceList();
	        List<CategoryBean> list_category = shopDao.getCategoryList();
	        
	        // 현재까지 작성한 가이드 반환 (개행 전환을 하면안되기에 에러 날시 버전)
	        if(guide_title != null) {
	        	for(int i=0;i<guide_title.length;i++) {
	        		GuideBean gb = new GuideBean();
	        		gb.setGuide_title(guide_title[i]);
	        		gb.setGuide_content(guide_content[i]);
	        		list_guide.add(gb);
	        	}
	        }
	        
	        mav.addObject("list_guide", list_guide);
	        mav.addObject("list_service", list_service);
	        mav.addObject("list_category", list_category);
	        mav.setViewName(getPage);
	        return mav;
	    } 
		
		// 시설정보 및 가이드 형변환
		shop.setShop_info(shop.getShop_info().replaceAll("\r\n","<br>"));
		if(guide_title!=null) {
			for(int i=0;i<guide_content.length;i++) {
				guide_content[i] = guide_content[i].replaceAll("\r\n","<br>");							
				GuideBean gb = new GuideBean();
				gb.setGuide_title(guide_title[i]);
				gb.setGuide_content(guide_content[i]);
				list_guide.add(gb);
			}
		}			
		System.out.println("###성공");
		mav.setViewName(getPage);
		return mav;
	}
	
}








