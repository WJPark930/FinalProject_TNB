package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberMypageController {

	private final String command = "memberMyPage.mb";
	private final String gotoPage = "memberMyPage";
	
	
	@RequestMapping(value=command,method= RequestMethod.GET)
	public String gotoMyPage(
			HttpSession session) {
		if(session.getAttribute("loginInfo")==null) {
			session.setAttribute("destination","redirect:/memberinsert.mb");
			return "redirect:/memberLoginForm.mb";
		}else {
			
			
			return gotoPage;
		}
	}
}
	
//		  // 회원 정보 수정 처리
//	    @RequestMapping(value = "/updateForm.mb", method = RequestMethod.POST)
//	    public ModelAndView updateMember(HttpServletRequest request, HttpServletResponse response) {
//	        ModelAndView mav = new ModelAndView();
//	        // 회원 정보 수정 로직 수행
//	        // memberService.updateMember(memberInfo); // 회원 정보 업데이트 서비스 호출
//	        mav.setViewName("redirect:/memberMyPage.mb"); // 마이페이지 메인 화면으로 리다이렉트
//	        return mav;
//	    }
//	}	
/*
			
	private final String getPage = "memberMyPage";
	private final String command = "memberMyPage.mb";

    // 회원 마이페이지 메인 화면
    @RequestMapping()
    public ModelAndView mypageMain(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        // 여기서 필요한 작업 수행 (예: 회원 정보 조회, 예약 확인 등)
        // mav.addObject("memberInfo", memberService.getMemberInfo(memberId)); // 예시: 회원 정보 조회 서비스 호출
        mav.setViewName(getPage); // main.jsp와 같은 뷰 페이지 지정
        return mav;
    }

    // 회원 정보 수정 페이지 이동
    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public ModelAndView updateMemberForm(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        // 필요한 작업 수행
        // mav.addObject("memberInfo", memberService.getMemberInfo(memberId)); // 회원 정보 조회 서비스 호출
        mav.setViewName("memberMypage/updateForm"); // updateForm.jsp와 같은 뷰 페이지 지정
        return mav;
    }

    // 회원 정보 수정 처리
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ModelAndView updateMember(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        // 회원 정보 수정 로직 수행
        // memberService.updateMember(memberInfo); // 회원 정보 업데이트 서비스 호출
        mav.setViewName("redirect:/memberMypage"); // 마이페이지 메인 화면으로 리다이렉트
        return mav;
    }

    // 예약 확인 페이지 이동
    @RequestMapping(value = "/reservation", method = RequestMethod.GET)
    public ModelAndView reservationCheck(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        // 예약 확인 관련 작업 수행
        mav.setViewName("memberMypage/reservationCheck"); // reservationCheck.jsp와 같은 뷰 페이지 지정
        return mav;
    }

    // 리뷰 내역 조회 페이지 이동
    @RequestMapping(value = "/reviewHistory", method = RequestMethod.GET)
    public ModelAndView reviewHistory(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        // 리뷰 내역 조회 관련 작업 수행
        mav.setViewName("memberMypage/reviewHistory"); // reviewHistory.jsp와 같은 뷰 페이지 지정
        return mav;
    }

    // 커뮤니티 페이지 이동
    @RequestMapping(value = "/community", method = RequestMethod.GET)
    public ModelAndView community(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        // 커뮤니티 관련 작업 수행
        mav.setViewName("memberMypage/community"); // community.jsp와 같은 뷰 페이지 지정
        return mav;
    }
    
    */


