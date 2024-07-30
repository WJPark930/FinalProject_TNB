package shop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import shop.model.GuideBean;
import shop.model.ReviewBean;
import shop.model.ReviewDao;
import shop.model.SearchBean;
import shop.model.ServiceBean;
import shop.model.ShopBean;
import shop.model.ShopDao;
import shop.model.ShopRoomBean;
import utility.Shop_Paging;

@Controller
public class Shop_View_Controller {

	private final String command = "/viewShop.sh";
	private final String getPage = "shop_view";
	
	@Autowired
	ShopDao shopDao;
	
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView view(
			@RequestParam(value = "shop_id") String shop_id,
			@ModelAttribute("search") @Valid SearchBean search,
			HttpServletRequest request,
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("shop_id", shop_id);
		map.put("search", search);
		
		ShopBean shop_info = shopDao.getShopInfo(shop_id);
		List<String> shop_image = shopDao.getShopImage(shop_id);
		List<ServiceBean> shop_service = shopDao.getShopService(shop_id);
		List<GuideBean> shop_guide = shopDao.getShopGuide(shop_id);
		List<ShopRoomBean> shop_room = shopDao.getShopRoom(map);
		List<ShopRoomBean> room_image = shopDao.getRoomImage(shop_id);
		List<ReviewBean> shop_review = reviewDao.getShopReview(shop_id);
		List<ReviewBean> review_image = reviewDao.getShopReviewImage(shop_id);
		
		// member 테이블 추가후 수정 해야 하는 부분
		List<ReviewBean> review_recommend = null;
		if(session.getAttribute("loginInfo")!=null) {			
			MemberBean member = (MemberBean)session.getAttribute("loginInfo");
			review_recommend = reviewDao.getRecommendUser(String.valueOf(member.getUser_id()));
		}		
		
		mav.addObject("review_recommend",review_recommend);
		mav.addObject("shop_review",shop_review);
		mav.addObject("review_image",review_image);
		mav.addObject("room_image",room_image);
		mav.addObject("shop_room",shop_room);
		mav.addObject("shop_guide",shop_guide);
		mav.addObject("shop_service",shop_service);
		mav.addObject("shop_image",shop_image);
		mav.addObject("shop_info",shop_info);
		mav.setViewName(getPage);
		return mav;
	}
	
}
