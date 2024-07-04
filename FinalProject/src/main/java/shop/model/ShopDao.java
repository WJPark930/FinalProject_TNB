package shop.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("myShopDao")
public class ShopDao {
	
	private String namespace = "shop.model.Shop";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<ShopBean> search_shop(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
		List<ShopBean> lists = new ArrayList<ShopBean>();
		lists = sqlSessionTemplate.selectList(namespace+".search_shop",map,rowBounds);

		return  lists;
	}
	

}
