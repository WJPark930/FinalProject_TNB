package shop.model;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

public class ShopRoomBean {

   private int shop_id;
   private int room_id;
   
   @NotBlank(message = "객실명을 입력해주세요.")
   private String room_name;
   
   @NotNull(message = "가격을 입력해주세요.")
   @Min(value = 1,message = "가격을 입력해주세요.")
   @Max(value = 10000000,message = "너무 큰 가격을 입력하셨습니다.")
   private int price;
    
   private String max_people;
   private String standard_people;
   private String check_in;
   private String check_out;
   private String room_count;
   
   private String save_image;
   private MultipartFile[] upload;
   private String[] image_name;
   private int room_img_id;
   
   public MultipartFile[] getUpload() {
      return upload;
   }

   public void setUpload(MultipartFile[] upload) {
      //System.out.println("setUpload");
      this.upload = upload;
      if (this.upload.length > 0 ) {
         image_name = new String[upload.length];
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

   
   // 첫이미지 및 룸이미지 테이블이용
   private String image;
   
   public int getShop_id() {
      return shop_id;
   }
   public void setShop_id(int shop_id) {
      this.shop_id = shop_id;
   }
   public int getRoom_id() {
      return room_id;
   }
   public void setRoom_id(int room_id) {
      this.room_id = room_id;
   }
   public String getRoom_name() {
      return room_name;
   }
   public void setRoom_name(String room_name) {
      this.room_name = room_name;
   }
   public int getPrice() {
      return price;
   }
   public void setPrice(int price) {
      this.price = price;
   }
   public String getMax_people() {
      return max_people;
   }
   public void setMax_people(String max_people) {
      this.max_people = max_people;
   }
   public String getStandard_people() {
      return standard_people;
   }
   public void setStandard_people(String standard_people) {
      this.standard_people = standard_people;
   }
   public String getCheck_in() {
      return check_in;
   }
   public void setCheck_in(String check_in) {
      this.check_in = check_in;
   }
   public String getCheck_out() {
      return check_out;
   }
   public void setCheck_out(String check_out) {
      this.check_out = check_out;
   }
   public String getRoom_count() {
      return room_count;
   }
   public void setRoom_count(String room_count) {
      this.room_count = room_count;
   }
   public String getImage() {
      return image;
   }
   public void setImage(String image) {
      this.image = image;
   }

   public int getRoom_img_id() {
      return room_img_id;
   }

   public void setRoom_img_id(int room_img_id) {
      this.room_img_id = room_img_id;
   }
   
   
   
}
