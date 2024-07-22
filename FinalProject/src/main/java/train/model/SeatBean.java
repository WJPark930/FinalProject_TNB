package train.model;

import java.util.Date;

public class SeatBean {

	private int seat_id;
	private String seat_no;
	private String schedule_id;
	
	public SeatBean() {
		
	}
	public SeatBean(int seat_id, String seat_no, String schedule_id) {
		super();
		this.seat_id = seat_id;
		this.seat_no = seat_no;
		this.schedule_id = schedule_id;
	}
	
	public int getSeat_id() {
		return seat_id;
	}
	public void setSeat_id(int seat_id) {
		this.seat_id = seat_id;
	}
	public String getSeat_no() {
		return seat_no;
	}
	public void setSeat_no(String seat_no) {
		this.seat_no = seat_no;
	}
	public String getSchedule_id() {
		return schedule_id;
	}
	public void setSchedule_id(String schedule_id) {
		this.schedule_id = schedule_id;
	}
	
}