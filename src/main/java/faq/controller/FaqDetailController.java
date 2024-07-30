package faq.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import faq.model.FaqBean;
import faq.model.FaqDao;

@Controller
public class FaqDetailController {

	private final String command = "detail.faq";
	private final String getPage = "faqDetail";
	
	@Autowired
	FaqDao faqDao;
	
	@RequestMapping(command)
	public String deatil(
			@RequestParam("faq_id") int faq_id,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword,
			Model model) {
		
		FaqBean faq = faqDao.getFaq(faq_id);
		model.addAttribute("faq",faq);
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		
		return getPage;
	}
}
