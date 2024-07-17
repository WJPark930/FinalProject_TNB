package shop.model;

public class SearchBean {
	
	private String keyword;
	private String day1;
	private String day2;
	private String people;
	private int category_id;
	private int price;
	private int price_range;
	private String service;
	private String[] service_arr;
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getDay1() {
		return day1;
	}
	public void setDay1(String day1) {
		this.day1 = day1;
	}
	public String getDay2() {
		return day2;
	}
	public void setDay2(String day2) {
		this.day2 = day2;
	}
	public String getPeople() {
		return people;
	}
	public void setPeople(String people) {
		this.people = people;
	}
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getService() {
		return service;
	}
	public void setService(String service) {
		this.service = service;
	}
	public String[] getService_arr() {
		return service_arr;
	}
	public void setService_arr(String[] service_arr) {
		this.service_arr = service_arr;
	}
	public int getPrice_range() {
		return price_range;
	}
	public void setPrice_range(int price_range) {
		this.price_range = price_range;
	}
	
	
	

}
