package community.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import community.model.Nested_Comment_RecommendBean;
import community.model.Nested_Comment_RecommendDao;
import member.model.MemberBean;

@Controller
@RequestMapping("/nested_comment")
public class BoardNested_CommentRecommendController {

    @Autowired
    Nested_Comment_RecommendDao ncDao;

    @PostMapping(value = "/nestedcommentrecommend.bd")
    @ResponseBody
    public ResponseEntity<Integer> recommendNestedComment(@RequestParam("nested_comment_id") int nested_comment_id, HttpSession session) {
        MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
        if (loginInfo == null) {
            return ResponseEntity.status(401).body(null); // 로그인 필요
        }
        
//        System.out.println("대댓글 추천누르면 넘어오는 login정보 : " + loginInfo.getUser_id());
//        System.out.println("대댓글 추천 누르면 넘어오는 대댓글 정보 : " + nested_comment_id);
        
        int user_id = loginInfo.getUser_id();
        Nested_Comment_RecommendBean ncBean = new Nested_Comment_RecommendBean(user_id,nested_comment_id);

        // 사용자가 이미 해당 댓글을 추천했는지 체크
        int userRecommendCheck = ncDao.checkUserRecommend(user_id , nested_comment_id);
        if (userRecommendCheck > 0) {
            return ResponseEntity.status(409).body(null); // 이미 추천한 댓글
        }

        // 댓글 추천 정보 삽입
        int cnt = ncDao.insertRecommend(ncBean);
        if (cnt != -1) {
            // 추천 수 조회 및 반환
            int recommendCount = ncDao.getRecommendCount(nested_comment_id);
            return ResponseEntity.ok(recommendCount);
        } else {
            return ResponseEntity.status(500).body(null);
        }
    }
    
    @GetMapping(value = "/getRecommendCount.bd") //대댓글 추천수 가져오는 요청
    @ResponseBody
    public ResponseEntity<Integer> getRecommendCount(@RequestParam("nested_comment_id") int nested_comment_id) {
        try {
            int recommendCount = ncDao.getRecommendCount(nested_comment_id);
            return ResponseEntity.ok(recommendCount);
        } catch (NumberFormatException e) {
            return ResponseEntity.status(400).body(0);// 잘못된 댓글 ID
        }
    }
}