package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MemberDetailController {
	
	private final String command ="detail.mb";
	private final String viewPage ="memberDetail";
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(value=command)
	public String detail(@RequestParam("user_id") int user_id,
			@RequestParam(value = "pageNumber",required = false) String pageNumber,
			@RequestParam(value="whatColumn",required = false)String whatColumn,
			@RequestParam(value="keyword",required = false)String keyword,
			Model model) {
		
		System.out.println(user_id);
		System.out.println(pageNumber);
		
	//	memberDao.updateReadCount(user_id);
		
		MemberBean member =memberDao.detailMember(user_id);
		
		model.addAttribute("member",member);
		model.addAttribute("pageNumber",pageNumber);
		model.addAttribute("whatColumn",whatColumn);
		model.addAttribute("keyword",keyword);
		return viewPage;
	}

}
