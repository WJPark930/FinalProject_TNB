package community.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import community.model.Comment_RecommendBean;
import community.model.Comment_RecommendDao;
import member.model.MemberBean;

@Controller
@RequestMapping("/comment")
public class BoardCommentRecommendController {

    @Autowired
    Comment_RecommendDao crDao;

    @PostMapping(value = "/commentrecommend.bd")
    @ResponseBody
    public ResponseEntity<Integer> recommendComment(@RequestParam("comment_id") String comment_id_str,
                                                    HttpSession session) {
        try {
            int comment_id = Integer.parseInt(comment_id_str);
            MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
            if (loginInfo == null) {
                return ResponseEntity.status(401).body(null); // 로그인 필요
            }

            int user_id = loginInfo.getUser_id();
            Comment_RecommendBean crBean = new Comment_RecommendBean(comment_id, user_id);

            // 사용자가 이미 해당 댓글을 추천했는지 체크
            int userRecommendCheck = crDao.checkUserRecommend(comment_id, user_id);
            if (userRecommendCheck > 0) {
                return ResponseEntity.status(409).body(null); // 이미 추천한 댓글
            }

            // 댓글 추천 정보 삽입
            int cnt = crDao.insertRecommend(crBean);
            if (cnt != -1) {
                // 추천 수 조회 및 반환
                int recommendCount = crDao.getRecommendCount(comment_id);
                return ResponseEntity.ok(recommendCount);
            } else {
                return ResponseEntity.status(500).body(null);
            }
        } catch (NumberFormatException e) {
            return ResponseEntity.status(400).body(null);// 잘못된 댓글 ID
        }
    }

    @GetMapping(value = "/getRecommendCount.bd")
    @ResponseBody
    public ResponseEntity<Integer> getRecommendCount(@RequestParam("comment_id") String comment_id_str) {
        try {
            int comment_id = Integer.parseInt(comment_id_str);
            int recommendCount = crDao.getRecommendCount(comment_id);
            return ResponseEntity.ok(recommendCount);
        } catch (NumberFormatException e) {
            return ResponseEntity.status(400).body(0);// 잘못된 댓글 ID
        }
    }
    
    
}