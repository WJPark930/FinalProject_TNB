package community.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Board_RecommendDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "community.model.Board";
	
	public int insertRecommend(Board_RecommendBean recommendBean) {
		return sqlSessionTemplate.insert(namespace + ".insertRecommend", recommendBean);
	}
	
	public int getRecommendCount(int bid) {
		return sqlSessionTemplate.selectOne(namespace + ".getRecommendCount", bid);
	}
	
	public int checkUserRecommend(Board_RecommendBean recommendBean) {
		return sqlSessionTemplate.selectOne(namespace + ".checkUserRecommend", recommendBean);
	}
}
