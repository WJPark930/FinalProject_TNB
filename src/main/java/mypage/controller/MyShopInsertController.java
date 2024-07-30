package mypage.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
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
	
	@Autowired
	ServletContext servletContext;
	
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
			HttpServletRequest request,
			HttpSession session) { 
		ModelAndView mav = new ModelAndView();
		
		// 가이드는 ,를 포함할 수 있기에 따로 배열로 받아준다.
		String[] guide_title = request.getParameterValues("guide_title");
		String[] guide_content = request.getParameterValues("guide_content");
		List<GuideBean> list_guide = new ArrayList<GuideBean>();

		/*
		 * System.out.println("getShop_name: "+shop.getShop_name());
		 * System.out.println("getShop_info: "+shop.getShop_info());
		 * System.out.println("getCategory_id: "+shop.getCategory_id());
		 * System.out.println("getService_name: "+shop.getService_name());
		 * System.out.println("getRegion	: "+shop.getRegion());
		 * System.out.println("getShop_address: "+shop.getShop_address());
		 * 
		 * for(int i=0;i<shop.getUpload().length;i++) {
		 * System.out.println("##upload"+i+": "+shop.getUpload()[i]);
		 * System.out.println("##shop_image"+i+": "+shop.getImage_name()[i]); }
		 */		
		
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
		
		// 유저 정보 추가
		if(session.getAttribute("loginInfo")!=null) {
			MemberBean member = (MemberBean)session.getAttribute("loginInfo");
			shop.setUser_id(member.getUser_id());			
		}else {
			shop.setUser_id(1);
		}
		
		int cnt = -1;
		cnt = myShopDao.insertShop(shop,list_guide); 
		
//		if(list_guide.size()>0) {
//			int abc =1;
//			for(GuideBean gb : list_guide){
//				gb.setGuide_id(abc++);
//				gb.setShop_id(1);				
//			}
//			for(GuideBean gb : list_guide){
//				System.out.println("gb_guide:"+gb.getGuide_id());
//				System.out.println("gb_shop:"+gb.getShop_id());
//			}
//		}
//		
//		String[] serviceFull = shop.getService_name().split(",");
//		for(String service : serviceFull) {
//			service = service.substring(0,service.indexOf("_"));
//			System.out.println("service1:"+service);
//		}
//		for(String service : serviceFull) {
//			System.out.println("service2:"+service);
//		}

		if(cnt>0) {
			for(MultipartFile upload : shop.getUpload()) {
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
			mav.setViewName(goToPage);
			
		}else {
	        List<SearchBean> list_service = shopDao.getServiceList();
	        List<CategoryBean> list_category = shopDao.getCategoryList();
			
			mav.addObject("list_service",list_service);
			mav.addObject("list_category",list_category);
			mav.setViewName(getPage);
		}
		

		return mav;
	}
	
}








