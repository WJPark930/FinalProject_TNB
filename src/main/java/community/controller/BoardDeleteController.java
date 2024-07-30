package community.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import community.model.BoardDao;
import member.model.MemberBean;

@Controller
public class BoardDeleteController {
	private final String command = "/delete.bd";

	@Autowired
	BoardDao bdao;

	@RequestMapping(value = command, method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doAction(@RequestParam(value="bid", required=true) int bid,
			@RequestParam(value="passwd", required=true) String passwd,
			@RequestParam(value="pageNumber", required=false) String pageNumber,
			HttpSession session) {
		Map<String, Object> response = new HashMap<String, Object>();

		// 로그인 정보 가져오기
		MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");
		if (loginInfo == null) {
			System.out.println("로그인 정보가 없음.");
		}

		int boardUserId = bdao.getBoardUserId(bid);
//		System.out.println("게시물 작성자 아이디 : " + boardUserId);

		int currentUserId = loginInfo.getUser_id();
		String AdminId = loginInfo.getUser_email();

		// 권한 확인(게시물 작성자가 현재 로그인 세션정보의 아이디와 게시물 작성자 아이디와 일치하거나, 관리자(admin)일 때만 삭제 가능하도록 구현
		if(currentUserId == boardUserId || AdminId.equals("admin")) {
			int result = bdao.deleteArticle(bid, passwd);

			if (result == 1) { // 비밀번호가 일치하고 삭제 성공
				response.put("success", true);
			} else { // 비밀번호 불일치 또는 삭제 실패
				response.put("success", false);
			}
		}

		return response;
	}
}