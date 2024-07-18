package community.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import community.model.Nested_CommentBean;
import community.model.Nested_CommentDao;
import member.model.MemberBean;

@Controller
@RequestMapping("/nested_comment")
public class BoardNested_CommentController {

    @Autowired
    private Nested_CommentDao nestedCommentDao;

    @PostMapping("/add.bd")
    @ResponseBody
    public ResponseEntity<?> addNestedComment(
            @RequestParam("content") String content,
            @RequestParam("parent_id") int parent_id,
            @RequestParam("user_id") int user_id,
            HttpSession session) {
        Logger logger = LoggerFactory.getLogger(this.getClass());
        MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
        if (loginInfo == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        Nested_CommentBean nestedComment = new Nested_CommentBean();
        nestedComment.setUser_id(user_id);
        nestedComment.setContent(content);
        nestedComment.setComment_id(parent_id);
        nestedComment.setCreated_at(new Date());
        nestedComment.setUpdated_at(new Date());

        try {
            nestedCommentDao.insertNestedComment(nestedComment);
            return ResponseEntity.ok("대댓글이 성공적으로 작성되었습니다.");
        } catch (Exception e) {
            logger.error("대댓글 작성 중 오류 발생: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("대댓글 작성에 실패했습니다.");
        }
    }

    @GetMapping("/list.bd")
    @ResponseBody
    public ResponseEntity<?> listNestedComments(@RequestParam("parent_id") int parent_id) {
        Logger logger = LoggerFactory.getLogger(this.getClass());
        try {
            List<Nested_CommentBean> nestedComments = nestedCommentDao.selectNestedCommentsByCommentId(parent_id);
            return ResponseEntity.ok(nestedComments);
        } catch (Exception e) {
            logger.error("대댓글 목록 조회 중 오류 발생: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("대댓글 목록 조회에 실패했습니다.");
        }
    }
    
    
    @PostMapping("/delete.bd") //deleteMapping 사용!
    @ResponseBody
    public ResponseEntity<String> deleteComment(@RequestParam("commentId") int commentId,
                                                HttpSession session) {
//      System.out.println("넘어오는 대댓글 id : " + commentId);
        // 로그인 정보 가져오기
        MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
        if (loginInfo == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        // 대댓글 작성자의 user_id 가져오기
        int NestedCommentUserId = nestedCommentDao.getNestedCommentUserId(commentId);

        // 현재 로그인한 사용자의 user_id
        int currentUserId = loginInfo.getUser_id();
        
        String AdminId = loginInfo.getUser_email();
        
     // 권한 확인(대댓글 작성자가 현재 로그인 세션정보의 아이디와 대댓글 작성자 아이디와 일치하거나, 관리자(admin)일 때만 삭제 가능하도록 구현
        if (currentUserId == NestedCommentUserId || AdminId.equals("admin")) {
            // 삭제 로직 수행
            int deleteResult = nestedCommentDao.deleteNestedComment(commentId);
            if (deleteResult > 0) {
                return ResponseEntity.ok("대댓글이 삭제되었습니다.");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("댓글 삭제에 실패했습니다.");
            }
        } else {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("댓글 작성자만 삭제할 수 있습니다.");
        }
    }

}