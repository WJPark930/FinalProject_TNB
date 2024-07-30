package community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import community.model.BoardBean;
import community.model.BoardDao;
import community.model.CommentDao;
import utility.BoardPaging;

@Controller
public class BoardContentController {
	private final String command = "/content.bd";
	private final String getPage = "detailView";

	@Autowired
	BoardDao bdao;

	@Autowired
	CommentDao cdao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String contentAndList(@RequestParam(value="bid") int num,
			@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="pageNumber", required=false) String pageNumber,
			HttpServletRequest request,
			HttpSession session,
			Model model) {

		if (session.getAttribute("loginInfo") == null) {
			session.setAttribute("destination", "redirect:/content.bd");
			return "redirect:/loginForm.mb";
		} else {
			//상세보기 가져오는 부분
			BoardBean bb = bdao.getArticle(num);

			model.addAttribute("content", bb);
			model.addAttribute("pageNumber", pageNumber);

			//상세보기에서 list표시하는 부분
			Map<String, String> map = new HashMap<String, String>();
			map.put("whatColumn", whatColumn);
			map.put("keyword", "%" + keyword + "%");

			int totalCount = bdao.getArticleCount(map);
			String url = request.getContextPath() + this.command;

			BoardPaging pageInfo = new BoardPaging(pageNumber, null, totalCount, url, whatColumn, keyword);

			List<BoardBean> BoardLists = bdao.getBoardList(map, pageInfo);
			model.addAttribute("BoardLists", BoardLists);
			model.addAttribute("pageInfo", pageInfo);

			return getPage;
		}
	}
}