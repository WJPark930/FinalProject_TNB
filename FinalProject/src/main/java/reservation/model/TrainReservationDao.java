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
		
		System.out.println(trb.getUser_id());
		System.out.println(trb.getTrain_no());
		System.out.println(trb.getTrainCode());//
		System.out.println(trb.getDepPlaceName());//
		System.out.println(trb.getArrPlaceName());//
		System.out.println(trb.getDepPlandTime());//
		System.out.println(trb.getArrPlandTime());//
		System.out.println(trb.getTotalTime());//
		System.out.println(trb.getNum_adult());
		System.out.println(trb.getNum_children());
		System.out.println(trb.getNum_seniors());
		System.out.println(trb.getSeat_no()); //
		System.out.println(trb.getTotal_price());
		System.out.println(trb.getTotal_charge());
		
		
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

