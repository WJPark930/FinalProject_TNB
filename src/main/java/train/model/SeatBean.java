package train.model;


public class SeatBean {

   private int seat_id;
   private int order_num;
   private String seat_no;
   private String schedule_id;
   
   public SeatBean(int seat_id, int order_num, String seat_no, String schedule_id) {
      super();
      this.seat_id = seat_id;
      this.order_num = order_num;
      this.seat_no = seat_no;
      this.schedule_id = schedule_id;
   }

   public SeatBean() {
      
   }

   public int getSeat_id() {
      return seat_id;
   }

   public void setSeat_id(int seat_id) {
      this.seat_id = seat_id;
   }

   public int getOrder_num() {
      return order_num;
   }

   public void setOrder_num(int order_num) {
      this.order_num = order_num;
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
