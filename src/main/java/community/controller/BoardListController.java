package community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import community.model.BoardBean;
import community.model.BoardDao;
import utility.BoardPaging;

@Controller
public class BoardListController {
    private final String command = "/list.bd";
    private final String getPage = "CommunityMain";
    
    @Autowired
    BoardDao bdao;
     
    @RequestMapping(command)
    public String list(@RequestParam(value="whatColumn", required=false) String whatColumn,
                       @RequestParam(value="keyword", required=false) String keyword,
                       @RequestParam(value="pageNumber", required=false) String pageNumber,
                       HttpServletRequest request,
                       Model model) {
        
        Map<String, String> map = new HashMap<String, String>();
        map.put("whatColumn", whatColumn);
        map.put("keyword", (keyword != null && !keyword.isEmpty()) ? "%" + keyword + "%" : null);
        
        int totalCount = bdao.getArticleCount(map);
        String url = request.getContextPath() + this.command;
        
        BoardPaging pageInfo = new BoardPaging(pageNumber, null, totalCount, url, whatColumn, keyword);
        
        List<BoardBean> BoardLists = bdao.getBoardList(map, pageInfo);
        model.addAttribute("BoardLists", BoardLists);
        model.addAttribute("pageInfo", pageInfo); 
        
        return getPage;
    }
    
    @RequestMapping("/filterByCategory.bd")
    @ResponseBody
    public Map<String, Object> filterByCategory(@RequestParam(value = "cate_id", required = false, defaultValue = "1") int cateId,
                                                @RequestParam(value = "pageNumber", required = false, defaultValue = "1") int pageNumber,
                                                @RequestParam(value = "whatColumn", required = false) String whatColumn,
                                                @RequestParam(value = "keyword", required = false) String keyword,
                                                HttpServletRequest request) {
        Map<String, Object> response = new HashMap<String, Object>();

        String searchKeyword = (keyword != null && !keyword.isEmpty()) ? "%" + keyword + "%" : null;

        System.out.println("넘어오는 cate_id : " + cateId);
        System.out.println("넘어오는 whatColumn : " +whatColumn);
        System.out.println("넘어오는 keyword : " + keyword);
        System.out.println("넘어오는 pageNumber : " + pageNumber);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("cate_id", cateId);
        map.put("whatColumn", whatColumn);
        map.put("keyword", searchKeyword);

        int totalCount = bdao.getCategoryArticleCount(map);

        String url = request.getContextPath() + "/filterByCategory.bd?cate_id=" + cateId;
        BoardPaging pageInfo = new BoardPaging(String.valueOf(pageNumber), null, totalCount, url, whatColumn, keyword);

        List<BoardBean> boardList = bdao.getBoardsByCategory(map, pageInfo);

        response.put("BoardLists", boardList);
        response.put("pageInfo", pageInfo);

        return response;
    }


    @RequestMapping("/topReadCountBoards.bd")
    @ResponseBody
    public List<BoardBean> getTopReadCountBoards() {
        return bdao.getTopReadCountBoards();
    }
}
