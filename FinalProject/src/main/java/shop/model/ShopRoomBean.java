package shop.model;

public class ShopRoomBean {

	private int shop_id;
	private int room_id;
	private String room_name;
	private int price;
	private String max_people;
	private String standard_people;
	private String check_in;
	private String check_out;
	private String room_count;
	
	// 첫이미지 및 룸이미지 테이블이용
	private String image;
	
	public int getShop_id() {
		return shop_id;
	}
	public void setShop_id(int shop_id) {
		this.shop_id = shop_id;
	}
	public int getRoom_id() {
		return room_id;
	}
	public void setRoom_id(int room_id) {
		this.room_id = room_id;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getMax_people() {
		return max_people;
	}
	public void setMax_people(String max_people) {
		this.max_people = max_people;
	}
	public String getStandard_people() {
		return standard_people;
	}
	public void setStandard_people(String standard_people) {
		this.standard_people = standard_people;
	}
	public String getCheck_in() {
		return check_in;
	}
	public void setCheck_in(String check_in) {
		this.check_in = check_in;
	}
	public String getCheck_out() {
		return check_out;
	}
	public void setCheck_out(String check_out) {
		this.check_out = check_out;
	}
	public String getRoom_count() {
		return room_count;
	}
	public void setRoom_count(String room_count) {
		this.room_count = room_count;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}

	
	
}