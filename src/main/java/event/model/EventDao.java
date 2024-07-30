package event.model;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import payment.model.PaymentBean;

@Component
public class EventDao {
	private String namespace = "event.model.Event";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int eventInsert(EventBean eb) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".eventInsert", eb);
		return cnt;
	}

	public List<EventBean> eventList(Map<String, String> map) {
		// TODO Auto-generated method stub
		List<EventBean> eventList = new ArrayList<EventBean>();
		eventList = sqlSessionTemplate.selectList(namespace + ".eventList", map);
		System.out.println("eventList.size() : " + eventList.size());
		return eventList;
	}

	public EventBean eventDetail(int event_num) {
		// TODO Auto-generated method stub
		EventBean eb = null;
		eb = sqlSessionTemplate.selectOne(namespace + ".eventDetail", event_num);
		return eb;
	}

	public int eventDelete(int event_num) {
		// TODO Auto-generated method stub
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".eventDelete", event_num);
		return cnt;
	}

	public int eventUpdate(EventBean eb) {
		// TODO Auto-generated method stub
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".eventUpdate", eb);
		return cnt;
	}

	public int updateCouponUse_status_toYes(PaymentBean pb) {
		// TODO Auto-generated method stub
		System.out.println("결제 후 넘어오는 pb.getUser_id() : " + pb.getUser_id());
		System.out.println("결제 후 넘어오는 pb.getCoupon_num() : " + pb.getCoupon_num());
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".updateCouponUse_status_toYes", pb);
		return cnt;
	}
	
	public int updateCouponUse_status_toNo(PaymentBean pb) {
		// TODO Auto-generated method stub
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".updateCouponUse_status_toNo", pb);
		return cnt;
	}
	
}
