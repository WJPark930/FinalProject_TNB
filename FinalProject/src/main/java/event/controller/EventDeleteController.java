package event.controller;

import java.io.File;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import event.model.*;

@Controller
public class EventDeleteController {
	private final String command = "eventDelete.ev";
	private final String gotoPage = "redirect:/eventList.ev";
	private final String loginPage = "";
	
	@Autowired
	EventDao edao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(command)
	public String eventDelete(@RequestParam int event_num, Model model) {
		EventBean event = edao.eventDetail(event_num);
		
		String event_image = event.getEvent_image();
		System.out.println("delete event_image : " + event_image);
		
		String deletePath = servletContext.getRealPath("/resources/uploadEventImage/");
		
		int cnt = -1;
		cnt = edao.eventDelete(event_num);
		
		if(cnt != -1) {
			File delFile = new File(deletePath+File.separator+event_image);
			if(delFile.exists()) {
				delFile.delete();
			}
		}
		
		return gotoPage;
	}

}
