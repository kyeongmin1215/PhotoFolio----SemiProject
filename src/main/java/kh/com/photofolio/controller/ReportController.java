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

import com.google.gson.Gson;

import kh.com.photofolio.dao.BoardDAO;
import kh.com.photofolio.dao.ReportDAO;
import kh.com.photofolio.dto.ReportDTO;

@WebServlet("*.re")
public class ReportController extends HttpServlet {

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
		ReportDAO dao = new ReportDAO();
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		System.out.println("요청 uri : " + cmd);

		// 신고 팝업창
				if (cmd.equals("/toReport.re")) {
					int post_no = Integer.parseInt(request.getParameter("post_no"));
					int report_type = Integer.parseInt(request.getParameter("report_type"));
					int reported_comment_no = Integer.parseInt(request.getParameter("reported_comment_no"));

					RequestDispatcher rd = request.getRequestDispatcher("/board/reportPopup.jsp");
					request.setAttribute("post_no", post_no);
					request.setAttribute("report_type", report_type);
					request.setAttribute("reported_comment_no", reported_comment_no);
					rd.forward(request, response);

					System.out.println("report_type : " + report_type);
					System.out.println("reported_comment_no : " + reported_comment_no);
					System.out.println("post_no : " + post_no);

					// 신고 등록
				} else if (cmd.equals("/reportProc.re")) {
					HashMap<String, String> loginSession = (HashMap) session.getAttribute("loginSession");

					int report_type = Integer.parseInt(request.getParameter("report_type"));
					String report_writer = loginSession.get("user_id");
					String report_content = request.getParameter("report_content");
					int reported_post_no = Integer.parseInt(request.getParameter("reported_post_no"));
					int reported_comment_no = Integer.parseInt(request.getParameter("reported_comment_no"));
					int report_content_no = Integer.parseInt(request.getParameter("report_content_no"));

					System.out.println("report_type : " + report_type);
					System.out.println("report_writer : " + report_writer);
					System.out.println("report_content : " + report_content);
					System.out.println("reported_post_no : " + reported_post_no);
					System.out.println("reported_comment_no : " + reported_comment_no);
					System.out.println("report_content_no : " + report_content_no);

					int rs = dao.insert(new ReportDTO(0, report_type, report_writer, report_content, reported_post_no,
							reported_comment_no, report_content_no, null));
					if (rs != -1) {
						response.getWriter().write("success");
					} else {
						response.getWriter().write("fail");
					}

					// 신고 리스트(report_type으로) 출력(리스트는 관리자 페이지에서 출력)
				} else if (cmd.equals("/getReportProc.re")) {
					System.out.println("요청 도착");
					int report_type = Integer.parseInt(request.getParameter("report_type"));
					System.out.println("report_type : " + report_type);

					ArrayList<ReportDTO> list = dao.selectByType(report_type);
					Gson gson = new Gson();
					String rs = gson.toJson(list);
					System.out.println(rs);

					if (list != null) {
						response.getWriter().write(rs);
					} else {
						response.getWriter().write("fail");
					}
				}
		
	}
}
