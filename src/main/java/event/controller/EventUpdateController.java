package event.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import event.model.EventBean;
import event.model.EventDao;
import member.model.MemberBean;

@Controller
public class EventUpdateController {
	private final String command = "eventUpdate.ev";
	private final String getPage = "eventUpdateForm";
	private final String gotoPage = "redirect:/eventList.ev";
	private final String loginPage = "redirect:/loginForm.mb";
	
	@Autowired
	private EventDao edao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value=command, method = RequestMethod.GET)
	public String gotoForm(@RequestParam(value="event_num", required = true) int event_num, HttpSession session, Model model) {
		
		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		if(loginInfo == null) {
			return loginPage;
		} else {
			EventBean event = edao.eventDetail(event_num);
			System.out.println("eventUpdateController end_date : " + event.getEvent_end_date());
			
			model.addAttribute("event", event);
			return getPage;
		}
	}
	
	@RequestMapping(value=command, method = RequestMethod.POST)
	public ModelAndView eventUpdate(@ModelAttribute("event") @Valid EventBean event, BindingResult result) {
		
		ModelAndView mav = new ModelAndView();
		if(result.hasErrors()) {
			mav.setViewName(getPage);
			if(event.getEvent_image().equals("")) {
				event.setEvent_image(event.getUpload2());
			}
			
			return mav;
		}
		
		String deletePath = servletContext.getRealPath("/resources/uploadEventImage/");
		
		System.out.println("event.getEvent_end_date() : " + event.getEvent_end_date());
		
		int cnt = -1;
		cnt = edao.eventUpdate(event);
		System.out.println("updateController cnt : " + cnt);
		/*
		if(cnt != -1) {
			
			
			File delFile = new File(deletePath+File.separator+event.getUpload2());
			if(delFile.exists()) {
				delFile.delete();
			}
			
			
			MultipartFile multi = event.getUpload();
			String uploadPath = servletContext.getRealPath("/resources/uploadEventImage/");
			File destination = new File(uploadPath+File.separator+multi.getOriginalFilename());
			try {
				multi.transferTo(destination);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		*/
		
		mav.setViewName(gotoPage);
		return mav;
	}

}
