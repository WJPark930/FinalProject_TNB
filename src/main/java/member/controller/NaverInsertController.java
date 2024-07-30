package member.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
public class NaverInsertController {

    private static final String COMMAND = "naverInsert.mb";
    private static final String USER_PAGE = "naverInsertForm";
    private static final String REDIRECT_PAGE = "redirect:/main.jsp";
    private final String gotoMyPage = "../../main";

    @Autowired
    private MemberDao memberDao;

    @Autowired
    private ServletContext servletContext;

    @RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView registForm(@RequestParam(value = "user_type", required = false) String userType,
    		@RequestParam(value = "user_email", required = false) String user_email,
    		@RequestParam(value = "user_name", required = false) String user_name,
    		HttpSession session, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        
//        // 사용자가 이미 등록되어 있는지 확인
//        if (user_email != null && memberDao.findByEmail(user_email)) {
//            // 사용자가 이미 등록되어 있다면 메인 페이지로 리다이렉트
//            mav.setViewName(MAIN_PAGE);
//            return mav;
//        }

        // 사용자가 등록되지 않은 경우 회원 가입 폼으로 이동
        mav.addObject("user_type", "G"); // Kakao 로그인 사용자는 'G'로 고정
       // mav.addObject("member", new MemberBean()); // 회원 객체 초기화
        
        System.out.println("NaverInsertController user_email : " + user_email);
        System.out.println("NaverInsertController user_name : " + user_name);

        MemberBean mb = memberDao.findByEmail(user_email);
		if(mb == null) {
			System.out.println("새로 정보 입력받아야 함");
			mav.addObject("user_name", user_name);
			mav.addObject("user_email", user_email);
			mav.setViewName(USER_PAGE);
		} else {
			
			System.out.println("이미 가입된 회원");
			session.setAttribute("loginInfo", mb);
			mav.setViewName(gotoMyPage);
		}
        
    
     return mav;
    }

    
    
    @RequestMapping(value = COMMAND, method = RequestMethod.POST)
    public ModelAndView register(@ModelAttribute("member") @Valid MemberBean member, BindingResult result,
            HttpServletRequest request, @RequestParam(value = "user_type", required = false) String user_type,
            Model model, HttpServletResponse response) throws IOException {

        ModelAndView mav = new ModelAndView();
        response.setContentType("text/html; charset=UTF-8");
        MultipartFile multi = member.getUpload();

        if (result.hasErrors()) {
            mav.addObject("user_type", user_type);
            mav.setViewName(USER_PAGE);
            return mav;
        }

        // 비밀번호 확인
        if (!member.getUser_passwd().equals(member.getUser_passwd())) {
            model.addAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
            mav.addObject("user_type", user_type);
            mav.setViewName(USER_PAGE);
            return mav;
        }


        // 닉네임 중복 체크
        if (memberDao.checkDuplicateNickname(member.getUser_nickname())) {
            model.addAttribute("errorMessage", "이미 사용중인 닉네임입니다.");
            mav.addObject("user_type", user_type);
            mav.setViewName(USER_PAGE);
            return mav;
        }

        // 프로필 이미지 처리
        if (!multi.isEmpty()) {
            String uploadPath = servletContext.getRealPath("/resources/images");
            File destination = new File(uploadPath, multi.getOriginalFilename());
            try {
                multi.transferTo(destination);
                member.setUser_image(multi.getOriginalFilename()); // 회원 객체에 이미지 파일명 설정
            } catch (IOException e) {
                e.printStackTrace();
                mav.setViewName(USER_PAGE);
                return mav;
            }
        } else {
            // 이미지 파일이 업로드되지 않은 경우, 기본 이미지 설정
            member.setUser_image("default.jpg");
        }

        // 회원 유형 설정 - Kakao 로그인 사용자는 'G'로 고정
        member.setUser_type("G");

        // 회원 정보를 데이터베이스에 등록
        memberDao.insertMember(member);

        // 회원 가입 성공 후 로그인 페이지로 리다이렉트
        mav.setViewName(REDIRECT_PAGE);
        return mav;
    }



}
