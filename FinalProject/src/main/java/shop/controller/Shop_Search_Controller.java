package shop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import shop.model.CategoryBean;
import shop.model.SearchBean;
import shop.model.ShopBean;
import shop.model.ShopDao;
import utility.Paging;

@Controller
public class Shop_Search_Controller {

	private final String command = "search.sh";
	private final String getPage = "shop_list";
	
	@Autowired
	ShopDao shopDao;
	
//	@RequestMapping(value = command, method = RequestMethod.GET)
//	@ResponseBody
//	public Map<String, Object> searchKeyword(
//			@RequestParam(value = "keyword",required = false) String keyword
//			) {
//		Map<String, Object> response = new HashMap<String, Object>();
//		//System.out.println("keyword: "+keyword);
//		response.put("keyword","test");
//		
//		return response;
//	}
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView searchList(
			@RequestParam(value = "whatColumn",required = false) String whatColumn,
			@RequestParam(value = "pageNumber",required = false) String pageNumber,
			@ModelAttribute("search") @Valid SearchBean search,
			HttpServletRequest request) {
			ModelAndView mav = new ModelAndView();
			
			System.out.println("getCategory_id:"+search.getCategory_id());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("whatColumn", whatColumn);
			search.setKeyword("%"+search.getKeyword()+"%");
			if (search.getService()!=null) {
				String[] temp = search.getService().split(",");
				search.setService_arr(temp);
			}
			if (search.getMin_price()==null) {
				search.setMin_price("0");
			}			
			if (search.getMax_price()==null) {
				search.setMax_price("max");
			}			
			
			map.put("search", search);
			String url = request.getContextPath()+ this.command;
			
			//int count = memberDao.getTotalCount(map);
			//Paging pageInfo = new Paging(pageNumber, null, count, url, whatColumn, keyword);
			Paging pageInfo = null;
			List<ShopBean> list_shop = shopDao.search_shop(pageInfo, map);
			List<SearchBean> list_service = shopDao.getServiceList();
			List<CategoryBean> list_category = shopDao.getCategoryList();
			
			System.out.println("list_shop.size(): "+list_shop.size());
			
			mav.addObject("list_service",list_service);
			mav.addObject("list_category",list_category);
			mav.addObject("list_shop",list_shop);
			mav.setViewName(getPage);
			return mav;
	}
	
}
