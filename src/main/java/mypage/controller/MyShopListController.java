package mypage.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import mypage.model.MyShopDao;
import shop.model.ShopBean;

@Controller
public class MyShopListController {
	
	private final String command = "/myshop_list.mp";
	private final String getPage = "myshop_list";
	
	@Autowired
	MyShopDao myShopDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView list(
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		// member
		if(session.getAttribute("loginInfo") != null) {
			MemberBean member = (MemberBean)session.getAttribute("loginInfo");
			List<ShopBean> shop_list = myShopDao.getMyShop(member.getUser_id());	
			mav.addObject("list_count", shop_list.size());
			mav.addObject("shop_list", shop_list);
			mav.setViewName(getPage);
		}else {
			mav.setViewName("redirect:main.jsp");
		}
		
		return mav;
	}
	
}
