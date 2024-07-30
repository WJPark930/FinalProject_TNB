package payment.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;
import payment.model.PaymentBean;
import payment.model.PaymentDao;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
import reservation.model.RoomReservationBean;
import reservation.model.RoomReservationDao;
import reservation.model.TrainReservationBean;
import reservation.model.TrainReservationDao;
import shop.model.ShopDao;
import shop.model.ShopRoomBean;

@Controller
public class GotoThisPaymentController {
    private final String command = "gotoThisPayment.pay";
    private final String loginPage = "redirect:/loginForm.mb";
    private final String gotoPage = "detailPayment";

    @Autowired
    private PaymentDao pdao;

    @Autowired
    private MemberDao mdao;

    @Autowired
    private RoomReservationDao rrdao;

    @Autowired
    private TrainReservationDao trdao;

    @Autowired
    private ShopDao shopDao;

    @Autowired
    private ReservationDao rdao;

    @RequestMapping(command)
    public String gotoPage(@RequestParam(value = "order_num", required = true) int order_num,
                         @RequestParam(value = "tid", required = true) String tid,
                         HttpSession session, HttpServletRequest request) {

        MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
        if (loginInfo == null) {
            return loginPage;
        } else {

	        int user_id = loginInfo.getUser_id();
	        System.out.println("gotoThisPayment order_num : " + order_num);
	        System.out.println("gotoThisPayment tid : " + tid);
	
	        PaymentBean pb = pdao.getThisPayment(order_num);
	        pb.setTid(tid);
	
	        pdao.insertTid(pb);
	        pb = pdao.getThisPayment(order_num);
	
	        RoomReservationBean rrb = rrdao.getThisRoomReservation(order_num);
	        TrainReservationBean trb = trdao.isReservationWithTrain(order_num);
	        MemberBean mb = mdao.getMember(pb.getUser_id());
	        ReservationBean rb = rdao.showDetailPayment(order_num);
	
	        String shopId = String.valueOf(rrb.getShop_id());
	        ShopRoomBean srb = new ShopRoomBean();
	        srb.setShop_id(Integer.parseInt(shopId));
	        srb.setRoom_id(rrb.getRoom_id());
	        ShopRoomBean srb2 = shopDao.getRoomInfo(srb);
	
	        request.setAttribute("order_num", pb.getOrder_num());
	        request.setAttribute("user_id", pb.getUser_id());
	        request.setAttribute("coupon_num", pb.getCoupon_num());
	        request.setAttribute("point_amount", pb.getPoint_amount());
	        request.setAttribute("total_price", pb.getTotal_price());
	        request.setAttribute("srb", srb2);
	
	        String shopImage = shopDao.getThisShopImage(String.valueOf(rrb.getShop_id()));
	        String roomImage = shopDao.getThisRoomImage(srb);
	
	        request.setAttribute("shopImage", shopImage);
	        request.setAttribute("roomImage", roomImage);
	        request.setAttribute("pb", pb);
	        request.setAttribute("rrb", rrb);
	        request.setAttribute("trb", trb);
	        request.setAttribute("mb", mb);
	        request.setAttribute("rb", rb);
	
	        int total_price = pb.getTotal_price();
	        int point = (int) ((total_price * 3) / 100);
	
	        MemberBean mbForPoint = new MemberBean();
	        mbForPoint.setUser_id(user_id);
	        mbForPoint.setUser_point(point);
	        int cntforPoint = mdao.getPoint(mbForPoint);
	
	        System.out.println("cntforPoint : " + cntforPoint);
	        return gotoPage;
        }
    }
}
