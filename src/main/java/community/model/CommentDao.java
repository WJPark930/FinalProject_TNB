package community.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CommentDao {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    private String namespace = "community.model.Comment";

    public int addComment(CommentBean comment) {
        return sqlSessionTemplate.insert(namespace + ".insertComment", comment);
    }

    public List<CommentBean> getCommentsByBoardId(int boardId) {
        return sqlSessionTemplate.selectList(namespace + ".getCommentsByBoardId", boardId);
    }

    public int deleteComment(int commentId) {
        return sqlSessionTemplate.delete(namespace + ".deleteComment", commentId);
    }

	public int getCommentUserId(int commentId) {
		return sqlSessionTemplate.selectOne(namespace + ".getCommentUserId", commentId);
	}
}
