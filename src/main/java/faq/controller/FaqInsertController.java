package faq.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import faq.model.FaqBean;
import faq.model.FaqDao;

@Controller
public class FaqInsertController {

	public final String command = "insert.faq";
	public final String getPage = "faqInsertForm";
	public final String gotoPage = "redirect:/list.faq";
	
	@Autowired
	private FaqDao faqDao;
	
	@RequestMapping(value=command, method = RequestMethod.GET)
	public String doAction() {
		return getPage;
	}
	
	@RequestMapping(value=command, method = RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute("faq") @Valid FaqBean faq, BindingResult result) {
		
		ModelAndView mav = new ModelAndView();
		
		if(result.hasErrors()) {
			mav.setViewName(getPage);
			return mav;
		}
	
		int cnt = -1;
		cnt = faqDao.insertFaq(faq);
		mav.setViewName(gotoPage);
		return mav;
	}
}
