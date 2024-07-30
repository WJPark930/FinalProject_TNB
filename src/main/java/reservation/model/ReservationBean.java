package reservation.model;

import java.util.Date;

public class ReservationBean {
	private int order_num;
	private int user_id;
	
	private int shop_id;
	private int room_id;
	private String room_checkin_date;
	private String room_checkout_date;
	private int room_reserve_quantity;
	private int room_total_price;
	
    private String depPlaceName;        
    private String arrPlaceName;        
    private String depPlandTime;         
    private String arrPlandTime;          
    private String duration;            
    private int train_no;               
    private String train_type;          
    private int num_adults;              
    private int num_children;            
    private int num_seniors;            
    private String seat_no;              
    private int train_total_price;      
    
	private int total_price;
	private int payment_status;
	private int refund_status;
	
	private String shop_name;
	private String room_name;
	
	public String getShop_name() {
		return shop_name;
	}
	public void setShop_name(String shop_name) {
		this.shop_name = shop_name;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	
	private int room_reservation_num;
	
	public int getRoom_reservation_num() {
		return room_reservation_num;
	}
	public void setRoom_reservation_num(int room_reservation_num) {
		this.room_reservation_num = room_reservation_num;
	}
	
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
	public int getRoom_total_price() {
		return room_total_price;
	}
	public void setRoom_total_price(int room_total_price) {
		this.room_total_price = room_total_price;
	}
	public String getDepPlaceName() {
		return depPlaceName;
	}
	public void setDepPlaceName(String depPlaceName) {
		this.depPlaceName = depPlaceName;
	}
	public String getArrPlaceName() {
		return arrPlaceName;
	}
	public void setArrPlaceName(String arrPlaceName) {
		this.arrPlaceName = arrPlaceName;
	}
	public String getDepPlandTime() {
		return depPlandTime;
	}
	public void setDepPlandTime(String depPlandTime) {
		this.depPlandTime = depPlandTime;
	}
	public String getArrPlandTime() {
		return arrPlandTime;
	}
	public void setArrPlandTime(String arrPlandTime) {
		this.arrPlandTime = arrPlandTime;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public int getTrain_no() {
		return train_no;
	}
	public void setTrain_no(int train_no) {
		this.train_no = train_no;
	}
	public String getTrain_type() {
		return train_type;
	}
	public void setTrain_type(String train_type) {
		this.train_type = train_type;
	}
	public int getNum_adults() {
		return num_adults;
	}
	public void setNum_adults(int num_adults) {
		this.num_adults = num_adults;
	}
	public int getNum_children() {
		return num_children;
	}
	public void setNum_children(int num_children) {
		this.num_children = num_children;
	}
	public int getNum_seniors() {
		return num_seniors;
	}
	public void setNum_seniors(int num_seniors) {
		this.num_seniors = num_seniors;
	}
	public String getSeat_no() {
		return seat_no;
	}
	public void setSeat_no(String seat_no) {
		this.seat_no = seat_no;
	}
	public int getTrain_total_price() {
		return train_total_price;
	}
	public void setTrain_total_price(int train_total_price) {
		this.train_total_price = train_total_price;
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
