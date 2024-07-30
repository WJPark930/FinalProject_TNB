package mypage.model;

public class RoomReservationBean {
	
	private int order_num;
	private int shop_id;
	private int room_id;
	private String room_checkin_date;
	private String room_checkout_date;
	private int room_reserve_quantity;
	private int price;
	

	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}

	
	
}


