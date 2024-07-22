package train.model;

import java.util.Date;

public class TrainScheduleBean {

	private String schedule_id;
	private int train_no;
	private String depPlaceName;
	private String arrPlaceName;
	private String train_type;
	private Date depPlandTime;
	private Date arrPlandTime;
	private int seat_available;
	private int adult_charge;
	private String duration;
	
	public TrainScheduleBean() {
		
	}
	public TrainScheduleBean(String schedule_id, int train_no, String depPlaceName, String arrPlaceName,
			String train_type, Date depPlandTime, Date arrPlandTime, int seat_available, int adult_charge,String duration) {
		super();
		this.schedule_id = schedule_id;
		this.train_no = train_no;
		this.depPlaceName = depPlaceName;
		this.arrPlaceName = arrPlaceName;
		this.train_type = train_type;
		this.depPlandTime = depPlandTime;
		this.arrPlandTime = arrPlandTime;
		this.seat_available = seat_available;
		this.adult_charge = adult_charge;
		this.duration = duration;
	}
	
	public String getSchedule_id() {
		return schedule_id;
	}
	public void setSchedule_id(String schedule_id) {
		this.schedule_id = schedule_id;
	}
	public int getTrain_no() {
		return train_no;
	}
	public void setTrain_no(int train_no) {
		this.train_no = train_no;
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
	public String getTrain_type() {
		return train_type;
	}
	public void setTrain_type(String train_type) {
		this.train_type = train_type;
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
	public int getSeat_available() {
		return seat_available;
	}
	public void setSeat_available(int seat_available) {
		this.seat_available = seat_available;
	}
	public int getAdult_charge() {
		return adult_charge;
	}
	public void setAdult_charge(int adult_charge) {
		this.adult_charge = adult_charge;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
}
