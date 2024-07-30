package event.model;

public class CouponBean {
	
	private int coupon_num;
	private int event_num;
	private int user_id;
	private String kind;
	private int amount;
	private int use_status;
	
	private String event_title;
	private String event_context;
	private String event_image;
	private String event_end_date;
	private String event_discount_kind;
	
	
	public String getEvent_title() {
		return event_title;
	}
	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}
	public String getEvent_context() {
		return event_context;
	}
	public void setEvent_context(String event_context) {
		this.event_context = event_context;
	}
	public String getEvent_image() {
		return event_image;
	}
	public void setEvent_image(String event_image) {
		this.event_image = event_image;
	}
	public String getEvent_end_date() {
		return event_end_date;
	}
	public void setEvent_end_date(String event_end_date) {
		this.event_end_date = event_end_date;
	}
	public String getEvent_discount_kind() {
		return event_discount_kind;
	}
	public void setEvent_discount_kind(String event_discount_kind) {
		this.event_discount_kind = event_discount_kind;
	}
	
	public int getCoupon_num() {
		return coupon_num;
	}
	public void setCoupon_num(int coupon_num) {
		this.coupon_num = coupon_num;
	}
	public int getEvent_num() {
		return event_num;
	}
	public void setEvent_num(int event_num) {
		this.event_num = event_num;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getUse_status() {
		return use_status;
	}
	public void setUse_status(int use_status) {
		this.use_status = use_status;
	}

	

	
}
