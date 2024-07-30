package member.model;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class MemberBean {

	private final String message = "입력 필수";

	private int user_id;

	@NotEmpty(message = "이메일" + message)
	private String user_email;

	@NotEmpty(message = "비밀번호" + message)
	private String user_passwd;

	@NotEmpty(message = "닉네임" + message)
	private String user_nickname;

	@NotEmpty(message = "휴대전화번호" + message)
	private String user_phone;

	@NotEmpty(message = "이름" + message)
	private String user_name;

	@NotNull(message = "성별 선택 필수")
	private String user_gender;

	private int user_age;

	@NotNull(message = "생년월일을 선택해주세요")
	private String user_birth;

	@NotEmpty(message = "주소" + message)
	private String user_addr1;
	private String user_addr2;

	private String user_status;
	private int user_point;
	private String user_image;

	private String user_account;

	private String user_type;

//테이블에없느 ㄴ변수추가 set get 추가하기
	private MultipartFile upload;
	private String upload2;

	public MultipartFile getUpload() {
		return upload;
	}

	public enum UserType {
		G, B, A;
	}

	public void setUpload(MultipartFile upload) {
		System.out.println("setUpload()");
		System.out.println("upload:" + upload); // org.springframework.web.multipart.commons.CommonsMultipartFile@51eb1299

		this.upload = upload;
		if (this.upload != null) {
			System.out.println(upload.getName()); // upload
			System.out.println(upload.getOriginalFilename()); // 남자시계.jpg

			// 이미지 선택 안하면
			if (upload.getOriginalFilename().isEmpty()) {
				System.out.println("dao 이미지 선택 안함");
			} else {

				user_image = upload.getOriginalFilename(); // image = 남자시계.jpg
			}
		}
	}

	public String getUpload2() {
		return upload2;
	}

	public void setUpload2(String upload2) {
		this.upload2 = upload2;
	}

	
	
	 public MemberBean() {
		 this.user_status = "N"; 
		 this.user_point = 0; 
		 }
	 
	 

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_passwd() {
		return user_passwd;
	}

	public void setUser_passwd(String user_passwd) {
		this.user_passwd = user_passwd;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_gender() {
		return user_gender;
	}

	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}

	public int getUser_age() {
		return user_age;
	}

	public void setUser_age(int user_age) {
		this.user_age = user_age;
	}

	public String getUser_birth() {
		return user_birth;
	}

	public void setUser_birth(String user_birth) {
		this.user_birth = user_birth;
	}

	public String getUser_addr1() {
		return user_addr1;
	}

	public void setUser_addr1(String user_addr1) {
		this.user_addr1 = user_addr1;
	}

	public String getUser_addr2() {
		return user_addr2;
	}

	public void setUser_addr2(String user_addr2) {
		this.user_addr2 = user_addr2;
	}

	public String getUser_status() {
		return user_status;
	}

	public void setUser_status(String user_status) {
		this.user_status = user_status;
	}

	public int getUser_point() {
		return user_point;
	}

	public void setUser_point(int user_point) {
		this.user_point = user_point;
	}

	public String getUser_image() {
		return user_image;
	}

	public void setUser_image(String user_image) {
		this.user_image = user_image;
	}

	public String getUser_account() {
		return user_account;
	}

	public void setUser_account(String user_account) {
		this.user_account = user_account;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

}
