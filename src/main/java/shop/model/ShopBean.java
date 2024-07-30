package shop.model;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class ShopBean {
	private int shop_id;
	private int user_id;
	
    @NotBlank(message = "시설명을 입력해주세요.")
    @Length(max = 20, message = "시설명은 20자 이내로 입력해주세요")
    private String shop_name;
	
	@NotEmpty(message = "지역을 선택하세요.")
	private String region;
	
	@NotBlank(message = "주소를 지정해주세요.")
	private String shop_address;
	
	@NotBlank(message = "시설소개를 입력해주세요.")
	@Length(max = 100,message = "시설소개는 20자 이내로 입력해주세요")
	private String shop_info;
	private double grade;
	private int review_count;
	
	@Min(value = 1, message = "하나 이상의 카테고리를 선택해주세요.")
	private int category_id;
	private String shop_date;
	
	/* 최저가, 대표이미지, 카테고리, 서비스 */
	private int price;
	private String image;
	private String category_name;
	private String service_name;
	private int service_id;
	private int shop_img_id;
	
	private String save_image;
	private MultipartFile[] upload;
	private String[] image_name = new String[10];
	
	public MultipartFile[] getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile[] upload) {
		//System.out.println("setUpload");
		this.upload = upload;
		if (this.upload.length > 0 ) {
			for(int i=0;i<upload.length;i++) {
				//System.out.println("###upload.getOriginalFilename():"+upload[i].getOriginalFilename()); // 이미지명
				image_name[i] = upload[i].getOriginalFilename();
			}
		}
	}	 
	
	public String getSave_image() {
		return save_image;
	}

	public void setSave_image(String save_image) {
		this.save_image = save_image;
	}	
	
	public String[] getImage_name() {
		return image_name;
	}

	public void setImage_name(String[] image_name) {
		this.image_name = image_name;
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
	public String getShop_name() {
		return shop_name;
	}
	public void setShop_name(String shop_name) {
		this.shop_name = shop_name;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getShop_address() {
		return shop_address;
	}
	public void setShop_address(String shop_address) {
		this.shop_address = shop_address;
	}
	public double getGrade() {
		return grade;
	}
	public void setGrade(double grade) {
		this.grade = grade;
	}
	public int getReview_count() {
		return review_count;
	}
	public void setReview_count(int review_count) {
		this.review_count = review_count;
	}
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public String getShop_date() {
		return shop_date;
	}
	public void setShop_date(String shop_date) {
		this.shop_date = shop_date;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getShop_info() {
		return shop_info;
	}
	public void setShop_info(String shop_info) {
		this.shop_info = shop_info;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public int getService_id() {
		return service_id;
	}
	public void setService_id(int service_id) {
		this.service_id = service_id;
	}

	public String getService_name() {
		return service_name;
	}
	public void setService_name(String service_name) {
		this.service_name = service_name;
	}

	public int getShop_img_id() {
		return shop_img_id;
	}

	public void setShop_img_id(int shop_img_id) {
		this.shop_img_id = shop_img_id;
	}
	
	
}
