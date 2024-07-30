package payment.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PaymentDao {
	private String namespace = "payment.model.Payment";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int paymentInsert(PaymentBean pb) {
		// TODO Auto-generated method stub
		int cnt = -1;
		
		System.out.println("여기 나오나?paymentDao pb.getcouponnum() : " + pb.getCoupon_num());
//		System.out.println("paymentDao pb.getpointAmount() : " + pb.getPoint_amount());
		cnt = sqlSessionTemplate.insert(namespace + ".paymentInsert", pb);
		return cnt;
	}

	public List<PaymentBean> getPaymentListByUserId(int user_id) {
		// TODO Auto-generated method stub
		List<PaymentBean> paymentList = new ArrayList<PaymentBean>();
		paymentList = sqlSessionTemplate.selectList(namespace + ".getPaymentListByUserId", user_id);
		return paymentList;
	}

	public PaymentBean getThisPayment(int order_num) {
		// TODO Auto-generated method stub
		PaymentBean pb = null;
		pb = sqlSessionTemplate.selectOne(namespace + ".getThisPayment", order_num);
		return pb;
	}

	public int insertTid(PaymentBean pb) {
		// TODO Auto-generated method stub
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".insertTid", pb);
		return cnt;
	}

	public int cancelThisPayment(PaymentBean pb) {
		// TODO Auto-generated method stub
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace +".cancelThisPayment", pb);
		return cnt;
	}


}
