package shop.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Shop_Search_Controller {

	private final String command = "/search.sh";
	private final String getPage = "";
	
	@RequestMapping(value = command, method = RequestMethod.GET, produces = "application/json", consumes = "application/json")
	@ResponseBody
	public Map<String, Object> searchKeyword(
			@RequestParam(value = "keyword",required = false) String keyword
			) {
		Map<String, Object> response = new HashMap<String, Object>();
		System.out.println("keyword: "+keyword);
		response.put("keyword",keyword);
		
		return response;
	}
	
}
