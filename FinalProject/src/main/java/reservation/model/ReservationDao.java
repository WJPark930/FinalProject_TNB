package reservation.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

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
		System.out.println(rrb.getPrice());
		cnt = sqlSessionTemplate.insert(namespace + ".roomreservation", rrb);
		return cnt;
	}

	public int trainreservation(TrainReservationBean trb) {
		// TODO Auto-generated method stub
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

	public List<ReservationBean> showAllMyReservationList(int user_id) {
		// TODO Auto-generated method stub
		List<ReservationBean> reservationList = new ArrayList<ReservationBean>();
		reservationList = sqlSessionTemplate.selectList(namespace + ".showAllMyReservationList", user_id);
		System.out.println("reservationList.size() : " + reservationList.size());
		return reservationList;
	}


	
}
