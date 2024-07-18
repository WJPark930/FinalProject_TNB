package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberDao;

@Controller
public class MemberDeleteController {
	
	private final String command = "delete.mb";
	private final String gotoPage="redirect:/memberList.mb";
	
	
	@Autowired
	MemberDao memberDao;
	
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public ModelAndView deleteMember(
			@RequestParam(value="user_id",required=true)int user_id,
			@RequestParam(value="pageNumber",required=false) String pageNumber,
			@RequestParam(value="whatColumn",required=false) String whatColumn,
			@RequestParam(value="keyword",required=false) String keyword
			) {
		
		ModelAndView mav = new ModelAndView();
		int cnt = -1;
		cnt = memberDao.deleteMember(user_id); 
		System.out.println("cnt "+ cnt);
		//memberDao.deleteMember(user_id); 
		
		mav.addObject("pageNumber",pageNumber);
		mav.addObject("whatColumn",whatColumn);
		mav.addObject("keyword",keyword);
		mav.setViewName(gotoPage);

return mav;
	}
}