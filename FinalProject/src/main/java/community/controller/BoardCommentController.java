package community.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import community.model.CommentBean;
import community.model.CommentDao;
import community.model.Comment_RecommendDao;
import member.model.MemberBean;

@RestController
@RequestMapping("/comment")
public class BoardCommentController {

    @Autowired
    private CommentDao commentDao;

    @Autowired
    private Comment_RecommendDao crDao;

    @PostMapping("/add.bd")
    public CommentBean addComment(
            @RequestParam("bid") int boardId,
            @RequestParam("content") String content,
            @RequestParam("userId") String userId) {

        CommentBean newComment = new CommentBean();
        newComment.setBoard_id(boardId);
        newComment.setContent(content);
        newComment.setUser_id(Integer.parseInt(userId));
        newComment.setCreated_at(new Date());
        newComment.setUpdated_at(new Date());

        commentDao.addComment(newComment);

        // 추가된 댓글 객체를 클라이언트로 반환
        return newComment;
    }

    @GetMapping("/list.bd")
    public ResponseEntity<List<Map<String, Object>>> getComments(@RequestParam("bid") int boardId) {
        // 특정 게시글(boardId)에 대한 댓글 목록을 가져옴
        List<CommentBean> comments = commentDao.getCommentsByBoardId(boardId);

        // 각 댓글의 추천 수를 가져와서 Map 형태로 반환
        List<Map<String, Object>> commentsWithRecommendCount = new ArrayList<Map<String, Object>>();
        for (CommentBean comment : comments) {
            int recommendCount = crDao.getRecommendCount(comment.getId());

            Map<String, Object> commentMap = new HashMap<String, Object>();
            commentMap.put("id", comment.getId());
            commentMap.put("content", comment.getContent());
            commentMap.put("user_email", comment.getUser_email());
            commentMap.put("created_at", comment.getCreated_at());
            commentMap.put("updated_at", comment.getUpdated_at());
            commentMap.put("recommend_count", recommendCount);

            commentsWithRecommendCount.add(commentMap);
        }

        // 댓글 목록과 각 댓글의 추천 수를 ResponseEntity로 반환
        return ResponseEntity.ok().body(commentsWithRecommendCount);
    }
    
    @PostMapping("/delete.bd")
    @ResponseBody
    public ResponseEntity<String> deleteComment(@RequestParam("comment_id") int commentId,
                                                HttpSession session) {
        // 로그인 정보 가져오기
        MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
        if (loginInfo == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        // 댓글 작성자의 user_id 가져오기
        int CommentUserId = commentDao.getCommentUserId(commentId);

        // 현재 로그인한 사용자의 user_id
        int currentUserId = loginInfo.getUser_id();
        String AdminId = loginInfo.getUser_email();
  
        // 권한 확인(댓글 작성자가 현재 로그인 세션정보의 아이디와 댓글 작성자 아이디와 일치하거나, 관리자(admin)일 때만 삭제 가능하도록 구현
        if (currentUserId == CommentUserId || AdminId.equals("admin")) {
            // 삭제 로직 수행
            int deleteResult = commentDao.deleteComment(commentId);
            if (deleteResult > 0) {
                return ResponseEntity.ok("댓글이 삭제되었습니다.");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("댓글 삭제에 실패했습니다.");
            }
        } else {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("댓글 작성자만 삭제할 수 있습니다.");
        }
    }
}