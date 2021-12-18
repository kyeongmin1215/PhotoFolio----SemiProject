package kh.com.photofolio.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.com.photofolio.dao.Admin_memberDAO;
import kh.com.photofolio.dao.MemberDAO;
import kh.com.photofolio.dto.MemberDTO;
import kh.com.photofolio.dto.MemberInfoDTO;
import kh.com.photofolio.service.Admin_memberService;

/**
 * Servlet implementation class Admin_memberController
 */
@WebServlet("*.admMem")
// 어드민 유저 조회 및 탈퇴 등의 유저와 관련된 기능을 컨트롤 하는 컨트롤러

public class Admin_memberController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		actionDo(request, response);
	}

	protected void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Admin_memberDAO dao = new Admin_memberDAO(); // 유저에 관한 메서드를 담당하는 DAO 선언
		Admin_memberService service = new Admin_memberService();

		// 지금 클라이언트로부터 온 요청값을 분리해내는 작업
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());

		
		// 회원 관리 홈페이지로 이동 : 회원 전체 내역이 출력됨.
		if (cmd.equals("/toUserManagement.admMem")) {
			int currentPage = Integer.parseInt(request.getParameter("currentPage")); // 현재페이지
			int recordTotalCnt = 0; //총 데이터 수 : countAll() 메서드로 받아올 것이기 때문에 일단 0값을 주었음.

			try {
				recordTotalCnt = dao.countAll(); //countAll : 전체 회원 수를 얻어오는 메서드
			}catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
			// 전체 데이터 총 갯수
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage, recordTotalCnt); // 네비바 시작/끝 숫자, 앞뒤 버튼 여부
			ArrayList<MemberInfoDTO> list = service.printMember((int) naviMap.get("currentPage")); // 해당 페이지의 학생들 list
			if (list != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_userManagement.jsp"); //회원 관리 jsp로 이동
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list", list);
				rd.forward(request, response);
			}

			// 회원 정보 검색 컨트롤러
		} else if (cmd.equals("/searchProc.admMem")) {
			int currentPage = Integer.parseInt(request.getParameter("currentPage")); // 현재 페이지
			String search_category = request.getParameter("search_category"); // 검색 카테고리 값 : 아이디/닉네임, 이메일, 번호
			String value = request.getParameter("search_input"); // 검색어 정보 : 해당 값을 조회해오기/response해줄 때 검색창 input에 value값 유지시키기 위함.
			int recordTotalCnt = 0; // 데이터의 총 갯수 : 각각의 메서드로 받아올 것.

			ArrayList<MemberInfoDTO> list = new ArrayList<MemberInfoDTO>();
			// 업로드 게시물 수를 담기 위해 UserDTO와 업로드 수를 담은 UserInfoDTO 구성 : UserDTO + 해당 유저의 게시물 업로드 수
			
			try {
				// list => 해당 페이지의 값 얻어오기
				// recordTotalCnt => 해당 데이터 전체 내역의 총 데이터 수 얻어오기
				if (search_category.equals("idOrNickname")) { // 아이디/닉네임 검색
					list = service.getUserByIdOrNickname(value, currentPage); 
					recordTotalCnt = dao.getUserByIdOrNicknameCnt(value); 
				} else if (search_category.equals("email")) { // 이메일 검색
					list = service.getUserByEmail(value, currentPage);
					recordTotalCnt = dao.getUserByEmailCnt(value);
				} else if (search_category.equals("phone")) { // 휴대폰 검색
					list = service.getUserByPhone(value, 1);
					recordTotalCnt = dao.getUserByPhoneCnt(value);
				}
			}catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}		
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage, recordTotalCnt); // 네비바 시작/끝 숫자, 앞뒤 버튼 여부
			if (list != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_userManagement.jsp"); //회원 관리 페이지로 돌아가기
				request.setAttribute("list", list);
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("search_category", search_category); // 검색 기록 다시 띄워주기 위해 검색 카테고리 같이 넘기기
				request.setAttribute("value", value); // 검색 기록을 다시 띄워주기 위해 검색어 같이 넘기기
				rd.forward(request, response);
			}

		}else if (cmd.equals("/toDeleteProc.admMem")) { //탈퇴 버튼을 눌렀을 때
			String users = request.getParameter("users"); //선택된 회원들을 => '회원1','회원2' 형태의 문자열로 가져옴
			int rs = 0;
			try {
				rs = dao.deleteUser(users); // 삭제 성공 여부
			}catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
			if (rs != -1) { //성공한 경우 회원 정보 첫 페이지로 이동
				System.out.println("유저 삭제 성공");
				int currentPage = 1; // 현재페이지
				int recordTotalCnt = 0; //총 데이터 수 : countAll() 메서드로 받아올 것이기 때문에 일단 0값을 주었음.

				try {
					recordTotalCnt = dao.countAll(); //countAll : 전체 회원 수를 얻어오는 메서드
				}catch(Exception e) {
					response.sendRedirect("/error.jsp");
					e.printStackTrace();
				}
				// 전체 데이터 총 갯수
				HashMap<String, Object> naviMap = service.getPageNavi(currentPage, recordTotalCnt); // 네비바 시작/끝 숫자, 앞뒤 버튼 여부
				ArrayList<MemberInfoDTO> list = service.printMember((int) naviMap.get("currentPage")); // 해당 페이지의 학생들 list
				if (list != null) {
					RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_userManagement.jsp"); //회원 관리 jsp로 이동
					request.setAttribute("rs", "success");
					request.setAttribute("naviMap", naviMap);
					request.setAttribute("list", list);
					rd.forward(request, response);
				}
			}else {
				response.sendRedirect("/toUserManagement.admMem?rs='fail'");
			}
		}else if(cmd.equals("/toUserInfo.admMem")) {
			MemberDAO memberDao = new MemberDAO();
	    	String id = request.getParameter("id");
	    	System.out.println("id : "+id);
	    	System.out.println(id);
			try {
				MemberDTO dto = memberDao.selectById(id);
				System.out.println("dto.getUser_id()"+dto.getUser_id());
				if(dto != null) {
					RequestDispatcher rd = request.getRequestDispatcher("/member/userInfo.jsp");
					request.setAttribute("dto", dto);
					rd.forward(request, response);
				}
			} catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
		}
	}
}
