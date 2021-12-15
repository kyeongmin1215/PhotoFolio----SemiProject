package kh.com.photofolio.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kh.com.photofolio.dao.BoardDAO;
import kh.com.photofolio.dao.CommentDAO;
import kh.com.photofolio.dao.NotiDAO;
import kh.com.photofolio.dto.CommentDTO;
import kh.com.photofolio.dto.CommentPlusDTO;
import kh.com.photofolio.dto.NotiDTO;

@WebServlet("*.co")
public class CommentController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	public void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 공동 설정
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		CommentDAO dao = new CommentDAO();

		String url = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = url.substring(ctxPath.length());

		System.out.println("요청 url : " + cmd);
		
		// 댓글 등록
		if (cmd.equals("/insertProc.co")) {
//			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			int post_no = Integer.parseInt(request.getParameter("post_no"));
			String content = request.getParameter("comment_content");

			HashMap<String, String> loginSession = (HashMap) session.getAttribute("loginSession");
			String user_id = loginSession.get("user_id");
			
			/*** 알림 추가 ***/
			BoardDAO daoBoard = new BoardDAO();
			NotiDAO daoNoti = new NotiDAO();
			try {
				// 글 작성자 정보 가져오기
				String post_writer = daoBoard.selectIdByNo(post_no);
				// 알림 생성 메서드 호출
				String noti_msg = loginSession.get("user_nickname") + "님이 당신의 글에 새 댓글을 달았습니다.";
				if(daoNoti.insertNoti(new NotiDTO(0, user_id, post_writer, noti_msg, null)) > 0) {
					System.out.println("댓글 알림 생성 완료");
				} else {
					System.out.println("댓글 알림 생성 실패");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			System.out.println("user_id : " + user_id);
//			System.out.println("currentPage : " + currentPage);
			System.out.println("post_no : " + post_no);
			System.out.println("content : " + content);

			int rs = dao.insert(new CommentDTO(0, post_no, user_id, content, null));
			if (rs == 1) {
				response.getWriter().write("success");
			} else {
				response.getWriter().write("fail");
			}
			
		// 댓글 리스트 출력(aJax)
		} else if (cmd.equals("/getCommentProc.co")) {
			System.out.println("요청 도착");
			int post_no = Integer.parseInt(request.getParameter("post_no"));
			System.out.println("post_no : " + post_no);
			
			
			ArrayList<CommentPlusDTO> list = dao.getCommentList(post_no);
		
			Gson gson = new Gson();
			String rs = gson.toJson(list);
			System.out.println(rs);
			if(list != null) {
				response.getWriter().write(rs);
			}else {
				response.getWriter().write("fail");
			}
				
		}else if(cmd.equals("/deleteProc.co")) {
			int comment_no = (Integer.parseInt(request.getParameter("comment_no")));
			System.out.println("댓글번호 : " + comment_no);
			
			int rs = dao.deleteBySeq(comment_no);
			
			if(rs != -1) {
				response.getWriter().write("success");
			}else {
				response.getWriter().write("fail");
			}
		}else if(cmd.equals("/modifyProc.co")) {
			int comment_no = (Integer.parseInt(request.getParameter("comment_no")));
			System.out.println("수정 댓글번호 : " + comment_no);
			String comment_content = request.getParameter("comment_content");
			System.out.println("수정 내용 : " + comment_content);
			
			int rs = dao.modify(comment_no, comment_content);
			
			if(rs != -1) {
				response.getWriter().write("success");
			}else {
				response.getWriter().write("fail");
			}
		}
			
			
			
			
	}
		

	

}