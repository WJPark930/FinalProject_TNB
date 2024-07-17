package member.model;

import java.sql.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class MemberBean {
<<<<<<< HEAD

	private final String message="ÀÔ·Â ÇÊ¼ö";

	private int user_id;

	@NotEmpty(message="ÀÌ¸ÞÀÏ"+message)
	private String user_email;

	@NotEmpty(message="ºñ¹Ð¹øÈ£"+message)
	private String user_passwd;

	@NotEmpty(message="´Ð³×ÀÓ"+message)
	private String user_nickname;

	@NotEmpty(message="ÈÞ´ëÀüÈ­¹øÈ£"+message)
	private String user_phone;

	//@NotEmpty(message="ÀÌ¸§"+message)
	private String user_name;

	@NotNull(message="¼ºº° ¼±ÅÃ ÇÊ¼ö")
	private String user_gender;


	private int user_age;

	@NotNull(message="»ý³â¿ùÀÏÀ» ¼±ÅÃÇØÁÖ¼¼¿ä")
	private String user_birth;

	@NotEmpty(message="ÁÖ¼Ò"+message)
	private String user_addr1;
	private String user_addr2;


	private String user_status;
	private int user_point;
	private String user_image;

	private String user_account;

	private String user_type;

	//Å×ÀÌºí¿¡¾ø´Â º¯¼öÃß°¡ set get Ãß°¡ÇÏ±â
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
		System.out.println("upload:" + upload); 

		this.upload = upload;
		if(this.upload != null) {
			System.out.println(upload.getName()); 
			System.out.println(upload.getOriginalFilename());
			
			//ÀÌ¹ÌÁö ¼±ÅÃ ¾ÈÇÏ¸é 
			if(upload.getOriginalFilename().isEmpty()) {
				System.out.println("dao ÀÌ¹ÌÁö ¼±ÅÃ ¾ÈÇÔ");
			} else {
				user_image = upload.getOriginalFilename();
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
=======
	
	private final String message="ìž…ë ¥ í•„ìˆ˜";
	
private int user_id;

@NotEmpty(message="ì´ë©”ì¼"+message)
private String user_email;

@NotEmpty(message="ë¹„ë°€ë²ˆí˜¸"+message)
private String user_passwd;

@NotEmpty(message="ë‹‰ë„¤ìž„"+message)
private String user_nickname;

@NotEmpty(message="íœ´ëŒ€ì „í™”ë²ˆí˜¸"+message)
private String user_phone;

//@NotEmpty(message="ì´ë¦„"+message)
private String user_name;

@NotNull(message="ì„±ë³„ ì„ íƒ í•„ìˆ˜")
private String user_gender;


private int user_age;

@NotNull(message="ìƒë…„ì›”ì¼ì„ ì„ íƒí•´ì£¼ì„¸ìš”")
private String user_birth;

@NotEmpty(message="ì£¼ì†Œ"+message)
private String user_addr1;
private String user_addr2;


private String user_status;
private int user_point;
private String user_image;

private String user_account;

private String user_type;

//í…Œì´ë¸”ì—ì—†ëŠ ã„´ë³€ìˆ˜ì¶”ê°€ set get ì¶”ê°€í•˜ê¸°
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
		if(this.upload != null) {
			System.out.println(upload.getName()); // upload
			System.out.println(upload.getOriginalFilename()); // ë‚¨ìžì‹œê³„.jpg
			user_image = upload.getOriginalFilename(); // image = ë‚¨ìžì‹œê³„.jpg
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
>>>>>>> branch 'leeyewon' of https://github.com/WJPark930/FinalProject.git
