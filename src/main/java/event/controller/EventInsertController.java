package event.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import event.model.EventBean;
import event.model.EventDao;
import member.model.MemberBean;

@Controller
public class EventInsertController {
	private final String command = "eventInsert.ev";
	private final String getPage = "eventInsertForm";
	private final String gotoPage = "redirect:/eventList.ev";
	private final String loginPage = "redirect:/loginForm.mb";

	@Autowired 
	private EventDao edao;

	@Autowired
	ServletContext servletContext;
	

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String gotoForm(HttpSession session) { 
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		if(loginInfo == null) {
			return loginPage;
		} else {
			return getPage;
		}
	}

	@RequestMapping(value=command, method = RequestMethod.POST)
	public ModelAndView eventInsert(@ModelAttribute("event") @Valid EventBean event, BindingResult result) {
		System.out.println("event.getEvent_image():"+event.getEvent_image()); 
		System.out.println("event.getUpload():"+event.getUpload());
		System.out.println("event.getEvent_discount_kind() : " + event.getEvent_discount_kind());
		System.out.println("event.getEvent_discount_amount() : " + event.getEvent_discount_amount());
		
		MultipartFile multi = event.getUpload();
		
		String uploadPath = servletContext.getRealPath("/resources/uploadEventImage/");
		System.out.println("uploadPath:" + uploadPath);
		
		ModelAndView mav = new ModelAndView();
		
		if(result.hasErrors()) {
			mav.setViewName(getPage);
			return mav; 
		}
		
		int cnt = -1;
		
		
		cnt = edao.eventInsert(event);
		if(cnt != -1) {
			mav.setViewName(gotoPage);
			
			File destination = new File(uploadPath+File.separator+multi.getOriginalFilename());
			try {
				multi.transferTo(destination);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			mav.setViewName(getPage);
		}
		
		return mav;
	}

}
