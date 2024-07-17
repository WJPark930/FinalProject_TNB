package community.model;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Nested_Comment_RecommendDao {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    private String namespace = "community.model.Nested_Comment";

    public int insertRecommend(Nested_Comment_RecommendBean ncBean) {
        return sqlSessionTemplate.insert(namespace + ".insertRecommend", ncBean);
    }

    public int getRecommendCount(int nested_comment_id) {
        return sqlSessionTemplate.selectOne(namespace + ".getRecommendCount", nested_comment_id);
    }

    public int checkUserRecommend(int user_id, int nested_comment_id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("user_id", user_id);
        params.put("nested_comment_id", nested_comment_id);
        return sqlSessionTemplate.selectOne(namespace + ".checkUserRecommend", params);
    }
}
