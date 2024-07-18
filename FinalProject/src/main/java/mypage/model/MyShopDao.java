package mypage.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import shop.model.ShopBean;
import shop.model.ShopRoomBean;

@Component("mypageShopDao")
public class MyShopDao {
	
	private String namespace = "mypage.model.ShopMy";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public List<ShopBean> getMyShop(int shop_id) {
		List<ShopBean> lists = new ArrayList<ShopBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getMyShop",shop_id);
		return  lists;
	}

	public List<ShopRoomBean> getMyShopRoom(String shop_id) {
		List<ShopRoomBean> lists = new ArrayList<ShopRoomBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getMyShopRoom",shop_id);
		return  lists;
	}
	
	
	
}
