package event.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import event.model.CouponBean;
import event.model.CouponDao;
import member.model.MemberBean;

@Controller
public class EventCouponController {
    private final String command = "eventCoupon.ev";
    private final String gotoMyCouponList = "redirect:/showAllMyCoupon.ev";
    private final String loginPage = "/loginForm.mb";  

    @Autowired
    private CouponDao cdao;

    @Autowired
    ServletContext servletContext;

    @RequestMapping(command)
    public void getCoupon(@ModelAttribute("coupon") CouponBean coupon, HttpServletResponse response, HttpSession session) throws IOException {
        MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");

        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        if (loginInfo == null) {
            String contextPath = servletContext.getContextPath();
            response.sendRedirect(contextPath + loginPage);
            return; 
        } else {
            int user_id = loginInfo.getUser_id();
            coupon.setUser_id(user_id);

            boolean flag = cdao.didIGetCoupon(coupon);

            PrintWriter out = response.getWriter();
            if (flag) {
                out.println("<script>alert('이미 참여한 이벤트입니다'); location.href='showAllMyCoupon.ev';</script>");
            } else {
                int cnt = cdao.getThisCoupon(coupon);
                if (cnt > 0) {
                    out.println("<script>alert('쿠폰 발급받았습니다'); location.href='showAllMyCoupon.ev';</script>");
                } else {
                    out.println("<script>alert('쿠폰 발급에 실패했습니다'); location.href='showAllMyCoupon.ev';</script>");
                }
            }
            out.flush();
        }
    }
}
