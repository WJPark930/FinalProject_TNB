package community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import community.model.BoardBean;
import community.model.BoardDao;
import utility.BoardPaging;



@Controller
public class BoardUpdateController {
	private final String command = "/update.bd";
	private final String getPage = "updateForm";
	private final String gotoPage = "redirect:/list.bd";
	
	@Autowired
	BoardDao bdao;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String updateBoard(	@RequestParam(value="bid", required = true) int bid,
			@RequestParam(value="pageNumber", required = true) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword,
			HttpSession session,Model model,HttpServletRequest request) {
		/*
		 * System.out.println(bid); System.out.println(pageNumber);
		 * System.out.println(whatColumn); System.out.println(keyword);
		 */
		ModelAndView mav = new ModelAndView();
	
		if(session.getAttribute("loginInfo") == null) {
			session.setAttribute("destination", "redirect:/update.bd?bid=" + bid);

			model.addAttribute("whatColumn" , whatColumn);
			model.addAttribute("keyword" , keyword);
			model.addAttribute("pageNumber" , pageNumber);
					
			return "redirect:/loginForm.mb";	
			
		}else {
			
			Map<String, String> map = new HashMap<String, String>();
	        map.put("whatColumn", whatColumn);
	        map.put("keyword", "%" + keyword + "%");

	        int totalCount = bdao.getArticleCount(map);
	        String url = request.getContextPath() + this.command;

	        BoardPaging pageInfo = new BoardPaging(pageNumber, null, totalCount, url, whatColumn, keyword);

	        List<BoardBean> BoardLists = bdao.getBoardList(map, pageInfo);
	        model.addAttribute("BoardLists", BoardLists);
	        model.addAttribute("pageInfo", pageInfo);
			
			BoardBean bb = bdao.getArticle(bid);
//			System.out.println("컨트롤러로 넘어오는 카테고리 : " + bb.getCate_id());
			model.addAttribute("board",bb);
			model.addAttribute("pageNumber",pageNumber);
			return getPage;
		}
	}
		
		@RequestMapping(value=command , method=RequestMethod.POST)
		public ModelAndView updateBoard(
				@ModelAttribute("board") @Valid BoardBean board, BindingResult result,
				@RequestParam("bid") int bid,
				@RequestParam("passwd") String passwd,
				@RequestParam("pageNumber") int pageNumber,
				@RequestParam("whatColumn") String whatColumn,
				@RequestParam("keyword") String keyword
				) {
			
			ModelAndView mav = new ModelAndView();
			if(result.hasErrors()) {
				mav.setViewName(getPage);
				return mav;
			}
			int cnt = -1;
			cnt = bdao.updateBoard(bid,passwd,board);
			if(cnt != -1) { 
				board.setCreated_at(board.getUpdated_at());
				mav.setViewName(gotoPage);
			}
			mav.addObject("pageNumber", pageNumber);
			mav.addObject("whatColumn", whatColumn);
			mav.addObject("keyword", keyword);
			return mav;
		}
	}