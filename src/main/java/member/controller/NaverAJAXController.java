package member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class NaverAJAXController {
	private final String command = "ajax.mb";
	private final String gotoPage = "naverajaxPage";
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String gotoPage(
			@RequestParam("n_age") String n_age, 
			@RequestParam("n_birthday") String n_birthday, 
			@RequestParam("n_email") String n_email, 
			@RequestParam("n_gender") String n_gender, 
			@RequestParam("n_id") String n_id, 
			@RequestParam("n_name") String n_name, 
			@RequestParam("n_nickName") String n_nickName,
			Model model) {
		
		System.out.println("n_age : " + n_age);
		System.out.println("n_birthday : " + n_birthday);
		System.out.println("n_email : " + n_email);
		System.out.println("n_gender : " + n_gender);
		System.out.println("n_id : " + n_id);
		System.out.println("n_name : " + n_name);
		System.out.println("n_nickName : " + n_nickName);
		
		String result = "no";
	    
		 if(n_email != null) { 
			 result = "ok"; 
		 }

		 model.addAttribute("result", result);
		 return gotoPage;
		 
	}
}
