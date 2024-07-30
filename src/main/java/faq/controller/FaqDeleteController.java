package faq.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import faq.model.FaqDao;

@Controller
public class FaqDeleteController {

	private final String command = "delete.faq";
	private final String gotoPage = "redirect:/list.faq";
	
	@Autowired
	FaqDao faqDao;
	
	@RequestMapping(command)
	public String delete(
			@RequestParam(value="faq_id") int faq_id,
			@RequestParam(value="whatColumn") String whatColumn,
			@RequestParam(value="keyword") String keyword) {
	
		faqDao.deleteFaq(faq_id);
		
		try {
			String encodeKeyword = URLEncoder.encode(keyword, "UTF-8");
			String encodeWhatColumn = URLEncoder.encode(whatColumn, "UTF-8");
			
			String redirectURL = gotoPage + "?faq_id=" + faq_id + "&whatColumn=" + encodeWhatColumn + "&keyword=" + encodeKeyword;
			return redirectURL;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return gotoPage;
		}
	}
}
