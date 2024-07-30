package shop.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;
import utility.Shop_Paging;

@Component("myShopDao")
public class ShopDao {

	private String namespace = "shop.model.Shop";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public List<ShopBean> search_shop(Shop_Paging pageInfo, Map<String, Object> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
		List<ShopBean> lists = new ArrayList<ShopBean>();
		lists = sqlSessionTemplate.selectList(namespace+".search_shop",map,rowBounds);
		return  lists;
	}

	public int search_count(Map<String, Object> map) {
		int cnt = 0;
		cnt = sqlSessionTemplate.selectOne(namespace+".search_count",map);
		return  cnt;
	}

	public List<SearchBean> getServiceList() {
		List<SearchBean> lists = new ArrayList<SearchBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getServiceList");
		return  lists;
	}

	public List<CategoryBean> getCategoryList() {
		List<CategoryBean> lists = new ArrayList<CategoryBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getCategoryList");
		return  lists;
	}

	public ShopBean getShopInfo(String shop_id) {
		ShopBean shop = sqlSessionTemplate.selectOne(namespace+".getShopInfo",shop_id);
		return shop;
	}

	public List<String> getShopImage(String shop_id) {
		List<String> lists = new ArrayList<String>();
		lists = sqlSessionTemplate.selectList(namespace+".getShopImage",shop_id);
		return  lists;
	}

	public List<ServiceBean> getShopService(String shop_id) {
		List<ServiceBean> lists = new ArrayList<ServiceBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getShopService",shop_id);
		return  lists;
	}

	public List<GuideBean> getShopGuide(String shop_id) {
		List<GuideBean> lists = new ArrayList<GuideBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getShopGuide",shop_id);
		return  lists;
	}

	public List<ShopRoomBean> getShopRoom(Map<String, Object> map) {
		List<ShopRoomBean> lists = new ArrayList<ShopRoomBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getShopRoom",map);
		return  lists;
	}

	public List<ShopRoomBean> getRoomImage(String shop_id) {
		List<ShopRoomBean> lists = new ArrayList<ShopRoomBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getRoomImage",shop_id);
		return  lists;
	}

	public List<String> getKeyword(String keyword) {
		List<String> lists = new ArrayList<String>(); 
		lists = sqlSessionTemplate.selectList(namespace+".getKeyword",keyword);
		return  lists;
	}

	public List<ShopBean> getShopByRegion(Map<String, Object> map) {
		RowBounds rowBounds = new RowBounds(0,8);
		List<ShopBean> lists = new ArrayList<ShopBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getShopByRegion",map,rowBounds);
		return  lists;
	}

	// 관리자 

	public int getTotalCount(Map<String, String> map) {
		int count =-1;
		count = sqlSessionTemplate.selectOne(namespace +".getTotalCount",map);
		System.out.println("totalCount : " +count);

		return count;
	}//getTotalCount

	public List<ShopBean> getShopList(Map<String, String> map, Paging pageInfo) {

		System.out.println(map.get("whatColumn"));
		System.out.println(map.get("keyword"));

		System.out.println("offset:" +pageInfo.getOffset()); // 현재 페이지에서 건너뛸 갯수
		System.out.println("limit:"+pageInfo.getLimit()); // 가지고있는 레코드수(가지고올 갯수)

		List<ShopBean>lists = new ArrayList<ShopBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
		lists = sqlSessionTemplate.selectList(namespace + ".getShopList",map,rowBounds);


		System.out.println("lists.size()" +lists.size());
		return lists;
	}//getProductList

	public ShopRoomBean getRoomInfo(ShopRoomBean srb) {
		// TODO Auto-generated method stub
		ShopRoomBean roomInfo = null;
		roomInfo = sqlSessionTemplate.selectOne(namespace + ".getRoomInfo", srb);
		return roomInfo;

	}

	public String getThisShopImage(String shop_id) {
		// TODO Auto-generated method stub
		String shopImage = null;
		shopImage = sqlSessionTemplate.selectOne(namespace + ".getThisShopImage", shop_id);
		return shopImage;
	}

	public String getThisRoomImage(ShopRoomBean srb) {
		// TODO Auto-generated method stub
		String roomImage = null;
		roomImage = sqlSessionTemplate.selectOne(namespace + ".getThisRoomImage", srb);
		return roomImage;
	}


}
