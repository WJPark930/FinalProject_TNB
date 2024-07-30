package payment.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import event.model.EventDao;
import member.model.MemberBean;
import member.model.MemberDao;
import payment.model.PaymentBean;
import payment.model.PaymentDao;
import reservation.model.ReservationDao;
import reservation.model.RoomReservationBean;
import reservation.model.RoomReservationDao;
import reservation.model.TrainReservationBean;
import reservation.model.TrainReservationDao;
import shop.model.GuideBean;
import shop.model.ReviewBean;
import shop.model.ReviewDao;
import shop.model.ServiceBean;
import shop.model.ShopBean;
import shop.model.ShopDao;
import shop.model.ShopRoomBean;

@Controller
public class PaymentController {
   private final String command = "payment.pay";
   private final String getPage = "payment";
   private final String success = "success";
   private final String approval = "approval.pay";
   private final String approvalPage = "approval";
   private final String gotoPage = "payList";
   private final String loginPage = "redirect:/loginForm.mb";
   
   @Autowired
   private PaymentDao pdao;
   
   @Autowired
   private ReservationDao rdao;
   
   @Autowired
   private RoomReservationDao rrdao;
   
   @Autowired
   private TrainReservationDao trdao;
   
   @Autowired
   private EventDao edao;
   
   @Autowired
   private MemberDao mdao;
   
   @Autowired
   ShopDao shopDao;
   
   @Autowired
   ReviewDao reviewDao;
   
   @Autowired
   ServletContext servletContext;
   
   @RequestMapping(value=command, method = RequestMethod.GET) 
   public String payment(@ModelAttribute("payment") PaymentBean pb, Model model, HttpSession session) {
      
      MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
      if(loginInfo == null) {
         return loginPage;
      } else {
         System.out.println("order_num : " + pb.getOrder_num());
         System.out.println("user_id : " + pb.getUser_id());
         System.out.println("coupon_num : " + pb.getCoupon_num());
         System.out.println("point_amount : " + pb.getPoint_amount());
         System.out.println("total_price : " + pb.getTotal_price());
   
         
         RoomReservationBean rrb = rrdao.getThisRoomReservation(pb.getOrder_num());
         TrainReservationBean trb = trdao.isReservationWithTrain(rrb.getRoom_reservation_num());
         
         if(trb == null) {
            String shopId = String.valueOf(rrb.getShop_id());
            
            ShopBean shop_info = shopDao.getShopInfo(shopId);
            List<String> shop_image = shopDao.getShopImage(shopId);
            List<ServiceBean> shop_service = shopDao.getShopService(shopId);
            List<GuideBean> shop_guide = shopDao.getShopGuide(shopId);
            /* List<ShopRoomBean> shop_room = shopDao.getShopRoom(map); */
            List<ShopRoomBean> room_image = shopDao.getRoomImage(shopId);
            List<ReviewBean> shop_review = reviewDao.getShopReview(shopId);
            List<ReviewBean> review_image = reviewDao.getShopReviewImage(shopId);
            
            ShopRoomBean srb = new ShopRoomBean();
            ShopRoomBean srb2 = new ShopRoomBean();
            
            srb.setShop_id(Integer.parseInt(shopId));
            srb.setRoom_id(rrb.getRoom_id());
            srb2 = shopDao.getRoomInfo(srb); 
   
            MemberBean mb = mdao.getMemberByUser_id(pb.getUser_id());
            
            
            model.addAttribute("order_num", pb.getOrder_num());
            model.addAttribute("user_id", pb.getUser_id());
            model.addAttribute("coupon_num", pb.getCoupon_num());
            model.addAttribute("point_amount", pb.getPoint_amount());
            model.addAttribute("total_price", pb.getTotal_price());
            
            model.addAttribute("mb", mb);
            
            model.addAttribute("shop_info",shop_info);
            model.addAttribute("shop_image",shop_image);
            model.addAttribute("shop_service",shop_service);
            model.addAttribute("shop_guide",shop_guide);
            model.addAttribute("room_image",room_image);
            model.addAttribute("shop_review",shop_review);
            model.addAttribute("review_image",review_image);
            
            model.addAttribute("srb", srb2);
         } else {
            String shopId = String.valueOf(rrb.getShop_id());
            
            ShopBean shop_info = shopDao.getShopInfo(shopId);
            List<String> shop_image = shopDao.getShopImage(shopId);
            List<ServiceBean> shop_service = shopDao.getShopService(shopId);
            List<GuideBean> shop_guide = shopDao.getShopGuide(shopId);
            /* List<ShopRoomBean> shop_room = shopDao.getShopRoom(map); */
            List<ShopRoomBean> room_image = shopDao.getRoomImage(shopId);
            List<ReviewBean> shop_review = reviewDao.getShopReview(shopId);
            List<ReviewBean> review_image = reviewDao.getShopReviewImage(shopId);
            
            ShopRoomBean srb = new ShopRoomBean();
            ShopRoomBean srb2 = new ShopRoomBean();
            
            srb.setShop_id(Integer.parseInt(shopId));
            srb.setRoom_id(rrb.getRoom_id());
            srb2 = shopDao.getRoomInfo(srb); 
   
            MemberBean mb = mdao.getMemberByUser_id(pb.getUser_id());
            
            model.addAttribute("order_num", pb.getOrder_num());
            model.addAttribute("user_id", pb.getUser_id());
            model.addAttribute("coupon_num", pb.getCoupon_num());
            model.addAttribute("point_amount", pb.getPoint_amount());
            model.addAttribute("total_price", pb.getTotal_price());
            
            model.addAttribute("mb", mb);
            
            model.addAttribute("shop_info",shop_info);
            model.addAttribute("shop_image",shop_image);
            model.addAttribute("shop_service",shop_service);
            model.addAttribute("shop_guide",shop_guide);
            model.addAttribute("room_image",room_image);
            model.addAttribute("shop_review",shop_review);
            model.addAttribute("review_image",review_image);
            
            model.addAttribute("srb", srb2);
            
         }
      
         return getPage;
      }
   }
   
   @RequestMapping(value = command, method = RequestMethod.POST)
   public ModelAndView whenSuccess(@ModelAttribute("payment") PaymentBean pb, Model model, HttpSession session) {
      System.out.println("success");
      ModelAndView mav = new ModelAndView();
      
      MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
      if(loginInfo == null) {
         mav.setViewName(loginPage);
      } else {
         
         int user_id = pb.getUser_id();
           int coupon_num = pb.getCoupon_num();
           int point_amount = pb.getPoint_amount();
           int order_num = pb.getOrder_num();
           int total_price = pb.getTotal_price();
         
           System.out.println("user_id : " + user_id);
           System.out.println("order_num : " + order_num);
           System.out.println("point_amount : " + point_amount);
           System.out.println("coupon_num : " + coupon_num);
           System.out.println("total_price : " + total_price);
         
         PaymentBean payFinal = new PaymentBean();
         payFinal.setOrder_num(order_num);
         payFinal.setUser_id(user_id);
         payFinal.setPoint_amount(point_amount);
         payFinal.setCoupon_num(coupon_num);
         payFinal.setTotal_price(total_price);
         
      
          int cnt = rdao.updateFinalPrice(payFinal);
          System.out.println("update Final Price cnt : " + cnt);
         
         
         int cnt1, cnt2, cnt3, cnt4 = -1;
         
         cnt1 = rdao.updatePaymentStatus(payFinal.getOrder_num());
         System.out.println("cnt1 : " + cnt1);
         if(cnt1 == 1) {
            System.out.println("payment_status update from reservationtable success");
            cnt2 = pdao.paymentInsert(payFinal);
            System.out.println("cnt2 : " + cnt2);
            if(cnt2 == 1) {
               System.out.println("insert into paymenttable success");
               cnt3 = mdao.decreasePoint(payFinal);
               System.out.println("cnt3 : " + cnt3);
               if(cnt3 == 0) {
                  System.out.println("not used Point");
               } else if(cnt3 == 1) {
                  System.out.println("decreasePoint success");
               } else {
                  System.out.println("point failure");
               }
               
               cnt4 = edao.updateCouponUse_status_toYes(payFinal);
               System.out.println("cnt4 : " + cnt4);
               if(cnt4 == 0) {
                  System.out.println("not used Coupon");
               } else if(cnt4 == 1) {
                  System.out.println("updateCouponUse_status_toYes success");
               } else {
                  System.out.println("coupon failure");
               }
            }
         }
         
         mav.addObject("pb", payFinal);
         mav.setViewName(success);
      }
      return mav;
   }
   

   @RequestMapping(value = approval, method = RequestMethod.POST)
   public String approval(HttpSession session) {
      MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
      if(loginInfo == null) {
         return loginPage;
      } else {
         return approvalPage;
      }
   }
   
   
   

}
