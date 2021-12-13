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

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.com.photofolio.dao.BoardDAO;
import kh.com.photofolio.dao.FileDAO;
import kh.com.photofolio.dao.FollowDAO;
import kh.com.photofolio.dao.LikeDAO;
import kh.com.photofolio.dao.MemberDAO;
import kh.com.photofolio.dto.BoardDTO;
import kh.com.photofolio.dto.BoardInfoDTO;
import kh.com.photofolio.dto.FileDTO;
import kh.com.photofolio.dto.FollowDTO;
import kh.com.photofolio.dto.MemberDTO;
import kh.com.photofolio.service.BoardService;

@WebServlet("*.bo")
public class BoardController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 공동 설정
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession(); // 세션 객체
		BoardDAO dao = new BoardDAO();
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		System.out.println("요청 uri : " + cmd);

		// 게시글 추가 페이지로 이동
		if (cmd.equals("/toInsertPost.bo")) {
			HashMap<String, String> map =(HashMap)session.getAttribute("loginSession");
	    	String id = map.get("user_id");
	    	
	    	RequestDispatcher rd = request.getRequestDispatcher("/board/insertPost.jsp");
			request.setAttribute("id", id);
			rd.forward(request, response);


			
		// 유저 페이지로 이동	
		} else if (cmd.equals("/toUserPage.bo")) { 
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			HashMap<String, String> map =(HashMap)session.getAttribute("loginSession");
			String id = map.get("user_id");
//			int post_no = Integer.parseInt(request.getParameter("post_no"));
			System.out.println("currentPage : " + currentPage);
//			System.out.println("post_no : " + post_no);
			MemberDAO mdao = new MemberDAO();
			
			// ================================================
			
			BoardService service = new BoardService();
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage);
			ArrayList<BoardDTO> list = service.getBoardList((int) naviMap.get("currentPage"));
			FileDAO daoFile = new FileDAO();
			try {
				MemberDTO mdto = mdao.selectById(id);
				request.setAttribute("mdto", mdto);
			} catch (Exception e) {
				e.printStackTrace();
			}
			ArrayList<FileDTO> file_list = daoFile.selectAll(id);
			ArrayList<BoardDTO> board_list = dao.selectById(id);
			
			// ================================================
			
//			BoardDTO dto = dao.selectBySeq(post_no);
//			FileDAO daoFile = new FileDAO();
//			FileDTO dtoFile = daoFile.getFileNames(post_no);
			
			// ================================================
			
			
//			if (list != null && dto != null) {
//				RequestDispatcher rd = request.getRequestDispatcher("/board/userPage.jsp");
//				request.setAttribute("naviMap", naviMap);
//				request.setAttribute("list", list);
//				
//				// ================================================
//				
//				request.setAttribute("dto", dto);
//				request.setAttribute("dtoFile", dtoFile);
//				request.setAttribute("currentPage", currentPage);
//				
//				rd.forward(request, response);
//			
//			}

			
//			int post_no = Integer.parseInt(request.getParameter("post_no"));
//			dao.post_viewCount(post_no);
//			int post_no = Integer.parseInt(request.getParameter("post_no"));
//			BoardDTO dto = dao.selectBySeq(post_no);
//			FileDAO daoFile = new FileDAO();
//			FileDTO dtoFile = daoFile.getFileNames(post_no);
//
//			if (dto != null) {
//				RequestDispatcher rd = request.getRequestDispatcher("/board/userPage.jsp");
//				request.setAttribute("dto", dto);
//				request.setAttribute("dtoFile", dtoFile);
//				request.setAttribute("currentPage", currentPage);
//				rd.forward(request, response);
//			}

			/********** 팔로우 관련 **********/
			FollowDAO daoFollow = new FollowDAO();
			try { // 팔로워, 팔로우 유저 수를 가져옴
				int countFollower = daoFollow.countFollower(map.get("user_id"));
				int countFollowing = daoFollow.countFollowing(map.get("user_id"));
				request.setAttribute("countFollower", countFollower);
				request.setAttribute("countFollowing", countFollowing);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if (list != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/board/userPage.jsp");
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list", list);
				request.setAttribute("file_list", file_list);
				request.setAttribute("board_list", board_list); //게시글정보
				rd.forward(request, response);
			
			}
			
//			if (list != null && dto != null) {
//				RequestDispatcher rd = request.getRequestDispatcher("/board/userPage.jsp");
//				request.setAttribute("naviMap", naviMap);
//				request.setAttribute("list", list);
//				
//				// ================================================
//				
//				request.setAttribute("dto", dto);
//				request.setAttribute("dtoFile", dtoFile);
//				request.setAttribute("currentPage", currentPage);
//				
//				rd.forward(request, response);
//			
//			}

			
//			int post_no = Integer.parseInt(request.getParameter("post_no"));
//			dao.post_viewCount(post_no);
//			int post_no = Integer.parseInt(request.getParameter("post_no"));
//			BoardDTO dto = dao.selectBySeq(post_no);
//			FileDAO daoFile = new FileDAO();
//			FileDTO dtoFile = daoFile.getFileNames(post_no);
//
//			if (dto != null) {
//				RequestDispatcher rd = request.getRequestDispatcher("/board/userPage.jsp");
//				request.setAttribute("dto", dto);
//				request.setAttribute("dtoFile", dtoFile);
//				request.setAttribute("currentPage", currentPage);
//				rd.forward(request, response);
//			}
			
		 //인덱스에서 다른유저 프로필을 클릭했을 시에 유저페이지로 이동
		}else if(cmd.equals("/indToUser.bo")) {
			HashMap<String, String> map = (HashMap)session.getAttribute("loginSession");
			System.out.println("map값 : " + map);
			if(map == null) {
				response.sendRedirect("/member/login.jsp");
			}else {
			String user_id = request.getParameter("user_id");
			int currentPage = (Integer.parseInt(request.getParameter("currentPage")));
			System.out.println(" 페이지값 : " + currentPage);
			System.out.println("유저 아이디 : " + user_id);
			
			MemberDAO mdao = new MemberDAO();
			BoardService service = new BoardService();
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage);
			ArrayList<BoardDTO> list = service.getBoardList((int) naviMap.get("currentPage"));
			try {
				MemberDTO mdto = mdao.selectById(user_id);
				System.out.println("mdto : " + mdto);
				request.setAttribute("mdto", mdto);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			FileDAO daoFile = new FileDAO();
			ArrayList<FileDTO> file_list = daoFile.selectAll(user_id);
			ArrayList<BoardDTO> board_list = dao.selectById(user_id);
			
			/********** 팔로우 관련 **********/
			FollowDAO daoFollow = new FollowDAO();
			try { // 팔로워, 팔로우 유저 수를 가져옴
				int countFollower = daoFollow.countFollower(user_id);
				int countFollowing = daoFollow.countFollowing(user_id);
				request.setAttribute("countFollower", countFollower);
				request.setAttribute("countFollowing", countFollowing);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if (list != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/board/userPage.jsp");
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list", list); 
				request.setAttribute("file_list", file_list); //사진정보+게시글정보
				request.setAttribute("board_list", board_list);
				rd.forward(request, response);
			
			}
			
			}
			
			// 게시글 추가	
		}else if (cmd.equals("/insertProc.bo")) {
			// 아이디, 닉네임 값 가져오기
			HashMap<String,String> loginSession = (HashMap)session.getAttribute("loginSession");
			String post_writer = loginSession.get("user_id");
			String post_writer_nickname = loginSession.get("user_nickname");
			System.out.println(post_writer + " : " + post_writer_nickname);

			// 파일 영역
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

				// 게시글 제목, 내용 가져오기
				String post_title = multi.getParameter("post_title");
				String post_content = multi.getParameter("post_content");
				int category_no = Integer.parseInt(multi.getParameter("category_no"));
				System.out.println("post_title : " + post_title);
				System.out.println("post_content : " + post_content);
				System.out.println("category_no : " + category_no);

				// 게시글 번호(post_no) 메서드화 시킨후 가져오기
				int post_no = dao.getSequence();
				System.out.println("post_no : " + post_no);
				// 이 시퀀스를 게시글 insert, 파일 insert 시 모두 사용
				int rs = dao.insert(new BoardDTO(post_no, post_writer, post_writer_nickname, post_title, post_content,
						null, 0, category_no));

				String origin_name = multi.getOriginalFileName("photo_path");
				String system_name = multi.getFilesystemName("photo_path");
				System.out.println("origin_name : " + origin_name);
				System.out.println("system_name : " + system_name);

				// 파일 저장은 따로 테이블 생성후 저장
				FileDAO daoFile = new FileDAO();
				int rsFile = daoFile.insertFile(post_no, origin_name, system_name);

				// 게시글 등록과 파일이 등록 되면 userPage 호출
				if (rs != -1 && rsFile != -1) {
					response.sendRedirect("/toUserPage.bo?currentPage=1");
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

			
		// 게시글 수정
		}else if (cmd.equals("/modifyProc.bo")) {
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

					int rs = dao.modifyByPost(board_no, post_title, post_content);
					
					if(rs != -1) {
						System.out.println("수정 성공");
					}else {
						System.out.println("수정 실패");
					}
					response.sendRedirect("/toDetailPost.bo?post_no="+board_no);
				
				// 만약 이미지를 수정 한다면 eles if문 실행
				} else if (origin_name != null || system_name != null) {
					int rsFile = daoFile.modifyByPostNo(system_name, origin_name, board_no);
					int rs = dao.modifyByPost(board_no, post_title, post_content);
					if (rs != -1 && rsFile != -1) {
						response.sendRedirect("/toDetailPost.bo?post_no="+board_no);
					}
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		// 게시글 삭제
		} else if (cmd.equals("/deleteProc.bo")) {
			int post_no = Integer.parseInt(request.getParameter("post_no"));
			System.out.println("삭제할 post_no : " + post_no);

			int rs = dao.deleteByPost(post_no);
			if (rs != -1)
				response.sendRedirect("/toUserPage.bo?currentPage=1");

			
		// 게시글 상세 조회(비로그인시 진입X)
		} else if (cmd.equals("/toDetailPost.bo")) {
			HashMap<String, String> map = (HashMap)session.getAttribute("loginSession");
			System.out.println("map값 : " + map);
			if(map == null) {
				response.sendRedirect("/member/login.jsp");
			}else {
			// seq 번호 넘겨 받아서, 해당하는 게시글 가져온 후
			// detailView.jsp 에 뿌려주기
			int post_no = Integer.parseInt(request.getParameter("post_no"));
			System.out.println("post_no : " + post_no);

			// 게시글 조회수 +1
			dao.post_viewCount(post_no);

			BoardDTO dto = dao.selectBySeq(post_no);
			FileDAO daoFile = new FileDAO();
			FileDTO dtoFile = daoFile.getFileNames(post_no); // 파일 가져오는 작업
			System.out.println(dtoFile);
			
			/********** 좋아요 & 팔로우 관련 ***********/
			
			// 좋아요 관련 
			
			String user_id = map.get("user_id");
			LikeDAO daoLike = new LikeDAO();
			
			// 팔로우 관련
			FollowDAO daoFollow = new FollowDAO();
			
			try { // DAO 메서드 몰아넣기
				// 좋아요 눌렀는지 확인
				if(daoLike.btnLikeCheck(user_id, post_no)) {
					System.out.println("해당 게시물에 좋아요를 누른 적 있음");
					request.setAttribute("likeCheck", true);
				} else {
					System.out.println("해당 게시물에 좋아요를 누른 적 없음");
					request.setAttribute("likeCheck", false);
				}
				
				// 좋아요 수 가져오기
				int rs = daoLike.cntLike(post_no);
				request.setAttribute("totalCount", rs);
				
				// 팔로우 했는지 확인
				if(daoFollow.checkFollow(dto.getPost_writer(), user_id)) {
					System.out.println("팔로우 했음");
					request.setAttribute("checkFollow", true);
				} else {
					System.out.println("팔로우 하지 않음");
					request.setAttribute("checkFollow", false);
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			/**********************************/
			
			if (dto != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/board/postDetail.jsp");
				request.setAttribute("dto", dto);
				request.setAttribute("daoFile", daoFile);
				request.setAttribute("dtoFile", dtoFile);/*사진경로*/
				rd.forward(request, response);
			}
		}
		}
		// 좋아요 처리
		else if(cmd.equals("/goodCountProc.bo")) {
			// 수신 확인
			HashMap<String, String> map = (HashMap)session.getAttribute("loginSession");
			String user_id = map.get("user_id");
			int goodCount = Integer.parseInt(request.getParameter("goodCount"));
			int post_no = Integer.parseInt(request.getParameter("postNo"));
			System.out.println("user_id : " + user_id);
			System.out.println("oodCount : " + goodCount);
			System.out.println("post_no : " + post_no);
			// 조건 판별 & 처리 메서드 호출
			LikeDAO daoLike = new LikeDAO(); // DAO
			int totalCount = 0; // 반환값으로 총 좋아요 수를 담을 공간
			try {
				if(goodCount == 1 && daoLike.addLike(user_id, post_no) > 0) {
					System.out.println("좋아요 +1 성공");
					totalCount = daoLike.cntLike(post_no); // 총 좋아요 수 
				} else if(goodCount == -1 && daoLike.removeLike(user_id, post_no) > 0) {
					System.out.println("좋아요 -1 성공");
					totalCount = daoLike.cntLike(post_no);
				} else {
					System.out.println("좋아요 처리 실패");
				}
				// 좋아요 수 반환
				response.getWriter().write(Integer.toString(totalCount));
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		// 팔로우, 언팔 처리(ajax콜백 X)
		else if(cmd.equals("/followProc.bo")) {
			// 수신 확인
			HashMap<String, String> map = (HashMap)session.getAttribute("loginSession");
			String follower_id = map.get("user_id");
			String following_id = request.getParameter("writer");
			int followCount = Integer.parseInt(request.getParameter("followCount"));
			System.out.println("follower_id : " + follower_id);
			System.out.println("following_id : " + following_id);
			System.out.println("followCount : " + followCount);
			// 조건 판별 & 처리 메서드 호출
			FollowDAO daoFollow = new FollowDAO(); // DAO
			try {
				if(followCount == 1 && daoFollow.addFollow(following_id, follower_id) > 0) {
					System.out.println("팔로우 완료");
				} else if(followCount == -1 && daoFollow.removeFollow(following_id, follower_id) > 0) {
					System.out.println("언팔 성공");
				} else {
					System.out.println("팔로우 처리 실패");
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		// user가 팔로우하는 유저 목록 가져오기
		else if(cmd.equals("/getListFollowingProc.bo")) {
			// 수신 확인
			String user_id = request.getParameter("user_id");
			System.out.println("user_id : " + user_id);
			// id에 해당하는 팔로워 목록 가져오기
			FollowDAO daoFollow = new FollowDAO();
			try {
				response.setContentType("html/text; charset=utf-8");
				ArrayList<FollowDTO> list = daoFollow.getListFollowing(user_id);
				Gson gson = new Gson();
				String rs = gson.toJson(list);
				System.out.println(rs); // json데이터 확인
				response.getWriter().write(rs);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		// user를 팔로우하는 유저 목록 가져오기
		else if(cmd.equals("/getListFollowerProc.bo")) {
			// 수신 확인
			String user_id = request.getParameter("user_id");
			System.out.println("user_id : " + user_id);
			// id에 해당하는 팔로워 목록 가져오기
			FollowDAO daoFollow = new FollowDAO();
			try {
				response.setContentType("html/text; charset=utf-8");
				ArrayList<FollowDTO> list = daoFollow.getListFollower(user_id);
				Gson gson = new Gson();
				String rs = gson.toJson(list);
				System.out.println(rs); // json데이터 확인
				response.getWriter().write(rs);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		// 팔로우 여부 확인
		else if(cmd.equals("/checkFollowProc.bo")) {
			// 수신 확인
			HashMap<String, String> map = (HashMap)session.getAttribute("loginSession");
			String follower_id = map.get("user_id");
			String following_id = request.getParameter("id");
			System.out.println("follower_id : " + follower_id);
			System.out.println("following_id : " + following_id);
			// 메서드 호출
			FollowDAO daoFollow = new FollowDAO();
			try {
				if(daoFollow.checkFollow(following_id, follower_id)) {
					response.getWriter().write("true"); 
				} else {
					response.getWriter().write("false");
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}else if (cmd.equals("/toSearchByIdOrNickname.bo")) {
			System.out.println("/toSearchByIdOrNickname.bo진입");
			String inputVal = request.getParameter("inputVal");
			System.out.println("inputVal : " + inputVal);
			ArrayList<BoardInfoDTO> list = new ArrayList<>();
			try {
				list = dao.getBoardByWriter(inputVal);
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.setCharacterEncoding("utf-8");

			RequestDispatcher rd = request.getRequestDispatcher("/main.jsp");
			request.setAttribute("list", list);
			rd.forward(request, response);
			
		} else if (cmd.equals("/toSearchByCategory.bo")) {
			System.out.println("/toSearchByCategory.bo진입");
			int Category_no = (Integer.parseInt(request.getParameter("category_no")));
			System.out.println("카테고리번호 : " + Category_no);
			ArrayList<BoardInfoDTO> list = new ArrayList<>();
			try {
				list = dao.getBoardByCategory(Category_no);
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.setCharacterEncoding("utf-8");

			RequestDispatcher rd = request.getRequestDispatcher("/main.jsp");
			request.setAttribute("list", list);
			rd.forward(request, response);
			
		}
	}
}
