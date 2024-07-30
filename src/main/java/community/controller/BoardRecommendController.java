package community.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import community.model.Board_RecommendBean;
import community.model.Board_RecommendDao;
import member.model.MemberBean;

@Controller
public class BoardRecommendController {
	private final String command = "/recommend.bd";
	
	@Autowired
	Board_RecommendDao rdao;
	
	@PostMapping(value = command)
	@ResponseBody
	public ResponseEntity<String> doAction(@RequestParam("bid") int bid,
	                                       HttpSession session) {
	    MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
	    if (loginInfo == null) {
	        return ResponseEntity.status(401).body("로그인이 필요합니다.");
	    }

	    int user_id = loginInfo.getUser_id();
	    Board_RecommendBean recommendBean = new Board_RecommendBean(user_id, bid);

//	    System.out.println("User ID: " + user_id + ", BID: " + bid); 

	    int userRecommendCheck = rdao.checkUserRecommend(recommendBean);
	    if (userRecommendCheck > 0) {
	        return ResponseEntity.status(409).body("이미 추천한 게시물입니다.");
	    }

	    int cnt = rdao.insertRecommend(recommendBean);
	    if (cnt != -1) {
	        int recommendCount = rdao.getRecommendCount(bid);
//	        System.out.println("Recommend Count: " + recommendCount); 
	        return ResponseEntity.ok(String.valueOf(recommendCount));
	    } else {
//	        System.out.println("추천 실패");
	        return ResponseEntity.status(500).body("추천 실패");
	    }
	}

    @RequestMapping(value = "/getRecommendCount.bd", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<Integer> getRecommendCount(@RequestParam("bid") int bid) {
        int recommendCount = rdao.getRecommendCount(bid);
        return ResponseEntity.ok(recommendCount);
    }
}