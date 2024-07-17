package event.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class EventPointController {
	private final String command = "eventPoint.ev";
	private final String gotoPage = "eventList";
	
	@Autowired
	private MemberDao mdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(command)
	public String getPoint(@ModelAttribute("member") MemberBean mb, Model model) {
		
		System.out.println("mb.getUser_point() : " + mb.getUser_point());
		System.out.println("mb.getUser_id() : " + mb.getUser_id());
		
		int cnt = -1;
		
		cnt = mdao.getPoint(mb);
		
		if(cnt > 0) {
			System.out.println("포인트 적립 완료");
		}
		
		return gotoPage;
	}
}
