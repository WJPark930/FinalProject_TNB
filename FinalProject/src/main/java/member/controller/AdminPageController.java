package member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminPageController {

	
	private final String command = "gotoAdminPage.mb";
	private final String getPage = "adminMypage";
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String gotoadminpage() {
		return getPage;
	}
}
