package faq.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import faq.model.FaqBean;
import faq.model.FaqDao;

@Controller
public class FaqUpdateController {

	private final String command = "update.faq";
	private final String getPage = "faqUpdateForm";
	private final String gotoPage = "redirect:/detail.faq";
	
	@Autowired
	FaqDao faqDao;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String update(
			@RequestParam("faq_id") int faq_id,
			@RequestParam("whatColumn") String whatColumn,
			@RequestParam("keyword") String keyword,
			Model model) {
		
		FaqBean faq = faqDao.getFaq(faq_id);
		model.addAttribute("faq",faq);
		
		return getPage;
	}
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	public ModelAndView update(
			@ModelAttribute(value="faq") @Valid FaqBean faq, BindingResult result,
			@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword) {
		
		ModelAndView mav = new ModelAndView();
		
		if(result.hasErrors()) {
			mav.setViewName(getPage);
			return mav;
		}
		faqDao.updateFaq(faq);
		
		mav.addObject("faq_id", faq.getFaq_id());
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		
		mav.setViewName(gotoPage);
		
		return mav;
	}
}
