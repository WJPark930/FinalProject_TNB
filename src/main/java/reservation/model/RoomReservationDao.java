package reservation.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RoomReservationDao {

	private String namespace = "reservation.model.Reservation";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int roomReservation(RoomReservationBean rrb) {
		// TODO Auto-generated method stub
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".roomReservation", rrb);
		return cnt;
	}

	public RoomReservationBean getRecentReservation() {
		// TODO Auto-generated method stub
		RoomReservationBean rrb = null;
		rrb = sqlSessionTemplate.selectOne(namespace + ".getRecentReservation");
		return rrb;
	}

	public RoomReservationBean getThisRoomReservation(int order_num) {
		// TODO Auto-generated method stub
		RoomReservationBean rrb = null;
		rrb = sqlSessionTemplate.selectOne(namespace + ".getThisRoomReservation", order_num);
		return rrb;
	}




}
