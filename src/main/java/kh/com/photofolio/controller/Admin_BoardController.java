package kh.com.photofolio.controller;

import java.io.File;
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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.com.photofolio.dao.Admin_boardDAO;
import kh.com.photofolio.dao.BoardDAO;
import kh.com.photofolio.dao.FileDAO;
import kh.com.photofolio.dto.BoardDTO;
import kh.com.photofolio.dto.FileDTO;
import kh.com.photofolio.service.Admin_boardService;

/**
 * Servlet implementation class Admin_postController
 */
@WebServlet("*.admBo")
//게시물 조회 및 삭제 등의 유저와 관련된 기능을 컨트롤 하는 컨트롤러

public class Admin_BoardController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		actionDo(request, response);
	}
	
	protected void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Admin_boardDAO dao = new Admin_boardDAO();
		Admin_boardService service = new Admin_boardService();
		BoardDAO boardDao = new BoardDAO();
		// 지금 클라이언트로부터 온 요청값을 분리해내는 작업
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		
		if(cmd.equals("/toBoardManagement.admBo")) { //게시물 관리 페이지로 이동
			int currentPage = Integer.parseInt(request.getParameter("currentPage")); // 현재페이지
			System.out.println("넘어온 user currentPage: " + currentPage);
			int recordTotalCnt = 0;
			try {
				recordTotalCnt = dao.getPostListCnt();
			}catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage, recordTotalCnt); // 네비바 시작/끝 숫자, 앞뒤 버튼 여부
			ArrayList<BoardDTO> list = service.printPost((int) naviMap.get("currentPage")); // 해당 번호의 학생들 출력
			if(list!=null) {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_boardManagement.jsp");
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list",list);
				rd.forward(request, response);
			}
		}else if(cmd.equals("/searchProc.admBo")){ //게시물 검색 컨트롤러
			int currentPage = Integer.parseInt(request.getParameter("currentPage")); // 현재 페이지
			System.out.println("넘어온 user currentPage: " + currentPage);
			String search_category = request.getParameter("search_category"); // 검색 카테고리 값
			String value = request.getParameter("search_input"); // 검색어 값
			int recordTotalCnt = 0; // 데이터의 총 갯수
			System.out.println("search_category : " + search_category);
			System.out.println("value : " + value);
//			String search_category = request.getParameter("search_category");
//			System.out.println(search_category);
//			String value = request.getParameter("search_input");
//			System.out.println(value);
			ArrayList<BoardDTO> list = null;
			try {
				if(search_category.equals("post_no")) { //게시물 번호로 검색
					list = service.getPostByPostNo(value, currentPage);
					recordTotalCnt = dao.getPostByPostNoCnt(value);
				}else if(search_category.equals("idOrNickname")) {  //작성자 아이디/닉네임으로 검색
					list = service.getPostByIdOrNickname(value, currentPage);
					recordTotalCnt = dao.getPostByWriterInfoCnt(value);
				}else if(search_category.equals("titleOrContent")) {  //제목/내용으로 검색
					System.out.println("titleOrContent로 진입!");
					list = service.getPostByTitleOrContent(value, currentPage);
					recordTotalCnt = dao.getPostByTitleOrContentCnt(value);
				}
			}catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage, recordTotalCnt);
			if(list!=null) {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_boardManagement.jsp");
				request.setAttribute("list", list); //게시물 정보 list 넘기기
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("search_category", search_category);
				request.setAttribute("value", value);
				rd.forward(request, response);
			}else {
				System.out.println("돌아분다.");
			}
		}else if(cmd.equals("/toDeleteProc.admBo")) {
			String post_no = request.getParameter("post_no");
			System.out.println("삭제될 post_no : "+post_no);
			int rs = 0;
			try {
				rs = dao.deletePost(post_no);
			}catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
			if(rs!=-1) {
				int currentPage = 1;
				int recordTotalCnt = 0;
				try {
					recordTotalCnt = dao.getPostListCnt();
				}catch(Exception e) {
					response.sendRedirect("/error.jsp");
					e.printStackTrace();
				}
				HashMap<String, Object> naviMap = service.getPageNavi(currentPage, recordTotalCnt); // 네비바 시작/끝 숫자, 앞뒤 버튼 여부
				ArrayList<BoardDTO> list = service.printPost((int) naviMap.get("currentPage")); // 해당 번호의 학생들 출력
				if(list!=null) {
					RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_boardManagement.jsp");
					request.setAttribute("rs", "success");					request.setAttribute("naviMap", naviMap);
					request.setAttribute("list",list);
					rd.forward(request, response);
				}else {
					response.sendRedirect("/admin/admin_boardManagement.jsp?rs='fail'");
				}
			}else {
				System.out.println("게시글 삭제 실패");
			}
		}else if (cmd.equals("/toDetailPostByAdmin.admBo")) {
			// seq 번호 넘겨 받아서, 해당하는 게시글 가져온 후
			// detailView.jsp 에 뿌려주기
			
			int post_no = Integer.parseInt(request.getParameter("post_no"));
			System.out.println("post_no : " + post_no);

			/*
			 * // 게시글 조회수 +1 dao.post_viewCount(post_no);
			 */

			try {
			BoardDTO dto = boardDao.selectBySeq(post_no);
			FileDAO daoFile = new FileDAO();
			FileDTO dtoFile = daoFile.getFileNames(post_no); // 파일 가져오는 작업
			System.out.println(dtoFile);

			if (dto != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_postDetail.jsp");
				request.setAttribute("dto", dto);
				request.setAttribute("daoFile", daoFile);
				request.setAttribute("dtoFile", dtoFile);/* 사진경로 */
				rd.forward(request, response);
			}
			}catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
		}else if(cmd.equals("/modifyProc.admBo")){
            FileDAO daoFile = new FileDAO();
			
			String filePath = request.getServletContext().getRealPath("files");
			System.out.println("filePath : " + filePath);
			
			
			File file = new File(filePath);
			if (!file.exists()) { // 파일 폴더가 존재 하지 않다면
				file.mkdir(); // 파일 폴더 생성
			}
			int fileSize = 1024 * 1024 * 50; // 파일 용량 설정
			try {
				MultipartRequest multi = new MultipartRequest(request, filePath, fileSize, "utf-8",
						new DefaultFileRenamePolicy());
//			int currentPage = Integer.parseInt(multi.getParameter("currentPage"));
				int board_no = Integer.parseInt(multi.getParameter("post_no"));
				String post_title = multi.getParameter("post_title");
				String post_content = multi.getParameter("post_content");
				String origin_name = multi.getOriginalFileName("photo_path");
				String system_name = multi.getFilesystemName("photo_path");
				
				// 만약 이미지는 수정하고 싶지 않다면 if문 실행 
				if (origin_name == null || system_name == null) {
					origin_name = daoFile.getOriginName(board_no);
					system_name = daoFile.getSystemName(board_no);

					System.out.println("post_no : " + board_no);
					System.out.println("post_title : " + post_title);
					System.out.println("post_content : " + post_content);
					System.out.println("origin_name : " + origin_name);
					System.out.println("system_name : " + system_name);

					int rs = boardDao.modifyByPost(board_no, post_title, post_content);
					
					if(rs != -1) {
						System.out.println("수정 성공");
					}else {
						System.out.println("수정 실패");
					}
					response.sendRedirect("/toDetailPostByAdmin.admBo?post_no="+board_no);
				
				// 만약 이미지를 수정 한다면 eles if문 실행
				} else if (origin_name != null || system_name != null) {
					int rsFile = daoFile.modifyByPostNo(system_name, origin_name, board_no);
					int rs = boardDao.modifyByPost(board_no, post_title, post_content);
					if (rs != -1 && rsFile != -1) {
						response.sendRedirect("/toDetailPostByAdmin.admBo?post_no="+board_no);
					}
				}

			} catch (Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}

		}else if (cmd.equals("/deleteProc.admBo")) {
			int post_no = Integer.parseInt(request.getParameter("post_no"));
			System.out.println("삭제할 post_no : " + post_no);
			try {
			int rs = boardDao.deleteByPost(post_no);
			if (rs != -1)
				response.sendRedirect("/toBoardManagement.admBo?currentPage=1");
		} catch (Exception e) {
			response.sendRedirect("/error.jsp");
			e.printStackTrace();
		}
	
		
	}
	}
}
