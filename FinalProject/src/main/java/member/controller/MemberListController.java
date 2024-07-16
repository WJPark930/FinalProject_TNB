package member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;
import utility.BoardPaging;

@Controller
public class MemberListController {
	private final String command = "/list.mb";
	private final String getPage = "MemberList";
	
	@Autowired
	MemberDao memberDao;
	
	// loginForm.jsp에서 회원 목록보기
	@RequestMapping(command)
	public String list(
			@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="pageNumber", required=false) String pageNumber,
			HttpServletRequest request,
			Model model) {
		System.out.println("ProductListController");
		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");

		int totalCount = memberDao.getTotalCount(map); 
		String url = request.getContextPath() + this.command;

		BoardPaging pageInfo = new BoardPaging(pageNumber, null, totalCount, url, whatColumn, keyword);

		List<MemberBean> memberLists = memberDao.getMemberList(map, pageInfo);
		model.addAttribute("memberLists", memberLists);
		model.addAttribute("pageInfo", pageInfo);

		return getPage;
	}
}