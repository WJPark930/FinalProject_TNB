package reservation.model;

public class TrainReservationBean {
	
	private int train_reservation_id;
	private int user_id;
	private int train_no;
	private String trainCode;
	private String depPlaceName;
	private String arrPlaceName;
	private String depPlandTime;
	private String arrPlandTime;
	private String totalTime;
	private int num_adult;
	private int num_children;
	private int num_seniors;
	private String seat_no;
	private int total_price;
	private int total_charge;
	
	public int getTrain_reservation_id() {
		return train_reservation_id;
	}
	public void setTrain_reservation_id(int train_reservation_id) {
		this.train_reservation_id = train_reservation_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getTrain_no() {
		return train_no;
	}
	public void setTrain_no(int train_no) {
		this.train_no = train_no;
	}
	public String getTrainCode() {
		return trainCode;
	}
	public void setTrainCode(String trainCode) {
		this.trainCode = trainCode;
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
	public String getTotalTime() {
		return totalTime;
	}
	public void setTotalTime(String totalTime) {
		this.totalTime = totalTime;
	}
	public int getNum_adult() {
		return num_adult;
	}
	public void setNum_adult(int num_adult) {
		this.num_adult = num_adult;
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
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public int getTotal_charge() {
		return total_charge;
	}
	public void setTotal_charge(int total_charge) {
		this.total_charge = total_charge;
	}
	
	
	
}
