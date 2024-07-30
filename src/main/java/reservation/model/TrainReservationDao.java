package reservation.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TrainReservationDao {
	
	private String namespace = "reservation.model.Reservation";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int trainReservation(TrainReservationBean trb) {
		// TODO Auto-generated method stub
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".trainReservation", trb);
		return cnt;
	}

	public TrainReservationBean isReservationWithTrain(int room_reservation_num) {
		// TODO Auto-generated method stub
		TrainReservationBean trb = null;
		trb = sqlSessionTemplate.selectOne(namespace + ".isReservationWithTrain", room_reservation_num);
		return trb;
	}


}

