package kh.com.photofolio.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.photofolio.dto.MemberDTO;
import kh.com.photofolio.dto.MemberInfoDTO;
import oracle.jdbc.proxy.annotation.Pre;
 //회원 정보를 다루는 메서드를 담은 클래스
public class Admin_memberDAO {
	private BasicDataSource bds;
	
	public Admin_memberDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public Connection getConnection() throws SQLException {
		return bds.getConnection();
	}
	
	public int today_signupCnt() throws Exception{ //오늘 가입자수를 반환하는 함수
		//메서드 설명 : 오늘 가입한 회원의 수를 세는 메서드
		//sql 설명 : 오늘 가입한 회원의 순위, 유저 아이디, 닉네임, 이메일, 가입일자, 업로드 갯수(post랑 조인)를 count
		String sql = "SELECT COUNT(*) FROM TBL_USER WHERE TO_CHAR(USER_SIGNUP_DATE,'YYYYMMDD') = TO_CHAR(SYSDATE,'YYYYMMDD')";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) return rs.getInt(1); //count수를 반환함.
		}return -1;
	}
	

	public ArrayList<MemberInfoDTO> getMemberList(int startRange, int endRange) throws Exception{  //페이징 한페이지에 출력되는 멤버 정보 가져오기
		//메서드 설명 : 전체 회원 정보 내역 중 startRange, endRange에 해당하는 값만 가져오는 메서드
		//sql 설명 : 순위, 유저 아이디, 닉네임, 이메일, 가입일자, 업로드 갯수(post랑 조인)를 가져와서 순위가 startRange -- endRange에 해당하는 회원 내역 출력
		String sql = "select * from (select row_number() over (order by user_signup_date desc) 순위, \r\n"
				   + "A.USER_ID,A.USER_NICKNAME, A.USER_EMAIL, A.USER_SIGNUP_DATE, A.USER_TYPE, COUNT(B.POST_NO) \r\n"
				   + "from tbl_user a left outer join tbl_post b on (a.user_id = b.post_writer) \r\n"
				   + "group by A.USER_ID,A.USER_NICKNAME, A.USER_EMAIL, A.USER_SIGNUP_DATE, A.USER_TYPE\r\n"
				   + "having A.USER_TYPE=1) \r\n"
				   + "where 순위 between ? and ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			//between startRange and endRange 로 들어감.
			pstmt.setInt(1, startRange);  //startRange값 설정
			pstmt.setInt(2, endRange);    //endRange값 설정
			ResultSet rs = pstmt.executeQuery();
			ArrayList<MemberInfoDTO> list = new ArrayList<>(); //해당 회원들의 정보를 담을 list 선언
			while(rs.next()) {
				MemberDTO dto = new MemberDTO(); //멤버별 정보를 담는 객체
				dto.setUser_id(rs.getString(2));
				dto.setUser_nickname(rs.getString(3));
				dto.setUser_email(rs.getString(4));
				dto.setUser_signup_date(rs.getDate(5));
				int postCnt = rs.getInt(6);
				list.add(new MemberInfoDTO(dto,postCnt));
			}if(list!=null) return list;
		}return null;
	}
	
	public int countAll() throws Exception{ //
		//메서드 설명 : 전체 회원의 수를 세는 메서드
		//sql 설명 : 전체 회원의 순위, 유저 아이디, 닉네임, 이메일, 가입일자, 업로드 갯수(post랑 조인)를 count
		String sql = "select count(*) from tbl_user";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			if(rs.next())return rs.getInt(1);
		}return -1;
	}
	
	public ArrayList<MemberInfoDTO> getUserByIdOrNickname(String id, int startRange, int endRange) throws Exception{ //아이디/닉네임으로 검색
		String sql = "SELECT * from ( select row_number() over (order by user_signup_date desc) 순위, "
				+ "A.USER_ID,A.USER_NICKNAME, A.USER_EMAIL, A.USER_SIGNUP_DATE, COUNT(B.POST_NO) \r\n"
				+ "FROM TBL_USER A LEFT OUTER JOIN TBL_POST B ON A.USER_ID=B.POST_WRITER \r\n"
				+ "GROUP BY A.USER_ID, A.USER_NICKNAME, A.USER_EMAIL, A.USER_SIGNUP_DATE \r\n"
				+ "having user_id like '%"+id+"%' or user_nickname like '%"+id+"%') where 순위 between ? and ?";
		System.out.println(sql);
		System.out.println("startRange : "+startRange);
		System.out.println("endRange"+endRange);
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<MemberInfoDTO> list = new ArrayList<>();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setUser_id(rs.getString(2));
				dto.setUser_nickname(rs.getString(3));
				dto.setUser_email(rs.getString(4));
				dto.setUser_signup_date(rs.getDate(5));
				int postCnt = rs.getInt(6);
				list.add(new MemberInfoDTO(dto,postCnt));
				
			}if(list!=null) return list;
		}return null;
	}

	public int getUserByIdOrNicknameCnt(String id) throws Exception{ //아이디/닉네임으로 검색
		String sql = "SELECT count(*) from ( select row_number() over (order by user_signup_date desc) 순위, "
				+ "A.USER_ID,A.USER_NICKNAME, A.USER_EMAIL, A.USER_SIGNUP_DATE, COUNT(B.POST_NO) \r\n"
				+ "FROM TBL_USER A LEFT OUTER JOIN TBL_POST B ON A.USER_ID=B.POST_WRITER \r\n"
				+ "GROUP BY A.USER_ID, A.USER_NICKNAME, A.USER_EMAIL, A.USER_SIGNUP_DATE \r\n"
				+ "having user_id like '%"+id+"%' or user_nickname like '%"+id+"%')";
		System.out.println(sql);
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			if(rs.next())return rs.getInt(1);
		}return -1;
	}
	
	
	public ArrayList<MemberInfoDTO> getUserByEmail(String value, int startRange, int endRange) throws Exception{  //위에 search메서드를 이용해 이메일로 검색
		String sql = "SELECT * from ( select row_number() over (order by user_signup_date desc) 순위, A.USER_ID,A.USER_NICKNAME, A.USER_EMAIL, A.USER_SIGNUP_DATE, COUNT(B.POST_NO)\r\n"
				   + "FROM TBL_USER A LEFT OUTER JOIN TBL_POST B ON A.USER_ID=B.POST_WRITER \r\n"
				   + "GROUP BY A.USER_ID, A.USER_NICKNAME, A.USER_EMAIL, A.USER_SIGNUP_DATE \r\n"
				   + "having user_email like '%"+value+"%') where 순위 between ? and ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<MemberInfoDTO> list = new ArrayList<>();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setUser_id(rs.getString(2));
				dto.setUser_nickname(rs.getString(3));
				dto.setUser_email(rs.getString(4));
				dto.setUser_signup_date(rs.getDate(5));
				int postCnt = rs.getInt(6);
				list.add(new MemberInfoDTO(dto,postCnt));
			}if(list!=null) return list;
		}return null;
	}
	
	
	public int getUserByEmailCnt(String value) throws Exception{  //위에 search메서드를 이용해 이메일로 검색
		String sql = "SELECT count(*) from ( select row_number() over (order by user_signup_date desc) 순위, A.USER_ID,A.USER_NICKNAME, A.USER_EMAIL, A.USER_SIGNUP_DATE, COUNT(B.POST_NO)\r\n"
				   + "FROM TBL_USER A LEFT OUTER JOIN TBL_POST B ON A.USER_ID=B.POST_WRITER \r\n"
				   + "GROUP BY A.USER_ID, A.USER_NICKNAME, A.USER_EMAIL, A.USER_SIGNUP_DATE \r\n"
				   + "having user_email like '%"+value+"%')";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			ArrayList<MemberInfoDTO> list = new ArrayList<>();
			if(rs.next())return rs.getInt(1);
		}return -1;
	}
	
	public ArrayList<MemberInfoDTO> getUserByPhone(String value, int startRange, int endRange) throws Exception{  //위에 search메서드를 이용해 휴대폰으로 검색
		String sql = "SELECT * from ( select row_number() over (order by user_signup_date desc) 순위, A.USER_ID,A.USER_NICKNAME, A.USER_EMAIL,A.USER_PHONE, A.USER_SIGNUP_DATE, COUNT(B.POST_NO)\r\n"
				   + "FROM TBL_USER A LEFT OUTER JOIN TBL_POST B ON A.USER_ID=B.POST_WRITER \r\n"
				   + "GROUP BY A.USER_ID, A.USER_NICKNAME, A.USER_EMAIL, A.USER_SIGNUP_DATE,A.USER_PHONE \r\n"
				   + "having user_phone like '%"+value+"%') where 순위 between ? and ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<MemberInfoDTO> list = new ArrayList<>();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setUser_id(rs.getString(2));
				dto.setUser_nickname(rs.getString(3));
				dto.setUser_email(rs.getString(4));
				dto.setUser_signup_date(rs.getDate(6));
				int postCnt = rs.getInt(7);
				list.add(new MemberInfoDTO(dto,postCnt));
			}if(list!=null) return list;
		}return null;

	}

	public int getUserByPhoneCnt(String value) throws Exception{  //위에 search메서드를 이용해 이메일로 검색
		String sql = "SELECT count(*) from ( select row_number() over (order by user_signup_date desc) 순위, A.USER_ID,A.USER_NICKNAME, A.USER_EMAIL,A.USER_PHONE, A.USER_SIGNUP_DATE, COUNT(B.POST_NO)\r\n"
				   + "FROM TBL_USER A LEFT OUTER JOIN TBL_POST B ON A.USER_ID=B.POST_WRITER \r\n"
				   + "GROUP BY A.USER_ID, A.USER_NICKNAME, A.USER_EMAIL, A.USER_SIGNUP_DATE,A.USER_PHONE \r\n"
				   + "having user_phone like '%"+value+"%')";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			ArrayList<MemberInfoDTO> list = new ArrayList<>();
			if(rs.next())return rs.getInt(1);
		}return -1;
	}
	
	
	public int deleteUser(String users) throws Exception{
		String sql = "DELETE FROM TBL_USER WHERE USER_ID IN ("+users+")";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			int rs = pstmt.executeUpdate();
			if(rs!=0) return 1;
		}return -1;
	}
	
	
	
	
}
