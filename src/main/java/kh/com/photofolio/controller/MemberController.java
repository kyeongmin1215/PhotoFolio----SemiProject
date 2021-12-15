package kh.com.photofolio.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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

import kh.com.photofolio.dao.BoardDAO;
import kh.com.photofolio.dao.MemberDAO;
import kh.com.photofolio.dto.MemberDTO;
import kh.com.photofolio.service.MemberService;
import kh.com.photofolio.utils.EncryptionUtils;
import kh.com.photofolio.utils.RanNumUtils;

@WebServlet("*.mem")
public class MemberController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	protected void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		MemberDAO dao = new MemberDAO();
		MemberService memberService = new MemberService();
		PrintWriter out = response.getWriter();
		
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		System.out.println("요청uri : " + cmd);
		
		/*** 페이지 이동 ***/
		
		// 회원가입 페이지로 이동
		if(cmd.equals("/toSignup.mem")) {
			response.sendRedirect("/member/signUp.jsp");
		}
		// 로그인 페이지로 이동
		else if(cmd.equals("/toLogin.mem")) {
			response.sendRedirect("/member/login.jsp");
		}
		// 카카오 로그인 화면으로 이동
		else if(cmd.equals("/toKakaoLogin.mem")) {
			System.out.println("값 들어옴");
			response.sendRedirect("https://kauth.kakao.com/oauth/authorize?client_id=1aa69c59652259654fc77887234bfc8e&redirect_uri=http://localhost/kakaoCallbackProc.mem&response_type=code");
		}
		// 아이디 찾기 팝업창으로 이동
		else if(cmd.equals("/toFindId.mem")) {
			response.sendRedirect("/member/findIdPopup.jsp");
		}
		// 패스워드 찾기 팝업창으로 이동
		else if(cmd.equals("/toFindPw.mem")) {
			response.sendRedirect("/member/findPwPopup.jsp");
		}
		
		/*** 회원가입 관련 ***/
		
		// 아이디 중복검사
		else if(cmd.equals("/idCheckProc.mem")) {
			// 수신 확인
			String user_id = request.getParameter("id");
			System.out.println(user_id);
			try { // DB확인 & 클라이언트로 결과 반환
				boolean rs = dao.checkId(user_id);
				if(rs) { // true는 중복
					out.write("true");
				} else {
					out.write("false");
				}
			} catch(Exception e) {
				response.sendRedirect("//error.jsp");
				e.printStackTrace();
			}
		}
		// 닉네임 중복검사
		else if(cmd.equals("/nicknameCheckProc.mem")) {
			// 수신 확인
			String user_nickname = request.getParameter("nickname");
			System.out.println(user_nickname);
			try { // DB확인 & 클라이언트로 결과 반환
				boolean rs = dao.checkNickname(user_nickname);
				if(rs) { // true는 중복
					out.write("true");
				} else {
					out.write("false");
				}
			} catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
			
		}
		// SMS 인증번호 발송
		else if(cmd.equals("/sendSmsProc.mem")) {
			// 수신 확인
			String user_phoneNumber = request.getParameter("phoneNumber");
			System.out.println(user_phoneNumber);
			// 무작위 4자리 수 생성
			String ranNum = RanNumUtils.getRanNum();
			// SMS발송 서비스 호출
			memberService.sendSMS(user_phoneNumber, ranNum);
			// 무작위 4자리 수 클라이언트로 반환
			out.write(ranNum); 
		}
		// 이메일 인증번호 발송
		else if(cmd.equals("/sendEmailProc.mem")) {
			// 수신 확인
			String user_email = request.getParameter("email");
			System.out.println(user_email);
			// 무작위 4자리 수 생성
			String ranNum = RanNumUtils.getRanNum();
			// 이메일 발송 서비스 호출
			memberService.sendEmail(user_email, ranNum);
			// 무작위 4자리 수 클라이언트로 반환
			out.write(ranNum); 
		}
		// 이메일 중복검사
		else if(cmd.equals("/emailCheckProc.mem")) {
			// 수신 확인
			String user_email = request.getParameter("email");
			System.out.println(user_email);
			try { // DB확인 & 클라이언트로 결과 반환
				boolean rs = dao.checkEmail(user_email);
				if(rs) { // true는 중복
					out.write("true");
				} else {
					out.write("false");
				}
			} catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
		}
		// 회원가입 폼 제출
		else if(cmd.equals("/signupProc.mem")) {
			// 저장 경로 지정 - 경로 지정 논의 필요
			String filePath = request.getServletContext().getRealPath("/upload");
			System.out.println("filePath : " + filePath);
			File dir = new File(filePath);
			if(!dir.exists()) { // 저장 경로 존재 확인 후 생성
				dir.mkdir(); 
			}
			// 프로필 이미지 크기 설정 - 임의로 5MB
			int fileSize = 1024 * 1024 * 5;
			
			try {
				// 인스턴스 생성
				MultipartRequest multi = new MultipartRequest(request, filePath, fileSize, "utf-8", new DefaultFileRenamePolicy());
					
				// 데이터 가져오기
				String user_id = multi.getParameter("id");
				String user_password = multi.getParameter("password1");
				String user_nickname = multi.getParameter("nickname");
				String user_phone = multi.getParameter("user_phone");
				String user_email = multi.getParameter("email");
				String user_address = multi.getParameter("user_address");
				String profilePhoto_path = multi.getFilesystemName("file");
				boolean isNumeric =  user_id.matches("[+-]?\\d*(\\.\\d+)?");
				System.out.println(isNumeric);
				// 프로필 이미지 경로 처리
				if(profilePhoto_path == null) { // 프로필 이미지 업로드를 하지 않은 경우
					if(multi.getParameter("input_profileImgUrl").equals("")) { // null이 아님을 유의할 것
						// 카카오 회원이 아니면, 기본 프사 경로를 프로필 이미지 경로에 넣기
						profilePhoto_path = "/resource/imgTmp/squid-game-6723533_960_720.webp";
					} else { 
						// 카카오 회원이라면, 카카오 프사 경로를 프로필 이미지 경로에 넣기
						profilePhoto_path = multi.getParameter("input_profileImgUrl");
					}
				}
				// 패스워드 암호화
				user_password = EncryptionUtils.getSHA512(user_password);
				// 확인
				System.out.println("profilePhoto_path : " + profilePhoto_path);
				System.out.println("user_id : " + user_id);
				System.out.println("user_password : " + user_password);
				System.out.println("user_nickname : " + user_nickname);
				System.out.println("user_phone : " + user_phone);
				System.out.println("user_email : " + user_email);
				System.out.println("user_address : " + user_address);
				// DB 저장 & 메인화면 이동(id가 숫자가 아니면(일반회원)-유저타입=1//id가 숫자면(카카오회원)-유저타입=3)
				if(isNumeric == false) {//일반회원
				int rs = dao.insert(new MemberDTO(user_id, 1, user_email, user_password, user_phone, user_nickname, user_address, profilePhoto_path, null));
				if(rs > 0) {
					System.out.println("저장 성공");
				} else {
					System.out.println("저장 실패");
				}
				}else {//카카오회원
					int rs = dao.insert(new MemberDTO(user_id, 3, user_email, user_password, user_phone, user_nickname, user_address, profilePhoto_path, null));
					if(rs > 0) {
						System.out.println("저장 성공");
					} else {
						System.out.println("저장 실패");
					}	
				}
				response.sendRedirect("/");
				
			} catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
			
		}
		
		/*** 로그인 & 로그아웃 ***/
		
		// 로그인 요청
		else if(cmd.equals("/loginProc.mem")) {
			// 수신 확인
			String user_id = request.getParameter("user_id");
			String user_password = request.getParameter("user_password");
			// 패스워드 암호화
			user_password = EncryptionUtils.getSHA512(user_password);
			try { // DB확인 & true이면 세션 생성
				boolean rs = dao.loginRequest(user_id, user_password);
				if(rs) { // 세션 - id, nickname, type(String형 주의)
					try {
						MemberDTO dto = dao.selectById(user_id);
						HashMap<String, String> map = new HashMap<>();
						map.put("user_id", dto.getUser_id());
						map.put("user_nickname", dto.getUser_nickname());
						map.put("user_type", Integer.toString(dto.getUser_type()));
						map.put("profilePhoto_path", dto.getProfilePhoto_path());
						session.setAttribute("loginSession", map);
						// ajax콜백에서 홈 화면 이동 예정
						out.write("true");
					} catch(Exception e) {
						response.sendRedirect("/error.jsp");
						e.printStackTrace();
					}
				} else {
					out.write("false");
				}
			} catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
		}
		// 카카오 로그인 성공 후 콜백
		else if(cmd.equals("/kakaoCallbackProc.mem")) {
			// 코드 수신 확인
			String code = request.getParameter("code");
			System.out.println("code : " + code);
			// 토큰 가져오기
			String access_token = memberService.getToken(code);
			System.out.println("controller access_token : " + access_token);
			// 유저 정보 가져오기
			HashMap<String,Object> userInfo = memberService.getUserInfo(access_token);
			System.out.println("KakaoUserInfo : " + userInfo);
			
			try { // 회원가입 필요 여부 판단
				MemberDTO dto = dao.selectById((String)userInfo.get("id"));
				if(dto.getUser_id() != null) { // 계정 존재(재가입시 DB에 찌거기 남는건 어떻게?)
					System.out.println("회원 등록 불필요");
					// 세션 생성(카카오 유저는 세션에 엑세스 토큰을 추가함)
					HashMap<String, String> map = new HashMap<>();
					map.put("user_id", dto.getUser_id());
					map.put("user_nickname", dto.getUser_nickname());
					map.put("profilePhoto_path", dto.getProfilePhoto_path());
					map.put("user_type", Integer.toString(dto.getUser_type()));
					map.put("access_token", access_token);
					session.setAttribute("loginSession", map);
					response.sendRedirect("/");
				} else { // 회원가입이 필요함
					System.out.println("회원 등록 필요");
					RequestDispatcher rd = request.getRequestDispatcher("/member/signUp.jsp");
					request.setAttribute("userInfo", userInfo);
					rd.forward(request, response);
				}
				
			} catch (Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
		}
		// 로그아웃 요청
				else if(cmd.equals("/logoutProc.mem")) {
					// 세션에서 엑세스 토큰을 꺼내 반납해야 카카오 로그아웃이 가능
					HashMap<String, String> map = (HashMap)session.getAttribute("loginSession");
					if(map.get("access_token") != null) {
						System.out.println("access_token : " + map.get("access_token"));
						memberService.kakaoLogout(map.get("access_token"));
					}
					// 세션 값 제거 & 홈 이동(카카오 유저는 세션안에 토큰도 들어있음)
					session.removeAttribute("loginSession");
					response.sendRedirect("/");
				}
		
		/*** 계정 찾기 ***/
		
		// 휴대전화로 아이디 찾기
		else if(cmd.equals("/findIdByPhoneProc.mem")) {
			// 수신 확인
			String user_phone = request.getParameter("phone");
			System.out.println("user_phone : " + user_phone);
			try { // DB확인 후 콜백
				MemberDTO dto = dao.selectByPhone(user_phone);
				if(dto.getUser_id() == null) { // 휴대전화에 해당하는 회원 정보가 없음
					out.write("false");
				} else { // id반환 후, 추가 인증을 더 필요함
					out.write(dto.getUser_id());
				}
			} catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
		}
		
		// 이메일로 아이디 찾기
		else if(cmd.equals("/findIdByEmailProc.mem")) {
			// 수신 확인
			String user_email = request.getParameter("email");
			System.out.println("user_email : " + user_email);
			try { // DB확인 후 콜백
				MemberDTO dto = dao.selectByEmail(user_email);
				if(dto.getUser_id() == null) { // email에 해당하는 회원 정보가 없음
					out.write("false");
				} else { // id반환 후, 추가 인증을 더 필요함
					out.write(dto.getUser_id());
				}
			} catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
		}
		// 이메일로 패스워드 찾기
		else if(cmd.equals("/findPwByEmailProc.mem")) {
			// 수신 확인
			String user_id = request.getParameter("id");
			String user_email = request.getParameter("email");
			System.out.println(user_id + " : " + user_email);
			// 무작위 임시 패스워드 생성
			String tempPw = RanNumUtils.getTempPassword();
			// 이메일 발송 서비스 호출
			memberService.sendEmail(user_email, tempPw);
			// 패스워드 암호화
			tempPw = EncryptionUtils.getSHA512(tempPw);
			try { // DB에 저장 & 홈이동
				int rs = dao.updatePw(user_id, tempPw);
				if(rs > 0) { // 등록 완료
					System.out.println("임시 패스워드 발송 완료");
					out.write("true");
				} else { // 등록 실패
					System.out.println("임시 패스워드 발송 실패");
					out.write("false");
				}
			} catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
		}
		//마이페이지로 정보넘기기
		else if(cmd.equals("/toMyPage.mem")) {
			HashMap<String, String> map = (HashMap)session.getAttribute("loginSession");
	    	String id = map.get("user_id");
	    	System.out.println(id);
			try {
				MemberDTO dto = dao.selectById(id);
				
				if(dto != null) {
					RequestDispatcher rd = request.getRequestDispatcher("/member/userInfo.jsp");
					request.setAttribute("dto", dto);
					rd.forward(request, response);
				}
			} catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
			
			//회원탈퇴 기능 
		}else if(cmd.equals("/deleteProc.mem")) {
			HashMap<String, String> map = (HashMap)session.getAttribute("loginSession");
	    	String id = map.get("user_id");
	    	System.out.println("탈퇴할 id : " + id);
	    	
	    	int rs = dao.deleteId(id);
	    	
	    	if(rs != -1) {
	    		session.invalidate();
	    		response.sendRedirect("/");
	    	}
		}
		//비밀번호 변경버튼눌렀을시 비밀번호 확인 팝업으로 
		else if(cmd.equals("/toPwPopup.mem")) {
			response.sendRedirect("/member/checkPwPopup.jsp");
		}
		//비밀번호 체크후 비밀번호변경팝업으로 이동 
		else if(cmd.equals("/pwCheckProc.mem")) {
			String user_pw = request.getParameter("user_pw");
			System.out.println("입력비밀번호 : " + user_pw);
			//패스워드암호화
			user_pw = EncryptionUtils.getSHA512(user_pw);
			
			try {
			boolean rs = dao.pwCheckRequest(user_pw);
			
			if(rs) {
				response.sendRedirect("/member/modifyPwPopup.jsp");
			}else {
				RequestDispatcher rd = request.getRequestDispatcher("/member/checkPwPopup.jsp");
				request.setAttribute("rs", rs);
				rd.forward(request, response);
			}
			}catch(Exception e) {
				response.sendRedirect("/error.jsp");
				e.printStackTrace();
			}
		}else if(cmd.equals("/pwModifyProc.mem")) {
			HashMap<String, String> map = (HashMap)session.getAttribute("loginSession");
	    	String id = map.get("user_id");
	    	String user_pw = request.getParameter("user_pw");
	    	user_pw = EncryptionUtils.getSHA512(user_pw);
	    	System.out.println("id : " + id + "user_pw : "+ user_pw);
	    	
	    	try {
	    		int rs = dao.modifyPw(user_pw, id);
		    	
		    	if(rs != -1) {
		    		System.out.println("수정 성공");
		    	}else {
		    		System.out.println("수정 성공");
		    	}
		    	MemberDTO dto = dao.selectById(id);
				map.replace("user_password", dto.getUser_password());
				session.setAttribute("loginSession", map);
				RequestDispatcher rd = request.getRequestDispatcher("/member/checkPwPopup.jsp");
				request.setAttribute("rs", rs);
				rd.forward(request, response);
				
	    	}catch(Exception e) {
	    		response.sendRedirect("/error.jsp");
	    		e.printStackTrace();
	    	}
	    	
		}
		else if(cmd.equals("/modifyProc.mem")) {
			// 저장 경로 지정 - 경로 지정 논의 필요
						String filePath = request.getServletContext().getRealPath("/upload");
						System.out.println("filePath : " + filePath);
						File dir = new File(filePath);
						if(!dir.exists()) { // 저장 경로 존재 확인 후 생성
							dir.mkdir(); 
						}
						// 프로필 이미지 크기 설정 - 임의로 5MB
						int fileSize = 1024 * 1024 * 5;
						
						try {
							// 인스턴스 생성
							MultipartRequest multi = new MultipartRequest(request, filePath, fileSize, "utf-8", new DefaultFileRenamePolicy());
							// 프로필 이미지 이름(DB에 original_name 컬럼없어서 기본 이름만 설정)
							String profilePhoto_path;
							profilePhoto_path=multi.getFilesystemName("file");
							System.out.println("사진이름 : " + profilePhoto_path);
							
							// 데이터 가져오기
							String user_id = multi.getParameter("user_id");
							String user_nickname = multi.getParameter("user_nickname");
							String user_phone = multi.getParameter("user_phone");
							String user_email = multi.getParameter("user_email");
							String user_address = multi.getParameter("user_address");
							// 확인
							System.out.println("profilePhoto_path : " + profilePhoto_path);
							System.out.println("user_id : " + user_id);
							System.out.println("user_nickname : " + user_nickname);
							System.out.println("user_phone : " + user_phone);
							System.out.println("user_email : " + user_email);
							System.out.println("user_address : " + user_address);
							MemberDTO dto = dao.selectById(user_id);
							
							BoardDAO pdao = new BoardDAO();
							String subNN = dto.getUser_nickname();
							System.out.println("서브닉네임 : " + subNN);
							
							
							if(profilePhoto_path == null) {
								// 프사 업로드 안했으면, 기존프로필사진 불러올것 
								profilePhoto_path = dto.getProfilePhoto_path();
								System.out.println("대체사진이름 : " + profilePhoto_path);
							}
							
							// DB 저장 & 메인화면 이동(일반 회원 user_type default = 1)
							int rs = dao.modifyInfo(user_id, user_email, user_phone, user_nickname, user_address, profilePhoto_path);
							if(rs > 0) {
								System.out.println("저장 성공");
								if(user_nickname != subNN) {
									int result = pdao.updateNickname(user_nickname, user_id);
									
									if(result > 0) {
										System.out.println("닉네임 변경성공");
									}else {
										System.out.println("닉네임 변경실패");
									}
								}
							} else {
								System.out.println("저장 실패");
							}
							
							HashMap<String, String> map = (HashMap)session.getAttribute("loginSession");
							String photo = map.get("profilePhoto_path");
							System.out.println(photo);
							map.replace("profilePhoto_path", dto.getProfilePhoto_path());
							map.replace("user_address", dto.getUser_address());
							map.replace("user_email", dto.getUser_email());
							map.replace("user_phone", dto.getUser_phone());
							map.replace("user_nickname", dto.getUser_nickname());
							String photo2 = map.get("profilePhoto_path");
							System.out.println(photo2);
							session.setAttribute("loginSession", map);
							response.sendRedirect("/toMyPage.mem");
							
						} catch(Exception e) {
							response.sendRedirect("/error.jsp");
							e.printStackTrace();
						}
						
					}
		else if(cmd.equals("/toMain.mem")) {
			System.out.println("요청완료");
			response.sendRedirect("/index.jsp");
		}
		
	} // actionDo

} // HttpServlet
