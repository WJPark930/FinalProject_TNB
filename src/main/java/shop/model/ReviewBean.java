package shop.model;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

public class ReviewBean {

	private int review_id;
	private int room_id;
	private int shop_id;
	private int user_id;
	private int reservation_id;
	
	@NotBlank(message = "리뷰 내용을 입력해주세요.")
	@Size(max = 300, message = "리뷰 내용은 300자 이내로 입력해주세요.")
	private String review_content;
	
	private double grade;
	private int recommend;
	private String review_date;
	
	/* 이미지 및 리뷰 요소 */
	private int review_img_id;
	
	@NotBlank(message = "최소 한개의 이미지를 추가해주세요.")
	private String image;
	
	private String save_image;
	private MultipartFile[] upload;
	
	private String user_nickname;
	private String user_image;
	private String room_name;	
	private String shop_name;	
	
	public MultipartFile[] getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile[] upload) {
		//System.out.println("setUpload");
		this.upload = upload;
		if (this.upload.length > 0 ) {
			image = "";
			for(int i=0;i<upload.length;i++) {
				//System.out.println("###upload.getOriginalFilename():"+upload[i].getOriginalFilename()); // 이미지명
				image += upload[i].getOriginalFilename();
				if(i!=upload.length-1) {
					image += " /-/ ";
				}
			}
		}
	}	 

	public int getReview_id() {
		return review_id;
	}

	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}

	public int getRoom_id() {
		return room_id;
	}

	public void setRoom_id(int room_id) {
		this.room_id = room_id;
	}

	public int getShop_id() {
		return shop_id;
	}

	public void setShop_id(int shop_id) {
		this.shop_id = shop_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public double getGrade() {
		return grade;
	}

	public void setGrade(double grade) {
		this.grade = grade;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public String getReview_date() {
		return review_date;
	}

	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getUser_image() {
		return user_image;
	}

	public void setUser_image(String user_img) {
		this.user_image = user_img;
	}

	public String getRoom_name() {
		return room_name;
	}

	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}

	public int getReservation_id() {
		return reservation_id;
	}

	public void setReservation_id(int reservation_id) {
		this.reservation_id = reservation_id;
	}
	public String getShop_name() {
		return shop_name;
	}

	public void setShop_name(String shop_name) {
		this.shop_name = shop_name;
	}

	public int getReview_img_id() {
		return review_img_id;
	}

	public void setReview_img_id(int review_img_id) {
		this.review_img_id = review_img_id;
	}

	public String getSave_image() {
		return save_image;
	}

	public void setSave_image(String save_image) {
		this.save_image = save_image;
	}
	
	
	
	
	
}
