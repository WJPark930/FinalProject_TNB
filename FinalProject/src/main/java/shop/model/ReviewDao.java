package shop.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("myReviewDao")
public class ReviewDao {
	
	private String namespace = "shop.model.Review";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public List<ReviewBean> getShopReview(String shop_id) {
		List<ReviewBean> lists = new ArrayList<ReviewBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getShopReview",shop_id);
		return  lists;
	}

	public List<ReviewBean> getShopReviewImage(String shop_id) {
		List<ReviewBean> lists = new ArrayList<ReviewBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getShopReviewImage",shop_id);
		return  lists;
	}

	public void reviewLike(Map<String, String> map) {
		int cnt = -1;
		cnt += sqlSessionTemplate.insert(namespace+".reviewLike",map);
		cnt += sqlSessionTemplate.update(namespace+".reviewRecommendUp",map);
		if(cnt>0) {
			System.out.println("성공");
		}
	}

	public void reviewUnlike(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace+".reviewUnlike",map);
		cnt += sqlSessionTemplate.update(namespace+".reviewRecommendDown",map);
		if(cnt>0) {
			System.out.println("성공");
		}
	}

	public List<ReviewBean> getRecommendUser(String user_id) {
		List<ReviewBean> lists = new ArrayList<ReviewBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getRecommendUser",user_id);
		return  lists;
	}

	public List<ReviewBean> getMyReview(String user_id) {
		List<ReviewBean> lists = new ArrayList<ReviewBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getMyReview",user_id);
		return  lists;
	}
	
}
