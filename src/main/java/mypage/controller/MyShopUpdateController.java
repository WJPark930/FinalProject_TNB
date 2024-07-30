package mypage.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
import mypage.model.RoomReservationBean;
import shop.model.CategoryBean;
import shop.model.GuideBean;
import shop.model.ReviewBean;
import shop.model.SearchBean;
import shop.model.ServiceBean;
import shop.model.ShopBean;
import shop.model.ShopDao;

@Controller
public class MyShopUpdateController {

	private final String command = "/update_shop.mp";
	private final String getPage = "myshop_updateForm";
	private final String goToPage = "redirect:myshop_detail.mp?shop_id=";
	
	@Autowired
	MyShopDao myShopDao;
	
	@Autowired
	ShopDao shopDao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView updateform(
			@RequestParam(value = "shop_id") String shop_id) {
		ModelAndView mav = new ModelAndView();
		
		List<SearchBean> list_service = shopDao.getServiceList();
		List<CategoryBean> list_category = shopDao.getCategoryList();
		ShopBean shop = shopDao.getShopInfo(shop_id);
		List<GuideBean> list_guide = shopDao.getShopGuide(shop_id);
		List<ServiceBean> Myservice = shopDao.getShopService(shop_id);
		List<ShopBean> shop_image_list = myShopDao.getShopImage(shop_id);

		try {
			shop.setShop_info(shop.getShop_info().replaceAll("<br>","\r\n"));			
		} catch (Exception e) {

		}
		if(list_guide!=null) { 
			for(GuideBean guide : list_guide) {
				guide.setGuide_content(guide.getGuide_content().replaceAll("<br>","\r\n"));								
			}
			if(Myservice.size()>0) {
				String service_name = "";
				for(ServiceBean service : Myservice) {
					service_name += service.getService_id()+"_"+service.getService_name()+",";
				}
				shop.setService_name(service_name);
				
			}			
		}
		
		mav.addObject("shop_image_list",shop_image_list);
		mav.addObject("list_guide",list_guide);
		mav.addObject("shop",shop);
		mav.addObject("list_service",list_service);
		mav.addObject("list_category",list_category);
		mav.setViewName(getPage);
		return mav;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView update(
			@ModelAttribute("shop") @Valid ShopBean shop,
			BindingResult result,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String uploadPath = servletContext.getRealPath("/resources/assets/image");
		
		// 가이드는 ,를 포함할 수 있기에 따로 배열로 받아준다.
		String[] guide_id = request.getParameterValues("guide_id");
		String[] guide_title = request.getParameterValues("guide_title");
		String[] guide_content = request.getParameterValues("guide_content");
		List<GuideBean> list_guide = new ArrayList<GuideBean>(); 
 		
		String[] save_image = request.getParameterValues("save_image");
		List<ShopBean> shop_image_list = myShopDao.getShopImage(String.valueOf(shop.getShop_id()));
		
//		 System.out.println("getShop_name: "+shop.getShop_name());
//		 System.out.println("getShop_info: "+shop.getShop_info());
//		 System.out.println("getCategory_id: "+shop.getCategory_id());
//		 System.out.println("getService_name: "+shop.getService_name());
//		 System.out.println("getRegion	: "+shop.getRegion());
//		 System.out.println("getShop_address: "+shop.getShop_address());
//		 
//		 if(shop.getUpload()!=null) {
//			 for(int i=0;i<shop.getUpload().length;i++) {
//				 System.out.println("##upload"+i+": "+shop.getUpload()[i]);
//				 System.out.println("##shop_image"+i+": "+shop.getImage_name()[i]); 
//			 }			 
//		 }
		 
		
		if (result.hasErrors()) {
			System.out.println("### shop update 에러");
	        List<SearchBean> list_service = shopDao.getServiceList();
	        List<CategoryBean> list_category = shopDao.getCategoryList();
	        
	        if(guide_title != null) {
	        	for(int i=0;i<guide_title.length;i++) {
	        		GuideBean gb = new GuideBean();
	        		if(guide_id != null && !guide_id.equals("0")) {
	        			if(guide_id.length > i){
	        				gb.setGuide_id(Integer.parseInt(guide_id[i]));	        				        				
	        			}	        			
	        		}
	        		gb.setGuide_title(guide_title[i]);
	        		gb.setGuide_content(guide_content[i]);
	        		list_guide.add(gb);
	        	}
	        }
	        
	        mav.addObject("shop_image_list", shop_image_list);
	        mav.addObject("list_guide", list_guide);
	        mav.addObject("list_service", list_service);
	        mav.addObject("list_category", list_category);
	        mav.setViewName(getPage);
	        return mav;
	    } 
		
		
		try {
			shop.setShop_info(shop.getShop_info().replaceAll("<br>","\r\n"));			
		} catch (Exception e) {

		}
		if(guide_title!=null) {
			for(int i=0;i<guide_content.length;i++) {
				guide_content[i] = guide_content[i].replaceAll("\r\n","<br>");							
				GuideBean gb = new GuideBean();
        		if(guide_id != null && !guide_id.equals("0")) {
        			if(guide_id.length > i){
        				gb.setGuide_id(Integer.parseInt(guide_id[i]));	        				        				
        			}	        			
        		}
				gb.setGuide_title(guide_title[i]);
				gb.setGuide_content(guide_content[i]);
				list_guide.add(gb);
			}
		}	
		List<GuideBean> save_guide = shopDao.getShopGuide(String.valueOf(shop.getShop_id()));
		
		int cnt = -1;
		cnt = myShopDao.updateShop(shop,list_guide,save_guide);  
		if(cnt>0) {
			// 신규 추가 이미지
			if(shop.getUpload()!=null) {
				for(MultipartFile upload : shop.getUpload()) {
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
			
			for(ShopBean image : shop_image_list) {
				Boolean flag = false;
				if(save_image != null) {
					for(String save : save_image) {
						if(image.getShop_img_id() == Integer.parseInt(save)) {
							flag =true;
						}					
					}					
				}
				
				if(flag == false) {
					System.out.println("삭제 이미지:"+image.getImage()+" & "+image.getShop_img_id());
					
					String fullPath = uploadPath+File.separator+image.getImage();
					
					myShopDao.deleteShopImage(image);
					
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
					System.out.println("기존 이미지:"+image.getImage()+" & "+image.getShop_img_id());
				}
			}
			mav.setViewName(goToPage+shop.getShop_id());
			
		}else {
			mav.setViewName(getPage);
		}
		
		return mav;
	}
	
}
