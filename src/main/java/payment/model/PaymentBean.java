package payment.model;

public class PaymentBean {
	private int payment_num;
	private String tid;
	private int order_num;
	private int user_id;
	private int coupon_num;
	private int point_amount;
	private int total_price;
	
	public int getPayment_num() {
		return payment_num;
	}
	public void setPayment_num(int payment_num) {
		this.payment_num = payment_num;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
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
	public int getCoupon_num() {
		return coupon_num;
	}
	public void setCoupon_num(int coupon_num) {
		this.coupon_num = coupon_num;
	}
	public int getPoint_amount() {
		return point_amount;
	}
	public void setPoint_amount(int point_amount) {
		this.point_amount = point_amount;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	
	
	
}
