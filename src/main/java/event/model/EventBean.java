package event.model;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

public class EventBean {

	private int event_num;
	
	@NotBlank(message = "event_title mandatory")
	private String event_title;
	
	@NotBlank(message = "event_context mandatory")
	private String event_context;
	
	@NotBlank(message = "event_image mandatory")
	private String event_image;
	
	private String event_start_date;
	
	@NotBlank(message = "event_end_date mandatory")
	private String event_end_date;
	private String event_discount_kind;
	private int event_discount_amount;
	
	private MultipartFile upload;
	private String upload2;
	
	public int getEvent_num() {
		return event_num;
	}
	
	public void setEvent_num(int event_num) {
		this.event_num = event_num;
	}
	
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
	
	public String getEvent_start_date() {
		return event_start_date;
	}
	
	public void setEvent_start_date(String event_start_date) {
		this.event_start_date = event_start_date;
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
	
	public int getEvent_discount_amount() {
		return event_discount_amount;
	}
	
	public void setEvent_discount_amount(int event_discount_amount) {
		this.event_discount_amount = event_discount_amount;
	}
	
	
	//for file upload
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
		if(this.upload != null) {
			event_image = upload.getOriginalFilename(); 
		}
	}
	public String getUpload2() {
		return upload2;
	}
	public void setUpload2(String upload2) {
		this.upload2 = upload2;
		
		if(this.upload2 != null) {
			
		}
	}
	
}
