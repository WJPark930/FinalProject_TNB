package train.model;

public class CityBean {
    private int city_id;
    private String city_name;

    public CityBean() {
    }

	public int getCityId() {
		return city_id;
	}

	public void setCityId(int city_id) {
		this.city_id = city_id;
	}

	public String getCityName() {
		return city_name;
	}

	public void setCityName(String city_name) {
		this.city_name = city_name;
	}
}