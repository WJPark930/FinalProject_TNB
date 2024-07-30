package shop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import shop.model.ShopBean;
import shop.model.ShopDao;
import utility.Paging;

@Controller
public class AdminShopListController {
	
	private final String command ="shopList.sh";
	private final String getPage="admin_shop_List";
	
	@Autowired
	ShopDao shopDao;
	
	  @Autowired
	    ServletContext servletContext;
	
    @RequestMapping(value = command, method = RequestMethod.GET)
	public String list(
			
			@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="pageNumber", required=false) String pageNumber,
			HttpServletRequest request,
			Model model) {
    	
		/*
		 * if (keyword != null && !keyword.trim().isEmpty() &&
		 * whatColumn.equals("shop_status")) { if (keyword.equals("정지")) { keyword =
		 * "Y"; } else if (keyword.equals("운영중")) { keyword = "N"; } }
		 */
    	  
		System.out.println("ShopListController");
		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");

		int totalCount = shopDao.getTotalCount(map); 
		String url = request.getContextPath() + this.command;

		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword);

		List<ShopBean> shopLists = shopDao.getShopList(map, pageInfo);
		model.addAttribute("shopLists", shopLists);
		model.addAttribute("pageInfo", pageInfo);

		return getPage;
	}
	}