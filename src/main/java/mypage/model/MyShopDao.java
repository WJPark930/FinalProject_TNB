package mypage.model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import shop.model.GuideBean;
import shop.model.ReviewBean;
import shop.model.ShopBean;
import shop.model.ShopRoomBean;

@Component("mypageShopDao")
public class MyShopDao {
	
	private String namespace = "mypage.model.ShopMy";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public List<ShopBean> getMyShop(int user_id) {
		List<ShopBean> lists = new ArrayList<ShopBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getMyShop",user_id);
		return  lists;
	}

	public List<ShopRoomBean> getMyShopRoom(String shop_id) {
		List<ShopRoomBean> lists = new ArrayList<ShopRoomBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getMyShopRoom",shop_id);
		return  lists;
	}

	public int insertShop(ShopBean shop, List<GuideBean> list_guide) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace+".insertShop",shop);

		// 2. 생성한 shop 테이블의 shop_id를 가져온다
		int shop_id = sqlSessionTemplate.selectOne(namespace+".getShopId");
		int shop_img_id = sqlSessionTemplate.selectOne(namespace+".getShopImageId",shop_id);
		
		// 2-1. 이미지 테이블에 이미지 추가
		List<ShopBean> list_image = new ArrayList<ShopBean>();
		for(int i=0;i<shop.getUpload().length;i++) { // image_name[] 대신 갯수가 정해진 getUpload 사용
			ShopBean sb = new ShopBean();
			sb.setImage(shop.getImage_name()[i]);
			sb.setShop_id(shop_id);
			sb.setShop_img_id(shop_img_id);
			list_image.add(sb);
			shop_img_id++;
		}		
		sqlSessionTemplate.insert(namespace+".insertShopImage",list_image);
		
		// 2-2. 시설정보 테이블에 시설정보 추가
		if(list_guide.size()>0) {
			int guide_id = sqlSessionTemplate.selectOne(namespace+".getShopGuideId",shop_id);
			for(GuideBean gb : list_guide){
				gb.setGuide_id(guide_id);
				gb.setShop_id(shop_id);	
				guide_id++;
			}
			sqlSessionTemplate.insert(namespace+".insertShopGuide",list_guide);
		}
		
		// 2-3. 서비스 테이블에 서비스 추가
		String[] serviceFull = shop.getService_name().split(",");
		List<ShopBean> list_service = new ArrayList<ShopBean>();
		for(String service : serviceFull) {
			service = service.substring(0,service.indexOf("_"));
			ShopBean sb_service = new ShopBean();
			sb_service.setService_id(Integer.parseInt(service));
			sb_service.setShop_id(shop_id);
			
			list_service.add(sb_service);
		}
		sqlSessionTemplate.insert(namespace+".insertShopService",list_service);
		
		return cnt;
	}

	public int deleteShop(String shop_id) {
		int cnt =-1;
		cnt = sqlSessionTemplate.delete(namespace+".deleteShop",shop_id);	
		return cnt;
	}

	public List<ShopBean> getShopImage(String shop_id) {
		List<ShopBean> lists = new ArrayList<ShopBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getShopImage",shop_id);
		return  lists;
	}

	public void deleteShopImage(ShopBean image) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace+".deleteShopImage",image);
		if(cnt<=0) {
			System.out.println("삭제실패");
		}		
		
	}

	public int updateShop(ShopBean shop, List<GuideBean> list_guide, List<GuideBean> save_guide) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace+".updateShop",shop);
		int shop_id = shop.getShop_id();
		
		// 2. 이미지 테이블에 이미지 추가
		int shop_img_id = sqlSessionTemplate.selectOne(namespace+".getShopImageId",shop_id);
		List<ShopBean> list_image = new ArrayList<ShopBean>();
		if(shop.getUpload()!=null) {
			for(int i=0;i<shop.getUpload().length;i++) { // image_name[] 대신 갯수가 정해진 getUpload 사용
				ShopBean sb = new ShopBean();
				sb.setImage(shop.getImage_name()[i]);
				sb.setShop_id(shop.getShop_id());
				sb.setShop_img_id(shop_img_id);
				list_image.add(sb);
				shop_img_id++;
			}		
			sqlSessionTemplate.insert(namespace+".insertShopImage",list_image);			
		}
		
		// 3. 시설정보 테이블에 시설정보 추가
		List<GuideBean> insert_guide = new ArrayList<GuideBean>();
		int guide_id = sqlSessionTemplate.selectOne(namespace+".getShopGuideId",shop_id);
		for(GuideBean save_gb : save_guide) {
			boolean flag = false;
			if(list_guide != null ) {
				for(GuideBean gb : list_guide){
					if(gb.getGuide_id() == save_gb.getGuide_id()) {
						//System.out.println("###수정 dao id"+save_gb.getGuide_id());
						gb.setGuide_id(save_gb.getGuide_id());
						gb.setShop_id(shop_id);
						sqlSessionTemplate.update(namespace+".updateShopGuide",gb);
						flag =true;
					}
				}				
			}
			if(flag == false) {
				//System.out.println("###삭제 dao id"+save_gb.getGuide_id());
				sqlSessionTemplate.delete(namespace+".deleteShopGuide",save_gb);
			}
		}
		if(list_guide != null ) {
			for(GuideBean gb : list_guide){
				if(gb.getGuide_id() < 1) {
					//System.out.println("###추가 dao id"+gb.getGuide_id());
					gb.setShop_id(shop.getShop_id());	
					gb.setGuide_id(guide_id);
					guide_id++;		
					insert_guide.add(gb);
				}
			}
		}
		if(insert_guide.size()>0) {
			sqlSessionTemplate.insert(namespace+".insertShopGuide",insert_guide);				
		}
		
		// 4. 서비스 테이블에 서비스 추가
		sqlSessionTemplate.delete(namespace+".resetService",shop_id); // 시설 서비스 초기화
		String[] serviceFull = shop.getService_name().split(",");
		List<ShopBean> list_service = new ArrayList<ShopBean>();
		for(String service : serviceFull) {
			service = service.substring(0,service.indexOf("_"));
			ShopBean sb_service = new ShopBean();
			sb_service.setService_id(Integer.parseInt(service));
			sb_service.setShop_id(shop.getShop_id());
			
			list_service.add(sb_service);
		}
		sqlSessionTemplate.insert(namespace+".insertShopService",list_service);
		
		return cnt;
	}

	public int insertRoom(ShopRoomBean room) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace+".insertRoom",room);

		// 2. room 이미지 넣기
		int room_id = sqlSessionTemplate.selectOne(namespace+".getRoomId",room);
		int room_img_id = sqlSessionTemplate.selectOne(namespace+".getRoomImageId",room);
		
		List<ShopRoomBean> list_image = new ArrayList<ShopRoomBean>();
		for(int i=0;i<room.getUpload().length;i++) { // image_name[] 대신 갯수가 정해진 getUpload 사용
			ShopRoomBean rb = new ShopRoomBean();
			rb.setImage(room.getImage_name()[i]);
			rb.setShop_id(room.getShop_id());
			rb.setRoom_id(room_id);
			rb.setRoom_img_id(room_img_id);
			list_image.add(rb);
			room_img_id++;
		}		
		sqlSessionTemplate.insert(namespace+".insertRoomImage",list_image);
		
		return cnt;
	}

	public List<ShopRoomBean> getOneRoomImage(Map<String, String> map) {
		List<ShopRoomBean> lists = new ArrayList<ShopRoomBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getOneRoomImage",map);
		return  lists;
	}

	public int deleteRoom(Map<String, String> map) {
		int cnt =-1;
		cnt = sqlSessionTemplate.delete(namespace+".deleteRoom",map);	
		return cnt;
	}

	public ShopRoomBean getOneRoom(Map<String, String> map) {
		ShopRoomBean srb = new ShopRoomBean();
		srb = sqlSessionTemplate.selectOne(namespace+".getOneRoom",map);
		return srb;
	}

	public void deleteRoomImage(ShopRoomBean image) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace+".deleteRoomImage",image);
		if(cnt<=0) {
			System.out.println("삭제실패");
		}		
	}

	public int updateRoom(ShopRoomBean room) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace+".updateRoom",room);
		
		// 2. room 이미지 넣기
		int room_img_id = sqlSessionTemplate.selectOne(namespace+".getRoomImageId",room);
		
		List<ShopRoomBean> list_image = new ArrayList<ShopRoomBean>();
		if(room.getUpload()!=null) {
			for(int i=0;i<room.getUpload().length;i++) { // image_name[] 대신 갯수가 정해진 getUpload 사용
				ShopRoomBean rb = new ShopRoomBean();
				rb.setImage(room.getImage_name()[i]);
				rb.setShop_id(room.getShop_id());
				rb.setRoom_id(room.getRoom_id());
				rb.setRoom_img_id(room_img_id);
				list_image.add(rb);
				room_img_id++;
			}		
			sqlSessionTemplate.insert(namespace+".insertRoomImage",list_image);
		}
		return cnt;
	}
	
	
	
}
