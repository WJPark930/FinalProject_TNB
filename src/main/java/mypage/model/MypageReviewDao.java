package mypage.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import shop.model.ReviewBean;

@Component("myMypageReviewDao")
public class MypageReviewDao {

	private String namespace = "mypage.model.ReviewMy";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public RoomReservationBean getReservationById(String reservation_id) {
		RoomReservationBean reservation = sqlSessionTemplate.selectOne(namespace+".getReservationById",reservation_id);
		return  reservation;
	}

	public int insertReview(ReviewBean review) {
		int cnt = -1;
		// 리뷰 테이블 생성
		cnt = sqlSessionTemplate.insert(namespace+".insertReview",review);
		// 리뷰 이미지에 넣을 방금 생성한 리뷰 테이블 아이디
		int review_id = sqlSessionTemplate.selectOne(namespace+".getReviewId",review);
		int review_img_id = sqlSessionTemplate.selectOne(namespace+".getReviewImageId",review_id);
		
		// 리뷰 이미지 테이블 다중생성
		List<ReviewBean> list = new ArrayList<ReviewBean>();
		String[] review_arr = review.getImage().split(" /-/ ");
		for(String review_img : review_arr) {
			//System.out.println("review_id: "+review_id);
			//System.out.println("review_image_id: "+review_img_id);
			//System.out.println("review_img: "+review_img);
			ReviewBean rb = new ReviewBean();
			rb.setImage(review_img);
			rb.setReview_img_id(review_img_id); 
			rb.setReview_id(review_id);
			list.add(rb);
			review_img_id++;
		}
		sqlSessionTemplate.insert(namespace+".insertReviewImage",list);
		// shop 테이블의 리뷰수 와 평점 조절
		sqlSessionTemplate.update(namespace+".updateShopReviewUp",review);
		return cnt;
	}

	public List<ReviewBean> getReviewImageById(String review_id) {
		List<ReviewBean> lists = new ArrayList<ReviewBean>();
		lists = sqlSessionTemplate.selectList(namespace+".getReviewImageById",review_id);
		return  lists; 
	}

	public void deleteReview(String review_id) {
		int cnt = -1;
		ReviewBean rb = sqlSessionTemplate.selectOne(namespace+".getReviewById",review_id);
		cnt = sqlSessionTemplate.delete(namespace+".deleteReview",review_id);		
		if(cnt<=0) {
			System.out.println("삭제실패");
		}else {			
			sqlSessionTemplate.update(namespace+".updateShopReviewDown",rb.getShop_id());
		}
		
	}

	public ReviewBean getReviewById(String review_id) {
		ReviewBean rb = new ReviewBean();
		rb = sqlSessionTemplate.selectOne(namespace+".getReviewById",review_id);
		return rb;
	}

	public void deleteReviewImage(ReviewBean image) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace+".deleteReviewImage",image);
		if(cnt<=0) {
			System.out.println("삭제실패");
		}
		
	}

	public int updateReview(ReviewBean review) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace+".updateReview",review);
		if(review.getImage() != "") {
			int review_img_id = sqlSessionTemplate.selectOne(namespace+".getReviewImageId",review.getReview_id());
			List<ReviewBean> list = new ArrayList<ReviewBean>();
			String[] review_arr = review.getImage().split(" /-/ ");
			for(String review_img : review_arr) {
				//System.out.println("review_img: "+review_img);
				ReviewBean rb = new ReviewBean();
				rb.setImage(review_img);
				rb.setReview_img_id(review_img_id); 
				rb.setReview_id(review.getReview_id());
				list.add(rb);
				review_img_id++;
			}
			sqlSessionTemplate.insert(namespace+".insertReviewImage",list);			
		}
		
		sqlSessionTemplate.update(namespace+".updateShopReviewGrade",review);
		return cnt;
	}
	
	
}
