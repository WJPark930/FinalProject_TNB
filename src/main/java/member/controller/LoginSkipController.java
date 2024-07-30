package member.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class LoginSkipController {
    
    @Autowired
    MemberDao memberDao;
    
    @RequestMapping(value="/LoginSessionSkip.mb")
    public ModelAndView SkipSession(@RequestParam(value="user_id", required= false) int user_id,
                                  Model model,
                                  HttpSession session) {
    	ModelAndView mav = new ModelAndView();
        MemberBean mb = memberDao.getMember(user_id);
         session.setAttribute("loginInfo", mb);
         // 리다이렉트 URL을 설정합니다.
         mav.setViewName("redirect:/update.mb?user_id="+user_id);
         return mav;
    }
}
