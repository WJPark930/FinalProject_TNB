package shop.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import shop.model.CategoryBean;
import shop.model.SearchBean;
import shop.model.ShopBean;
import shop.model.ShopDao;
import utility.Shop_Paging;

@Controller
public class Shop_Search_Controller {


	private final String command = "/search.sh";
	private final String command_keyword = "/keyword.sh";
	private final String getPage = "shop_list";
	
	@Autowired
	ShopDao shopDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView searchList(
			@RequestParam(value = "whatColumn",required = false) String whatColumn,
			@RequestParam(value = "pageNumber",required = false) String pageNumber,
			@ModelAttribute("search") @Valid SearchBean search,
			HttpServletRequest request) {
		

			ModelAndView mav = new ModelAndView();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("whatColumn", whatColumn);
			if (search.getService()!=null) {
				String[] temp = search.getService().split(",");
				search.setService_arr(temp);
			}
			
			if(search.getPrice_range()==0) {
				search.setPrice_range(6);
			}
	        switch (search.getPrice_range()) {
	            case 1: search.setPrice(30000); break;
	            case 2: search.setPrice(50000); break;
	            case 3: search.setPrice(100000); break;
	            case 4: search.setPrice(200000); break;
	            case 5: search.setPrice(300000); break;
	            case 6: search.setPrice(10000000); break;
	        }
			
			map.put("search", search);
			String url = request.getContextPath()+ this.command;
			int count = shopDao.search_count(map);
			
			Shop_Paging pageInfo = new Shop_Paging(pageNumber, null, count, url, whatColumn);
			List<ShopBean> list_shop = shopDao.search_shop(pageInfo, map);
			List<SearchBean> list_service = shopDao.getServiceList();
			List<CategoryBean> list_category = shopDao.getCategoryList();
			
			mav.addObject("whatColumn",whatColumn);
			mav.addObject("list_service",list_service);
			mav.addObject("list_category",list_category);
			mav.addObject("list_shop",list_shop);
			mav.addObject("pageInfo",pageInfo);
			mav.setViewName(getPage);
			
			return mav;
	}
	
	// ,produces = "application/json" 추가하니까 가져오지도 못함
	// @RequestBody(required = false) Map<String, Object> map 
	/*
	 * @RequestMapping( value = command_keyword , method = RequestMethod.GET)
	 */
	@RequestMapping(value =  command_keyword,method = RequestMethod.GET )
	@ResponseBody
	public void keywordSearch(
			@RequestParam(value = "keyword") String keyword
			,HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		List<String> result  = shopDao.getKeyword(keyword);  

		String json = new Gson().toJson(result);
		response.getWriter().write(json);
	}
	
	
	
}








