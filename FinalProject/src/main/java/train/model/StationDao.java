package train.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("StationDao")
public class StationDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private final String namespace = "train.model.Station";
	
	public List<StationBean> getStationList() {
		return sqlSessionTemplate.selectList(namespace + ".getStationList");
	}

	public List<StationBean> getStationListByCityId(int city_id) {
		return sqlSessionTemplate.selectList(namespace + ".getStationListByCityId", city_id);
	}

	public String getStationName(String station_id) {
        return sqlSessionTemplate.selectOne(namespace + ".getStationName", station_id);
    }
	
	public StationBean getStationById(String station_id) {
        return sqlSessionTemplate.selectOne(namespace + ".getStationById", station_id);
    }

    public void insertStation(StationBean station) {
        sqlSessionTemplate.insert(namespace + ".insertStation", station);
    }
    
    public void insertFixedStations() {
    	// 서울특별시 (도시번호: 11)
    	insertIfNotExists(new StationBean("NAT010000", "서울", 11));
    	insertIfNotExists(new StationBean("NAT010032", "용산", 11));
    	insertIfNotExists(new StationBean("NAT130126", "청량리", 11));
    	insertIfNotExists(new StationBean("NATH30000", "수서", 11));

    	// 부산광역시 (도시번호: 21)
    	insertIfNotExists(new StationBean("NAT014445", "부산", 21));
    	insertIfNotExists(new StationBean("NAT014281", "구포", 21));

    	// 대구광역시 (도시번호: 22)
    	insertIfNotExists(new StationBean("NAT013189", "서대구", 22));
    	insertIfNotExists(new StationBean("NAT013271", "동대구", 22));
    	
    	// 광주광역시 (도시번호: 24)
    	insertIfNotExists(new StationBean("NAT031857", "광주송정", 24));

    	// 대전광역시 (도시번호: 25)
    	insertIfNotExists(new StationBean("NAT011668", "대전", 25));

    	// 울산광역시 (도시번호: 26)
    	insertIfNotExists(new StationBean("NATH13717", "울산(통도사)", 26));

    	// 경기도 (도시번호: 31)
    	insertIfNotExists(new StationBean("NATH10219", "광명", 31));
    	insertIfNotExists(new StationBean("NAT010415", "수원", 31));
    	insertIfNotExists(new StationBean("NATH30326", "동탄", 31));
    	insertIfNotExists(new StationBean("NAT110147", "행신", 31));

    	// 강원도 (도시번호: 32)
    	insertIfNotExists(new StationBean("NAT020947", "원주", 32));
    	insertIfNotExists(new StationBean("NAT601936", "강릉", 32));

    	// 충청북도 (도시번호: 33)
    	insertIfNotExists(new StationBean("NAT050044", "오송", 33));
    	insertIfNotExists(new StationBean("NAT050114", "청주", 33));

    	// 충청남도 (도시번호: 34)
    	insertIfNotExists(new StationBean("NATH10960", "천안아산", 34));
    	insertIfNotExists(new StationBean("NATH20438", "공주", 34));

    	// 전라북도 (도시번호: 35)
    	insertIfNotExists(new StationBean("NAT040257", "전주", 35));
    	insertIfNotExists(new StationBean("NAT030879", "익산", 35));

    	// 전라남도 (도시번호: 36)
    	insertIfNotExists(new StationBean("NAT041595", "순천", 36));
    	insertIfNotExists(new StationBean("NAT041993", "여수EXPO", 36));

    	// 경상북도 (도시번호: 37)
    	insertIfNotExists(new StationBean("NATH13421", "신경주", 37));
    	insertIfNotExists(new StationBean("NATH12383", "김천구미", 37));

    	// 경상남도 (도시번호: 38)
    	insertIfNotExists(new StationBean("NAT880281", "창원중앙", 38));
    	insertIfNotExists(new StationBean("NAT013841", "밀양", 38));
    	insertIfNotExists(new StationBean("NAT880345", "마산", 38));
    	insertIfNotExists(new StationBean("NAT881014", "진주", 38));
    }

    private void insertIfNotExists(StationBean station) {
        StationBean existingStation = getStationById(station.getStationId());
        if (existingStation == null) {
            insertStation(station);
        } else {
            if (!existingStation.getStationName().equals(station.getStationName()) ||
                existingStation.getCityId() != station.getCityId()) {
                insertStation(station);
            }
        }
    }
}
