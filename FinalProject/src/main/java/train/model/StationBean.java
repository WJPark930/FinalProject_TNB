package train.model;

public class StationBean {
	
	private String station_id;
	private String station_name;
	private int city_id;
	
	public StationBean() {
		
	}
	public StationBean(String station_id, String station_name, int city_id) {
		super();
		this.station_id = station_id;
		this.station_name = station_name;
		this.city_id = city_id;
	}
	
	public String getStationId() {
		return station_id;
	}
	public void setStationId(String station_id) {
		this.station_id = station_id;
	}
	public String getStationName() {
		return station_name;
	}
	public void setStationName(String station_name) {
		this.station_name = station_name;
	}
	public int getCityId() {
		return city_id;
	}
	public void setCityId(int city_id) {
		this.city_id = city_id;
	}
}
