package community.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Comu_CategoryDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "community.model.Board";
}
