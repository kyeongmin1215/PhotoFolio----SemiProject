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

import kh.com.photofolio.dao.Admin_reportDAO;
import kh.com.photofolio.dto.*;
import kh.com.photofolio.service.Admin_reportService;

/**
 * Servlet implementation class Admin_ReportController
 */
@WebServlet("*.admRe")
//신고 조회 및 삭제 등의 유저와 관련된 기능을 컨트롤 하는 컨트롤러

public class Admin_ReportController extends HttpServlet {
	
	
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
		Admin_reportDAO dao = new Admin_reportDAO();  //신고 관련 메서드들을 담은 DAO 생성
		Admin_reportService service = new Admin_reportService();
		// 지금 클라이언트로부터 온 요청값을 분리해내는 작업
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		
		if(cmd.equals("/toReportManagement.admRe")) {  //신고 관리 페이지로 이동
			int currentPage = Integer.parseInt(request.getParameter("currentPage")); // 현재페이지
			System.out.println("넘어온 user currentPage: " + currentPage);
			int recordTotalCnt = 0;
			try {
				recordTotalCnt = dao.getReportListCnt();
			}catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
			
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage, recordTotalCnt); 
			ArrayList<ReportInfoDTO> list = service.printReport((int) naviMap.get("currentPage")); 
			
			if(list!=null) {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_reportManagement.jsp");
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list", list);
				rd.forward(request, response);
			}
		}else if(cmd.equals("/searchProc.admRe")) {  //신고 내역 검색
			int currentPage = Integer.parseInt(request.getParameter("currentPage")); // 현재 페이지
			System.out.println("넘어온 user currentPage: " + currentPage);
			String search_category = request.getParameter("search_category"); // 검색 카테고리 값
			String value = request.getParameter("search_input"); // 검색어 값
			int recordTotalCnt = 0; // 데이터의 총 갯수
			
			ArrayList<ReportInfoDTO> list = new ArrayList<>(); //신고 항목과 게시물 내용을 담고있는 ReportInfoDTO 생성
			try {
				if(search_category.equals("report_no")) {  //신고 번호로 검색
					list = service.getReportByReportNo(value, currentPage);
					recordTotalCnt = dao.getReportByreportNoCnt(value);
				}else if(search_category.equals("report_keyword")) { //게시물 제목/내용 키워드로 검색
					list = service.getReportByKeyword(value, currentPage);
					recordTotalCnt = dao.getReportByKeywordCnt(value);
				}else if(search_category.equals("report_writer")) { //신고자로 검색
					System.out.println("report_writer검색!!");
					list = service.getReportByIdOrNickname(value, currentPage);
					recordTotalCnt = dao.getReportByIdOrNicknameCnt(value);
					System.out.println("nickname total: "+recordTotalCnt);
				}else if(search_category.equals("report_type")) { //신고타입으로 검색
					list = service.getReportByReportType(value, currentPage);
					recordTotalCnt = dao.getReportByReportTypeCnt(value);
				}else if(search_category.equals("report_content")) { //신고 내용으로 검색
					list = service.getReportByReportContent(value, currentPage);
					recordTotalCnt = dao.getReportByReportContentCnt(value);
				}
			}catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
			System.out.println("search_category : "+search_category);
			System.out.println("recordTotalCnt : "+recordTotalCnt);
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage, recordTotalCnt);
			if(list!=null) {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_reportManagement.jsp");
				request.setAttribute("list", list); //게시물 정보 list 넘기기
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("search_category", search_category);
				request.setAttribute("value", value);
				rd.forward(request, response);
		    }	
		}else if(cmd.equals("/toDeleteProc.admRe")) {
			String report_no = request.getParameter("report_no");
			System.out.println("삭제할 report_no : "+report_no);
			int rs = 0;
			try {
				rs = dao.deleteReport(report_no);
			}catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
			if(rs!=-1) {
				int recordTotalCnt =0;
				int currentPage =1;
				try {
					recordTotalCnt = dao.getReportListCnt();
				}catch(Exception e) {
					response.sendRedirect("/error.jsp");
					e.printStackTrace();
				}
				
				HashMap<String, Object> naviMap = service.getPageNavi(currentPage, recordTotalCnt); 
				ArrayList<ReportInfoDTO> list = service.printReport((int) naviMap.get("currentPage")); 
				
				if(list!=null) {
					RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_reportManagement.jsp");
					request.setAttribute("rs", "success");
					request.setAttribute("naviMap", naviMap);
					request.setAttribute("list", list);
					rd.forward(request, response);
				}else {
					response.sendRedirect("/admin/admin_reportManagement.jsp?rs='fail'");
				}
			}else {
				System.out.println("신고 삭제 실패");
			}
		}else if(cmd.equals("/toReportDetail.admRe")) {
			System.out.println("toReportDetail 진입");
			String report_content = request.getParameter("report_Content");
			System.out.println(report_content);
			String report_no = request.getParameter("report_no");
			System.out.println("report_no : "+report_no);
			try {
				ReportDTO reportDto = dao.getReportInfo(report_no);
				if(reportDto!=null) {
					int post_no = reportDto.getReported_post_no();
					System.out.println("post_no : "+post_no);
					BoardDTO boardDto = dao.getPostInfo(post_no);
					System.out.println(reportDto.getReport_no());
					int comment_no = reportDto.getReported_comment_no();
					System.out.println("comment_no : "+comment_no);
					CommentDTO commentDto = null;
					if(comment_no!=0) {
						commentDto = dao.getCommentInfo(comment_no);
					}
					RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_reportDetail.jsp");
					request.setAttribute("report_content", report_content);
					request.setAttribute("reportDto", reportDto);
					request.setAttribute("boardDto",boardDto);
					request.setAttribute("commentDto", commentDto);
					rd.forward(request, response);
				}
			}catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
		}
	}
}
