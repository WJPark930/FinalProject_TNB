package member.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MemberInsertuserController {

    private static final String COMMAND = "/insertuser.mb";
    private static final String USER_PAGE = "memberInsertForm";
    private static final String BUSINESS_PAGE = "businessInsertForm";
    private static final String REDIRECT_PAGE = "redirect:/loginForm.mb";
    
    
    @Autowired
    private MemberDao memberDao;

    @Autowired
    private ServletContext servletContext;

    @RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView registForm(@RequestParam(value="user_type", required=false) String userType) {
        ModelAndView mav = new ModelAndView();
        if ("G".equals(userType)) {
            mav.addObject("user_type", "G");
            mav.setViewName(USER_PAGE);
        } else {
            mav.addObject("user_type", "B");
            mav.setViewName(BUSINESS_PAGE);
        }
        mav.addObject("member", new MemberBean()); // 이 부분을 추가하여 폼에 대한 초기화를 수행합니다.

        return mav;
    }

    @RequestMapping(value = COMMAND, method = RequestMethod.POST)
    public ModelAndView register(@ModelAttribute("member") @Valid MemberBean member,
                                 BindingResult result, 
                                 HttpServletRequest request,
                                 @RequestParam(value = "user_type", required = false) String user_type,
                                 Model model,HttpServletResponse response) throws IOException {
        ModelAndView mav = new ModelAndView();
        response.setContentType("text/html; charset=UTF-8");
        MultipartFile multi = member.getUpload();

        if (result.hasErrors()) {
            mav.addObject("user_type", user_type);
            mav.setViewName("G".equals(user_type) ? USER_PAGE : BUSINESS_PAGE);
            return mav;
        }

        // 비밀번호 확인 로직
        if (!member.getUser_passwd().equals(member.getUser_passwd())) {
            model.addAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
            mav.addObject("user_type", user_type);
            mav.setViewName("G".equals(user_type) ? USER_PAGE : BUSINESS_PAGE);
            return   mav;
        }

        // 이메일 중복 체크
        if (memberDao.checkDuplicateEmail(member.getUser_email())) {
          //  model.addAttribute("errorMessage", "이미 가입된 이메일입니다.");
            mav.addObject("user_type", user_type);
            mav.setViewName("G".equals(user_type) ? USER_PAGE : BUSINESS_PAGE);
            return   mav;
        }

        // 닉네임 중복 체크
        if (memberDao.checkDuplicateNickname(member.getUser_nickname())) {
           // model.addAttribute("errorMessage", "이미 사용중인 닉네임입니다.");
            mav.addObject("user_type", user_type);
            mav.setViewName("G".equals(user_type) ? USER_PAGE : BUSINESS_PAGE);
            return   mav;
        }

        // 프로필 이미지 처리
        if (!multi.isEmpty()) {
            String uploadPath = servletContext.getRealPath("/resources/images");
            File destination = new File(uploadPath, multi.getOriginalFilename());
            try {
                multi.transferTo(destination);
                member.setUser_image(multi.getOriginalFilename());
            } catch (IOException e) {
                e.printStackTrace();
                mav.setViewName(USER_PAGE);
                return mav;
            }
        } else {
            // 파일이 선택되지 않은 경우 기본 이미지 설정
            member.setUser_image("default.jpg");
        }

	
		  memberDao.insertMember(member); 
		  // 회원가입 성공 시 한 번만 출력할 메시지 설정
	        mav.setViewName(REDIRECT_PAGE);
	        
	        return mav;
    }

    @RequestMapping(value = "/checkEmail.mb", method = RequestMethod.GET)
    @ResponseBody
    public String checkEmail(@RequestParam("user_email") String user_email) {
        boolean isDuplicate = memberDao.checkDuplicateEmail(user_email);
        return String.valueOf(isDuplicate);
    }

    @RequestMapping(value = "/checkNickname.mb", method = RequestMethod.GET)
    @ResponseBody
    public String checkNickname(@RequestParam("user_nickname") String user_nickname) {
        boolean isDuplicate = memberDao.checkDuplicateNickname(user_nickname);
        return String.valueOf(isDuplicate);
    }
    
    
    
}
