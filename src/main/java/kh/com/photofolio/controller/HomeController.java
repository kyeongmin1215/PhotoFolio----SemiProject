package kh.com.photofolio.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.com.photofolio.dao.Admin_memberDAO;
import kh.com.photofolio.service.Admin_memberService;

/**
 * Servlet implementation class HomeController
 */
@WebServlet("/toHome.ho")
public class HomeController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	
	protected void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Admin_memberDAO dao = new Admin_memberDAO(); // 유저에 s관한 메서드를 담당하는 DAO 선언
		Admin_memberService service = new Admin_memberService();

		// 지금 클라이언트로부터 온 요청값을 분리해내는 작업
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		
		if(session.getAttribute("loginSession")!=null) {
		    System.out.println("loginSession 값이 있습니다. user_type을 나눕니다.");
			HashMap<String, String> map = (HashMap)session.getAttribute("loginSession"); System.out.println(map);
			String user_type = map.get("user_type");
			System.out.println("user_type : "+user_type);
			if(user_type.equals("1")) {
				RequestDispatcher rd = request.getRequestDispatcher("/toHome.home"); 
				request.setAttribute("user_type",user_type); 
				rd.forward(request, response);
			}else if(user_type.equals("2")){
				System.out.println(user_type);
				RequestDispatcher rd = request.getRequestDispatcher("/toMain.admHome");
				request.setAttribute("user_type",user_type); rd.forward(request, response);	
			}
	     }else {
	    	 System.out.println("loginSession 값이 없습니다. 메인으로 이동합니다.");
	    	 response.sendRedirect("/toHome.home");
	     }
	}
}
