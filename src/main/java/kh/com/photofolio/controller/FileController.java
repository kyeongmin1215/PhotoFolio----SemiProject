package kh.com.photofolio.controller;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.com.photofolio.dao.FileDAO;

@WebServlet("*.fi")
public class FileController extends HttpServlet {

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
		HttpSession session = request.getSession();
		FileDAO dao = new FileDAO();
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());

		System.out.println("요청 url : " + cmd);

		// 파일 다운로드
		if (cmd.equals("/downloadProc.fi")) {
			String system_name = request.getParameter("system_name");
			System.out.println(system_name);

			// 파일이 저장된 서버의 경로
			String uploadFilePath = request.getServletContext().getRealPath("files");
			System.out.println("uploadFilePath: " + uploadFilePath);

			// 파일 풀 경로 잡기
			String filePath = uploadFilePath + File.separator + system_name;
			System.out.println("filePath: " + filePath);

			// 한글 깨짐 방지
			system_name = new String(system_name.getBytes("UTF-8"), "ISO-8859-1");
			response.setHeader("Content-disposition", "attachment; filename=\"" + system_name + "\"");

			// 파일 불러와 클라이언트에게 응답
			try (DataInputStream dis = new DataInputStream(new FileInputStream(filePath));
					DataOutputStream dos = new DataOutputStream(response.getOutputStream());) {
				byte[] arr = dis.readAllBytes();
				dos.write(arr);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
