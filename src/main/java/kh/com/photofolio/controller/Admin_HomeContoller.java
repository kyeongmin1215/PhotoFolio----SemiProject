package kh.com.photofolio.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.com.photofolio.dao.*;

@WebServlet("*.admHome")
//admin 첫 페이지 index로 이동하게 하는 컨트롤러

public class Admin_HomeContoller extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//오늘 가입자수, 게시물수, 신고건수를 받아오기 위해 각각의 DAO 생성
		
		Admin_memberDAO userDao = new Admin_memberDAO();
		Admin_boardDAO postDao = new Admin_boardDAO();
		Admin_reportDAO reportDao = new Admin_reportDAO();
		int today_signup = 0; //오늘 가입자 수
		int today_post = 0; // 오늘 게시물 수
		int today_report = 0; //오늘 신고 수
		
		try {
			today_signup = userDao.today_signupCnt(); //오늘 가입자 수
			today_post = postDao.today_postCnt(); // 오늘 게시물 수
			today_report = reportDao.today_reportCnt(); //오늘 신고 수
		}catch(Exception e) {
			response.sendRedirect("/error.jsp");
			e.printStackTrace();
		}
		
		
		
//		System.out.println("today_signup : "+today_signup);
//		System.out.println("today_post : "+today_post);
//		System.out.println("today_report : "+today_report);
		
		RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_index.jsp");
		request.setAttribute("today_signup", today_signup);
//		System.out.println("today_signup attribute 완료");
		request.setAttribute("today_post", today_post);
//		System.out.println("today_post attribute 완료");
		request.setAttribute("today_report", today_report);
//		System.out.println("today_report attribute 완료");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
