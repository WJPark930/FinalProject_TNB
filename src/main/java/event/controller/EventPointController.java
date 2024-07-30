package event.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class EventPointController {
    private final String command = "eventPoint.ev";
    private final String gotoPage = "redirect:/eventList.ev";
    private final String loginPage = "redirect:/loginForm.mb";
    
    @Autowired
    private MemberDao mdao;
    
    @Autowired
    ServletContext servletContext;
    
    @RequestMapping(command)
    public void getPoint(@RequestParam(value = "user_point", required = true) int user_point, HttpServletResponse response, HttpSession session) throws IOException {
        
        MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        if (loginInfo == null) {
            // 로그인하지 않은 경우
            String loginPageUrl = servletContext.getContextPath() + "/loginForm.mb";
            out.println("<script>alert('로그인 후 이용해주세요.'); location.href='" + loginPageUrl + "';</script>");
            out.flush();
            return;
        } else {
            int user_id = loginInfo.getUser_id();
            
            System.out.println("user_point : " + user_point);
            MemberBean mb = new MemberBean();
            mb.setUser_id(user_id);
            mb.setUser_point(user_point);
            
            int cnt = mdao.getPoint(mb);
            
            if (cnt > 0) {
                System.out.println("point increase success");
                out.println("<script>alert('포인트 지급되었습니다'); location.href='eventList.ev';</script>");
            } else {
                out.println("<script>alert('포인트 지급 실패'); location.href='eventList.ev';</script>");
            }
            
            out.flush();
        }
    }
}
