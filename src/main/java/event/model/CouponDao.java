package event.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CouponDao {
	private String namespace = "event.model.Event";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int getThisCoupon(CouponBean cb) {
		// TODO Auto-generated method stub
		int cnt = -1;
		System.out.println("cb.getUser_id : " + cb.getUser_id());
		System.out.println("cb.getKind() : " + cb.getKind());
		System.out.println("cb.getAmount() : " + cb.getAmount());
		cnt = sqlSessionTemplate.insert(namespace + ".getThisCoupon", cb);
		return cnt;
	}

	public List<CouponBean> showAllMyCoupon(int user_id) {
		// TODO Auto-generated method stub
		List<CouponBean> couponList = new ArrayList<CouponBean>();
		couponList = sqlSessionTemplate.selectList(namespace + ".showAllMyCoupon", user_id);
		System.out.println("couponList.size() : " + couponList.size());
		return couponList;
	}

	public boolean didIGetCoupon(CouponBean coupon) {
		// TODO Auto-generated method stub
		boolean flag = false;
		CouponBean cb = null;
		cb = sqlSessionTemplate.selectOne(namespace + ".didIGetCoupon", coupon);
		if(cb != null) {
			flag = true;
		}
		return flag;
	}
	
	public List<CouponBean> showCanUseCoupon(int user_id) {
		// TODO Auto-generated method stub
		List<CouponBean> couponList = new ArrayList<CouponBean>();
		couponList = sqlSessionTemplate.selectList(namespace + ".showCanUseCoupon", user_id);
		System.out.println("couponList.size() : " + couponList.size());
		return couponList;
	}


	public List<CouponBean> showAllMyCouponWithEventInfo_CanUse(int user_id) {
		// TODO Auto-generated method stub
		List<CouponBean> couponListCanUse = new ArrayList<CouponBean>();
		couponListCanUse = sqlSessionTemplate.selectList(namespace + ".showAllMyCouponWithEventInfo_CanUse", user_id);
		return couponListCanUse;
	}
	
	public List<CouponBean> showAllMyCouponWithEventInfo_Used(int user_id) {
		// TODO Auto-generated method stub
		List<CouponBean> couponListCannotUse = new ArrayList<CouponBean>();
		couponListCannotUse = sqlSessionTemplate.selectList(namespace + ".showAllMyCouponWithEventInfo_Used", user_id);
		return couponListCannotUse;
	}

	public List<CouponBean> showAllMyCouponWithEventInfo_Expired(int user_id) {
		// TODO Auto-generated method stub
		List<CouponBean> couponListExpired = new ArrayList<CouponBean>();
		couponListExpired = sqlSessionTemplate.selectList(namespace + ".showAllMyCouponWithEventInfo_Expired", user_id);
		return couponListExpired;
	}

	public List<CouponBean> showAllMyCouponWithEventInfo(int user_id) {
		// TODO Auto-generated method stub
		List<CouponBean> couponAll = new ArrayList<CouponBean>();
		couponAll = sqlSessionTemplate.selectList(namespace + ".showAllMyCouponWithEventInfo", user_id);
		return couponAll;
	}
}
