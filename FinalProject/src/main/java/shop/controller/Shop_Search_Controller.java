package shop.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import utility.Paging;

@Controller
public class Shop_Search_Controller {

	private final String command = "search.sh";
	private final String getPage = "shop_list";
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> searchKeyword(
			@RequestParam(value = "keyword",required = false) String keyword
			) {
		Map<String, Object> response = new HashMap<String, Object>();
		System.out.println("keyword: "+keyword);
		response.put("keyword","test");
		
		return response;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView searchList(
			@RequestParam(value = "whatColumn",required = false) String whatColumn,
			@RequestParam(value = "pageNumber",required = false) String pageNumber,
			@RequestParam(value = "keyword") String keyword,
			@RequestParam(value = "day1") String day1,
			@RequestParam(value = "day2") String day2,
			@RequestParam(value = "people") String people,
			HttpServletRequest request) {
			ModelAndView mav = new ModelAndView();
			
//			System.out.println("keyword:"+keyword);
//			System.out.println("day1:"+day1);
//			System.out.println("day2:"+day2);
//			System.out.println("people:"+people);
			Map<String, String> map = new HashMap<String, String>();
			map.put("whatColumn", whatColumn);
			map.put("keyword", "%"+keyword+"%");
			String url = request.getContextPath()+ this.command;
			
			//int count = memberDao.getTotalCount(map);
			//Paging pageInfo = new Paging(pageNumber, null, count, url, whatColumn, keyword);
			
			
			
			mav.setViewName(getPage);
			return mav;
	}
	
}
