package community.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Nested_CommentDao {
    
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    private String namespace = "community.model.Nested_Comment";

    public void insertNestedComment(Nested_CommentBean nestedComment) {
        sqlSessionTemplate.insert(namespace + ".InsertNestedComment", nestedComment);
    }

    public List<Nested_CommentBean> selectNestedCommentsByCommentId(int commentId) {
        return sqlSessionTemplate.selectList(namespace + ".SelectNestedCommentsByCommentId", commentId);
    }

    public int deleteNestedComment(int commentId) {
       return sqlSessionTemplate.delete(namespace + ".deleteNestedComment", commentId);
    }

	public int getNestedCommentUserId(int commentId) {
		return sqlSessionTemplate.selectOne(namespace + ".getNestedCommentUserId" , commentId);
	}
}
