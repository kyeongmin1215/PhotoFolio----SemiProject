package kh.com.photofolio.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.photofolio.dto.FollowDTO;

public class FollowDAO {
	
	private BasicDataSource bds;

	public FollowDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context) iCtx.lookup("java:comp/env");
			bds = (BasicDataSource) envCtx.lookup("jdbc/bds");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Connection getConnection() throws Exception {
		return bds.getConnection();
	}
	
	// 팔로우 +1
	public int addFollow(String following_id, String follower_id) throws Exception {
		String sql = "INSERT INTO tbl_following VALUES(?, ?, SYSDATE)";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, following_id);
			pstmt.setString(2, follower_id);
			return pstmt.executeUpdate();
		}
	}
	
	// 언팔 처리
	public int removeFollow(String following_id, String follower_id) throws Exception {
		String sql = "DELETE FROM tbl_following WHERE following_id = ? AND follower_id = ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, following_id);
			pstmt.setString(2, follower_id);
			return pstmt.executeUpdate();
		}
	}
	
	// 팔로우 여부 확인
	public boolean checkFollow(String following_id, String follower_id) throws Exception {
		String sql = "SELECT * FROM tbl_following WHERE following_id = ? AND follower_id = ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, following_id);
			pstmt.setString(2, follower_id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) return true;
			return false;
		}
	}
	
	// user가 팔로우 하는 사람의 수(user가 좋아하는 놈들)
	public int countFollower(String user_id) throws Exception {
		String sql = "SELECT COUNT(following_id) FROM tbl_following WHERE following_id = ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, user_id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) return rs.getInt(1);
			return -1;
		}
	}
	
	// user를 팔로우 하는 사람의 수(user를 따르는 이들)
	public int countFollowing(String user_id) throws Exception {
		String sql = "SELECT COUNT(follower_id) FROM tbl_following WHERE follower_id = ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, user_id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) return rs.getInt(1);
			return -1;
		}
	}
	
	// user가 팔로우하는 유저 목록 가져오기(user가 좋아하는 놈들)
	public ArrayList<FollowDTO> getListFollowing(String user_id) throws Exception {
		String sql = "SELECT user_id, user_nickname, profilePhoto_path "
					+ "FROM tbl_user JOIN tbl_following "
						+ "ON(user_id = following_id) "
						+ "WHERE follower_id = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, user_id);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<FollowDTO> list = new ArrayList<>();
			while(rs.next()) {
				FollowDTO dto = new FollowDTO();
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_nickname(rs.getString("user_nickname"));
				dto.setProfilePhoto_path(rs.getString("profilePhoto_path"));
				list.add(dto);
			}
			return list;
		}
	}
	
	// user를 팔로우하는 유저 목록 가져오기(user를 따르는 이들)
	public ArrayList<FollowDTO> getListFollower(String user_id) throws Exception {
		String sql = "SELECT user_id, user_nickname, profilePhoto_path "
					+ "FROM tbl_user JOIN tbl_following "
						+ "ON(user_id = follower_id) "
						+ "WHERE following_id = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, user_id);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<FollowDTO> list = new ArrayList<>();
			while(rs.next()) {
				FollowDTO dto = new FollowDTO();
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_nickname(rs.getString("user_nickname"));
				dto.setProfilePhoto_path(rs.getString("profilePhoto_path"));
				list.add(dto);
			}
			return list;
		}
	}

}
