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
public class KakaoInsertController {

    private static final String COMMAND = "kakaoInsert.mb";
    private static final String USER_PAGE = "KakaoInsertForm";
    private static final String REDIRECT_PAGE = "redirect:/loginForm.mb";
  

    @Autowired
    private MemberDao memberDao;

    @Autowired
    private ServletContext servletContext;

    @RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView registForm(@RequestParam(value = "user_type", required = false) String userType) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("user_type", "G"); // Kakao 로그인 사용자는 'G'로 고정
        mav.addObject("member", new MemberBean()); // 회원 객체 초기화
        mav.setViewName(USER_PAGE);
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
