package shop.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import shop.model.ShopBean;
import shop.model.ShopDao;

@Controller
public class MainListController {

	private final String command_region = "/region_list.sh";
	
	@Autowired
	ShopDao shopDao;
	
	@RequestMapping(value =  command_region,method = RequestMethod.GET )
	@ResponseBody
	public void keywordSearch(
			@RequestParam(value = "word") String word
			,@RequestParam(value = "type") String type
			,HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("type", type);
		map.put("word", word);
		
		// System.out.println("word:"+word);
		// System.out.println("type:"+type);
		List<ShopBean> result  = shopDao.getShopByRegion(map);   

		String json = new Gson().toJson(result);
		response.getWriter().write(json);
	}
	
}
