package reservation.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import payment.model.PaymentBean;
import shop.model.ReviewBean;

@Component
public class ReservationDao {
	
	private String namespace = "reservation.model.Reservation";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public ReservationBean getThisReservation(int order_num) {
		// TODO Auto-generated method stub
		ReservationBean rb = null;
		rb = sqlSessionTemplate.selectOne(namespace + ".getThisReservation", order_num);
		return rb;
	}

	public int roomreservation(RoomReservationBean rrb) {
		// TODO Auto-generated method stub
		int cnt = -1;
		System.out.println(rrb.getRoom_checkin_date());
		System.out.println(rrb.getRoom_checkout_date());
		System.out.println(rrb.getRoom_total_price());
		cnt = sqlSessionTemplate.insert(namespace + ".roomreservation", rrb);
		return cnt;
	}

	public int trainreservation(TrainReservationBean trb) {
		// TODO Auto-generated method stub
		System.out.println(trb.getDepPlandTime());
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".trainreservation", trb);
		return cnt;
	}

	public int updatePaymentStatus(int order_num) {
		// TODO Auto-generated method stub
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".updatePaymentStatus", order_num);
		return cnt;
	}
	
	public int updateFinalPrice(PaymentBean payFinal) {
	      // TODO Auto-generated method stub
	      int cnt = -1;
	      cnt = sqlSessionTemplate.update(namespace + ".updateFinalPrice", payFinal);
	      return cnt;
	   } 

	public List<ReservationBean> showAllMyReservationList(int user_id) {
		// TODO Auto-generated method stub
		List<ReservationBean> reservationList = new ArrayList<ReservationBean>();
		reservationList = sqlSessionTemplate.selectList(namespace + ".showAllMyReservationList", user_id);
		System.out.println("reservationList.size() : " + reservationList.size());
		return reservationList;
	}

	public RoomReservationBean getRecentReservation(int order_num) {
		// TODO Auto-generated method stub
		RoomReservationBean rrb = null;
		rrb = sqlSessionTemplate.selectOne(namespace + ".getRecentReservation", order_num);
		return rrb;
	}

	public List<ReservationBean> showAllMyReservationlistWithoutPay(int user_id) {
		// TODO Auto-generated method stub
		List<ReservationBean> reservationListNotDone = new ArrayList<ReservationBean>();
		reservationListNotDone = sqlSessionTemplate.selectList(namespace + ".showAllMyReservationlistWithoutPay", user_id);
		return reservationListNotDone;
	}

	public List<ReservationBean> showAllMyReservationlistCanceled(int user_id) {
		// TODO Auto-generated method stub
		List<ReservationBean> reservationCanceled = new ArrayList<ReservationBean>();
		reservationCanceled = sqlSessionTemplate.selectList(namespace + ".showAllMyReservationlistCanceled", user_id);
		return reservationCanceled;
	}

	public int updateRefund_status(PaymentBean pb) {
		// TODO Auto-generated method stub
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".updateRefund_status", pb);
		return cnt;
	}

	public ReservationBean showDetailPayment(int order_num) {
		// TODO Auto-generated method stub
		ReservationBean rb = null;
		rb = sqlSessionTemplate.selectOne(namespace + ".showDetailPayment", order_num);
		return rb;
	}

	public ReviewBean getReviewById(int order_num) {
		ReviewBean review = new ReviewBean();
		review = sqlSessionTemplate.selectOne(namespace + ".getReviewById", order_num);
		return review;
	} 
	
}
