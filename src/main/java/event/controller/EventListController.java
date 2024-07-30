package event.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import event.model.EventBean;
import event.model.EventDao;

@Controller
public class EventListController {
	private final String command = "eventList.ev";
	private final String getPage = "eventList";
	
	@Autowired
	private EventDao edao;
	
	@RequestMapping(command)
	public String eventList(HttpServletRequest request, Model model) {
		System.out.println("EventListController");
		Map<String, String> map = new HashMap<String , String>();
		String url = request.getContextPath() + this.command;
	
		List<EventBean> eventList = edao.eventList(map);
		
		model.addAttribute("eventList", eventList);
		
		return getPage;
	}
}
