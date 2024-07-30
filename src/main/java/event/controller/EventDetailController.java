package event.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import event.model.*;

@Controller
public class EventDetailController {
	
	@Autowired
	EventDao edao;
	
	private final String command = "eventDetail.ev";
	private final String getPage = "eventDetailView";
	
	@RequestMapping(value = command)
	public String eventDetailView(
			@RequestParam(value =  "event_num", required = true) int event_num,
			Model model) {
		System.out.println("EventDetailController");
		EventBean event = edao.eventDetail(event_num);
	
		model.addAttribute("event", event);
		
		return getPage;
	}
	
}
