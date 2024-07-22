package faq.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import faq.model.FaqBean;
import faq.model.FaqDao;
import utility.Paging;

@Controller
public class FaqUserController {

	public final String command = "user.faq";
	public final String getPage = "faqUser";
	
	@Autowired
	FaqDao faqDao;
	
	@RequestMapping(command)
	public String list(
			@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword,
			HttpServletRequest request, Model model
			) {
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%"+keyword+"%");
		
		int totalCount = faqDao.getTotalCount(map);
		String url = request.getContextPath() + this.command;
		
		Paging pageInfo = new Paging(null,null,totalCount,url,whatColumn,keyword);
		
		List<FaqBean> faqList = faqDao.getFaqList(map, pageInfo);
		model.addAttribute("faqList", faqList);
		model.addAttribute("pageInfo", pageInfo);
		
		List<String> categoryList = faqDao.getCategoryList();
        model.addAttribute("categoryList", categoryList);
        
		return getPage;
	}
}
