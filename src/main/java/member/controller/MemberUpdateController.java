package member.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MemberUpdateController {
    
    private final String command ="update.mb";
    private final String user_page ="memberUpdateForm";
    private final String business_page ="businessUpdateForm";
    private final String gotoPage="redirect:/memberList.mb";
    private final String memberPage = "redirect:/memberMyPage.mb";

    
    @Autowired
    private MemberDao memberDao;
    @Autowired
    ServletContext servletContext;
    
    // GET: memberList.jsp에서 수정 버튼 클릭시 => updateForm으로 이동
    @RequestMapping(value=command, method =RequestMethod.GET)
    public ModelAndView update(
            @RequestParam(value="user_id", required =true) int user_id,
            @RequestParam(value="pageNumber", required = false) String pageNumber,
            @RequestParam(value="whatColumn", required = false) String whatColumn,
            @RequestParam(value="keyword", required = false) String keyword,
            HttpSession session,
            Model model
            ) {
        
        ModelAndView mav = new ModelAndView();
        
        MemberBean mb = memberDao.getMember(user_id);
        System.out.println("mb.getUser_type() : " + mb.getUser_type());
        
        String user_type = mb.getUser_type();
        model.addAttribute("member", mb);
        
        if ("G".equals(user_type)) {
            mav.addObject("user_type", "G");
        	mav.addObject("pageNumber", pageNumber);
			mav.addObject("whatColumn", whatColumn);
			mav.addObject("keyword", keyword);
            mav.setViewName(user_page);
            System.out.println("333333333333");
        } else {
            mav.addObject("user_type", "B");
        	mav.addObject("pageNumber", pageNumber);
			mav.addObject("whatColumn", whatColumn);
			mav.addObject("keyword", keyword);
            mav.setViewName(business_page);
        }
        return mav;
    }
    
    @RequestMapping(value = command, method = RequestMethod.POST)
    public ModelAndView update(@ModelAttribute("member") @Valid MemberBean mb, BindingResult result,
            @RequestParam(value = "user_type", required = false) String user_type,
            @RequestParam(value = "pageNumber", required = false) String pageNumber,
            @RequestParam(value = "whatColumn", required = false) String whatColumn,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "upload", required = false) MultipartFile upload,
            @RequestParam(value = "upload2", required = false) String upload2, 
            Model model,
            HttpSession session,
            HttpServletRequest request) {
        
		/*
		 * System.out.println("register user_type : " + user_type);
		 * System.out.println("pageNumber: " + pageNumber);
		 * System.out.println("whatColumn: " + whatColumn);
		 * System.out.println("keyword: " + keyword); System.out.println("upload: " +
		 * (upload != null ? upload.getOriginalFilename() : "null"));
		 * System.out.println("upload2: " + upload2);
		 */
           
        ModelAndView mav = new ModelAndView();
        
        // 이미지 처리 로직 추가
        if (upload != null && !upload.isEmpty()) {
            // 새 이미지 업로드 처리
            String newImageName = saveUploadFile(upload);
            mb.setUser_image(newImageName);
        } else {
            // 기존 이미지 유지
            mb.setUser_image(upload2);
        }
        
        if ("B".equals(user_type)) { // 사업자
            if (result.hasErrors()) {
                mav.addObject("user_type", user_type);
                mav.setViewName(business_page);
                return mav;
            }
            // 에러 없으면 업데이트
            int cnt = memberDao.updateBusinessMember(mb);
            if (cnt > 0) {
          	  mav.setViewName("redirect:/logoutSession.mb?user_id=" + mb.getUser_id());
            }
            System.out.println("business update : " + cnt);
            mav.setViewName(memberPage + "?user_id=" + mb.getUser_id() + "&message=updateSuccess");
 // 사업자 회원 페이지로 리다이렉트
        } else { // 일반회원
            if (result.hasErrors()) {
                mav.addObject("user_type", user_type);
                mav.setViewName(user_page);
                System.out.println("user+type" + user_type);
                return mav;
            }
            // 에러 없으면 업데이트
            int cnt = memberDao.updateMember(mb);
            if (cnt > 0) {
            	  mav.setViewName("redirect:/logoutSession.mb?user_id=" + mb.getUser_id());
            }
            System.out.println("user insert : " + cnt);
        }
        return mav;
    }

    private String saveUploadFile(MultipartFile upload) {
        // 업로드된 파일을 저장하고 파일명을 반환하는 로직을 구현합니다.
        // 예시로 파일명을 변경하여 저장하고, 파일명을 반환합니다.
        String uploadPath = servletContext.getRealPath("/resources/images/");
        String originalFilename = upload.getOriginalFilename();
        String newFilename = System.currentTimeMillis() + "_" + originalFilename;
        File file = new File(uploadPath, newFilename);
        try {
            upload.transferTo(file);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return newFilename;
    }
    
    // 회원 정지 여부 업데이트 핸들러 추가
    @RequestMapping(value = "/updateStatus.mb", method = RequestMethod.GET)
    public String updateStatus(
            @RequestParam("user_id") int userId,
            @RequestParam("status") String status,
            @RequestParam("pageNumber") int pageNumber,
            @RequestParam("whatColumn") String whatColumn,
            @RequestParam("keyword") String keyword) {

        memberDao.updateMemberStatus(userId, status);
        return "redirect:/memberList.mb?pageNumber=" + pageNumber + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
    }
}

