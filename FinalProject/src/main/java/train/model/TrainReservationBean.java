package train.model;

import java.util.Date;

public class TrainReservationBean {

	private int train_reservation_num;    // 예약 ID (PK)
    private int user_id;                 // 사용자 ID
    private String depPlaceName;        // 출발역
    private String arrPlaceName;        // 도착역
    private Date depPlandTime;          // 출발 시간
    private Date arrPlandTime;          // 도착 시간
    private String duration;            // 소요시간
    private int train_no;                // 열차 번호
    private String train_type;           // 열차 종류
    private int num_adults;              // 성인 수
    private int num_children;            // 아동 수
    private int num_seniors;             // 경로자 수
    private String seat_no;              // 좌석 번호 (쉼표로 구분된 문자열)
    private int train_total_prices;        // 총 가격
    
    public TrainReservationBean() {
    	
    }
	public TrainReservationBean(int train_reservation_num, int user_id, String depPlaceName, String arrPlaceName,
			Date depPlandTime, Date arrPlandTime, String duration, int train_no, String train_type, int num_adults,
			int num_children, int num_seniors, String seat_no, int train_total_prices) {
		super();
		this.train_reservation_num = train_reservation_num;
		this.user_id = user_id;
		this.depPlaceName = depPlaceName;
		this.arrPlaceName = arrPlaceName;
		this.depPlandTime = depPlandTime;
		this.arrPlandTime = arrPlandTime;
		this.duration = duration;
		this.train_no = train_no;
		this.train_type = train_type;
		this.num_adults = num_adults;
		this.num_children = num_children;
		this.num_seniors = num_seniors;
		this.seat_no = seat_no;
		this.train_total_prices = train_total_prices;
	}
	
	public int getTrain_reservation_num() {
		return train_reservation_num;
	}
	public void setTrain_reservation_num(int train_reservation_num) {
		this.train_reservation_num = train_reservation_num;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
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
	public Date getDepPlandTime() {
		return depPlandTime;
	}
	public void setDepPlandTime(Date depPlandTime) {
		this.depPlandTime = depPlandTime;
	}
	public Date getArrPlandTime() {
		return arrPlandTime;
	}
	public void setArrPlandTime(Date arrPlandTime) {
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
	public int getTrain_total_prices() {
		return train_total_prices;
	}
	public void setTrain_total_prices(int train_total_prices) {
		this.train_total_prices = train_total_prices;
	}
}