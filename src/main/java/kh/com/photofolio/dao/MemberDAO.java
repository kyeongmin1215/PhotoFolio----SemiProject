package kh.com.photofolio.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Date;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.photofolio.dto.MemberDTO;

public class MemberDAO {

	private BasicDataSource bds;
	
	public MemberDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public Connection getConnection() throws Exception{
		return bds.getConnection();
	}
	// 회원가입 폼 저장
		public int insert(MemberDTO dto) throws Exception {
			String sql = "INSERT INTO tbl_user VALUES(?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
			try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
				pstmt.setString(1, dto.getUser_id());
				pstmt.setInt(2, dto.getUser_type());
				pstmt.setString(3, dto.getUser_email());
				pstmt.setString(4, dto.getUser_password());
				pstmt.setString(5, dto.getUser_phone());
				pstmt.setString(6, dto.getUser_nickname());
				pstmt.setString(7, dto.getUser_address());
				pstmt.setString(8, dto.getProfilePhoto_path());
				return pstmt.executeUpdate();
				
			}
		}
		// 아이디 중복검사(중복이면 true반환)
		public boolean checkId(String user_id) throws Exception {
			String sql = "SELECT * FROM tbl_user WHERE user_id = ?";
			try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
				pstmt.setString(1, user_id);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) return true; 
				
			} 
			return false;
		}
		// 닉네임 중복검사(중복이면 true반환)
		public boolean checkNickname(String user_nickname) throws Exception {
			String sql = "SELECT * FROM tbl_user WHERE user_nickname = ?";
			try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
				pstmt.setString(1, user_nickname);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) return true; 
				
			}
			return false;
		}
		//이메일 중복검사(중복이면 true반환)
		public boolean checkEmail(String user_email) throws Exception {
			String sql = "SELECT * FROM tbl_user WHERE user_email = ?";
			try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
				pstmt.setString(1, user_email);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) return true; 
				
			}
			return false;
		}
		// 로그인 요청(계정 존재하면 true반환)
		public boolean loginRequest(String user_id, String user_password) throws Exception {
			String sql = "SELECT * FROM tbl_user WHERE user_id = ? AND user_password = ?";
			try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
				pstmt.setString(1, user_id);
				pstmt.setString(2, user_password);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) return true;
				
			} 
			return false;
		}
		// id로 회원정보 출력
		public MemberDTO selectById(String user_id) throws Exception {
			String sql = "SELECT * FROM tbl_user WHERE user_id = ?";
			try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				
				pstmt.setString(1, user_id);
				ResultSet rs = pstmt.executeQuery();
				MemberDTO dto = new MemberDTO();
				if(rs.next()) {
					dto.setUser_id(rs.getString("user_id"));
					dto.setUser_type(rs.getInt("user_type"));
					dto.setUser_email(rs.getString("user_email"));
					dto.setUser_phone(rs.getString("user_phone"));
					dto.setUser_nickname(rs.getString("user_nickname"));
					dto.setUser_address(rs.getString("user_address"));
					dto.setProfilePhoto_path(rs.getString("profilePhoto_path"));
				}
				return dto;
			}
		}
		// 휴대전화로 회원정보 출력
		public MemberDTO selectByPhone(String user_phone) throws Exception {
			String sql = "SELECT * FROM tbl_user WHERE user_phone = ?";
			try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				
				pstmt.setString(1, user_phone);
				ResultSet rs = pstmt.executeQuery();
				MemberDTO dto = new MemberDTO();
				if(rs.next()) {
					dto.setUser_id(rs.getString("user_id"));
					dto.setUser_type(rs.getInt("user_type"));
					dto.setUser_email(rs.getString("user_email"));
					dto.setUser_phone(rs.getString("user_phone"));
					dto.setUser_nickname(rs.getString("user_nickname"));
					dto.setUser_address(rs.getString("user_address"));
					dto.setProfilePhoto_path(rs.getString("profilePhoto_path"));
				}
				return dto;
			}
		}
		// email로 회원정보 출력
		public MemberDTO selectByEmail(String user_email) throws Exception {
			String sql = "SELECT * FROM tbl_user WHERE user_email = ?";
			try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				
				pstmt.setString(1, user_email);
				ResultSet rs = pstmt.executeQuery();
				MemberDTO dto = new MemberDTO();
				if(rs.next()) {
					dto.setUser_id(rs.getString("user_id"));
					dto.setUser_type(rs.getInt("user_type"));
					dto.setUser_email(rs.getString("user_email"));
					dto.setUser_phone(rs.getString("user_phone"));
					dto.setUser_nickname(rs.getString("user_nickname"));
					dto.setUser_address(rs.getString("user_address"));
					dto.setProfilePhoto_path(rs.getString("profilePhoto_path"));
				}
				return dto;
			}
		}
		// 임시 패스워드 반영(패스워드 찾기 기능)
		public int updatePw(String user_id, String user_password) throws Exception {
			String sql = "UPDATE tbl_user SET user_password = ? WHERE user_id = ?";
			try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
				pstmt.setString(1, user_password);
				pstmt.setString(2, user_id);
				return pstmt.executeUpdate();
				
			}
		}
	
		// 회원탈퇴기능
	public int deleteId(String id) {
		String sql = "delete from tbl_user where user_id = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			
			int rs = pstmt.executeUpdate();
			
			if(rs != -1) {
				return rs;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}return -1;
	}
	
	public int modifyInfo(String id, String email, String phone, String nickname, String address, String profilePhoto_path) throws Exception{
		
		String sql = "update tbl_user set user_email=?, user_phone=?, user_nickname=?, user_address=?, profilePhoto_path=? where user_id=?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				
				pstmt.setString(1, email);
				pstmt.setString(2, phone);
				pstmt.setString(3, nickname);
				pstmt.setString(4, address);
				pstmt.setString(5, profilePhoto_path);
				pstmt.setString(6, id);
				
				int rs = pstmt.executeUpdate();
				
				if(rs != -1) {
					return rs;
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}return -1;
	}
	public boolean pwCheckRequest(String user_password) throws Exception {
		String sql = "SELECT * FROM tbl_user WHERE user_password = ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, user_password);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) return true;
			
		} 
		return false;
	}
	
	public int modifyPw(String pw, String id) throws Exception {
		String sql = "update tbl_user set user_password=? where user_id=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) {
				return rs;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}	return -1;
	}
				
	public ArrayList<MemberDTO> selectAll() throws Exception{
		String sql = "select * from tbl_user";
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<MemberDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				String user_id = rs.getString("user_id");
				int user_type = rs.getInt("user_type");
				String user_email = rs.getString("user_email");
				String user_password = rs.getString("user_password");
				String user_phone = rs.getString("user_phone");
				String user_nickname = rs.getString("user_nickname");
				String user_address = rs.getString("user_address");
				String profilePhoto_path = rs.getString("profilePhoto_path");
				Date user_signup_date = rs.getDate("user_signup_date");
				
				list.add(new MemberDTO(user_id, user_type, user_email, user_password, user_phone, user_nickname, user_address, profilePhoto_path, user_signup_date));
			}return list;
		}catch(Exception e) {
			e.printStackTrace();
		}return null;
	}
}
