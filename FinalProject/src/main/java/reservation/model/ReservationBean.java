package reservation.model;

public class ReservationBean {
	private int order_num;
	private int user_id;
	private int shop_id;
	private int room_id;
	private String room_checkin_date;
	private String room_checkout_date;
	private int room_reserve_quantity;
	private String train_schedule_id;
	private String train_departure_station_id;
	private String train_arrival_station_id;
	private int train_quantity_adult;
	private int train_quantity_child;
	private int train_quantity_senior;
	private int total_price;
	private int payment_status;
	private int refund_status;
	
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
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
	public String getTrain_schedule_id() {
		return train_schedule_id;
	}
	public void setTrain_schedule_id(String train_schedule_id) {
		this.train_schedule_id = train_schedule_id;
	}
	public String getTrain_departure_station_id() {
		return train_departure_station_id;
	}
	public void setTrain_departure_station_id(String train_departure_station_id) {
		this.train_departure_station_id = train_departure_station_id;
	}
	public String getTrain_arrival_station_id() {
		return train_arrival_station_id;
	}
	public void setTrain_arrival_station_id(String train_arrival_station_id) {
		this.train_arrival_station_id = train_arrival_station_id;
	}
	public int getTrain_quantity_adult() {
		return train_quantity_adult;
	}
	public void setTrain_quantity_adult(int train_quantity_adult) {
		this.train_quantity_adult = train_quantity_adult;
	}
	public int getTrain_quantity_child() {
		return train_quantity_child;
	}
	public void setTrain_quantity_child(int train_quantity_child) {
		this.train_quantity_child = train_quantity_child;
	}
	public int getTrain_quantity_senior() {
		return train_quantity_senior;
	}
	public void setTrain_quantity_senior(int train_quantity_senior) {
		this.train_quantity_senior = train_quantity_senior;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public int getPayment_status() {
		return payment_status;
	}
	public void setPayment_status(int payment_status) {
		this.payment_status = payment_status;
	}
	public int getRefund_status() {
		return refund_status;
	}
	public void setRefund_status(int refund_status) {
		this.refund_status = refund_status;
	}
	


	
	
}
