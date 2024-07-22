package train.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("TrainReservationDao")
public class TrainReservationDao {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    private final String namespace = "train.model.TrainReservation";

	public void insertReservation(TrainReservationBean trainReservation) {
		sqlSessionTemplate.insert(namespace + ".insertReservation", trainReservation);
	}
}  