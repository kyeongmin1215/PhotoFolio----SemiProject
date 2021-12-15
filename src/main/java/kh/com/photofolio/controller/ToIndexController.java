package kh.com.photofolio.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.com.photofolio.dao.BoardDAO;
import kh.com.photofolio.dao.MemberDAO;
import kh.com.photofolio.dto.BoardInfoDTO;
import kh.com.photofolio.dto.MemberDTO;

@WebServlet("*.home")
public class ToIndexController extends HttpServlet {

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
		//FileDAO daoFile = new FileDAO();
		/* MemberDAO daoMem = new MemberDAO(); */
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		System.out.println("요청 uri : " + cmd);

		ArrayList<BoardInfoDTO> list = new ArrayList<>();
		try {
			list = dao.getAllBoard();
		} catch (Exception e) {
			
			e.printStackTrace();
		} 
		
		/*
		 * ArrayList<MemberDTO> mlist = new ArrayList<>(); try { mlist =
		 * daoMem.selectAll(); }catch(Exception e) { e.printStackTrace(); }
		 */
		


		
//			
		RequestDispatcher rd = request.getRequestDispatcher("/main.jsp");
		request.setAttribute("list", list);
//		request.setAttribute("flist", flist);
		/* request.setAttribute("mlist", mlist); */
		rd.forward(request, response);
		
		
	}
}
