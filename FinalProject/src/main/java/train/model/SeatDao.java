package train.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("SeatDao")
public class SeatDao {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    private final String namespace = "train.model.Seat";
    
    public int getReservedSeatCountByScheduleId(String schedule_id) {
        return sqlSessionTemplate.selectOne(namespace + ".getReservedSeatCountByScheduleId", schedule_id);
    }
    
    public void insertSeat(SeatBean seat) {
        sqlSessionTemplate.insert(namespace + ".insertSeat", seat);
    }
    
    public List<SeatBean> getSeatsByScheduleId(String schedule_id) {
        return sqlSessionTemplate.selectList(namespace + ".getSeatsByScheduleId", schedule_id);
    }
}