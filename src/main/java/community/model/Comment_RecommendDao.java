 package community.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map; 

@Component
public class Comment_RecommendDao {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    private String namespace = "community.model.Comment";

    public int insertRecommend(Comment_RecommendBean crBean) {
        return sqlSessionTemplate.insert(namespace + ".insertRecommend", crBean);
    }

    public int getRecommendCount(int comment_id) {
        return sqlSessionTemplate.selectOne(namespace + ".getRecommendCount", comment_id);
    }

    public int checkUserRecommend(int comment_id, int user_id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("comment_id", comment_id);
        params.put("user_id", user_id);
        return sqlSessionTemplate.selectOne(namespace + ".checkUserRecommend", params);
    }


}
