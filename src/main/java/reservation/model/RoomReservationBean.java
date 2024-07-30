package reservation.model;

public class RoomReservationBean {
	private int room_reservation_num;
	private int user_id;
	private int shop_id;
	private int room_id;
	private String room_checkin_date;
	private String room_checkout_date;
	private int room_reserve_quantity;
	private int room_total_price;
	
	public int getRoom_reservation_num() {
		return room_reservation_num;
	}
	public void setRoom_reservation_num(int room_reservation_num) {
		this.room_reservation_num = room_reservation_num;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
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
	public String getRoom_checkin_date() {
		return room_checkin_date;
	}
	public void setRoom_checkin_date(String room_checkin_date) {
		this.room_checkin_date = room_checkin_date;
	}
	public String getRoom_checkout_date() {
		return room_checkout_date;
	}
	public void setRoom_checkout_date(String room_checkout_date) {
		this.room_checkout_date = room_checkout_date;
	}
	public int getRoom_reserve_quantity() {
		return room_reserve_quantity;
	}
	public void setRoom_reserve_quantity(int room_reserve_quantity) {
		this.room_reserve_quantity = room_reserve_quantity;
	}
	public int getRoom_total_price() {
		return room_total_price;
	}
	public void setRoom_total_price(int room_total_price) {
		this.room_total_price = room_total_price;
	}
	
}
