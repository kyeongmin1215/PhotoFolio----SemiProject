package kh.com.photofolio.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

public class LikeDAO {
	
	private BasicDataSource bds;

	public LikeDAO() {
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
	
	// 좋아요 +1
	public int addLike(String user_id, int post_no) throws Exception {
		String sql = "INSERT INTO tbl_like VALUES(?, ?, SYSDATE)";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setString(1, user_id);
			pstmt.setInt(2, post_no);
			return pstmt.executeUpdate();
		}
	}
	
	// 좋아요 취소
	public int removeLike(String user_id, int post_no) throws Exception {
		String sql = "DELETE FROM tbl_like WHERE user_id = ? AND post_no = ?";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setString(1, user_id);
			pstmt.setInt(2, post_no);
			return pstmt.executeUpdate();
		}
	}

	// 좋아요 수 가져오기
	public int cntLike(int post_no) throws Exception {
		String sql = "SELECT COUNT(post_no) FROM tbl_like WHERE post_no = ?";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, post_no);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) return rs.getInt(1);
		}
		return -1;
	}
	
	// 좋아요 눌렀는지 판단
	public boolean btnLikeCheck(String user_id, int post_no) throws Exception {
		String sql = "SELECT * FROM tbl_like WHERE user_id = ? AND post_no = ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, user_id);
			pstmt.setInt(2, post_no);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			} else {
				return false;
			}
		}
	}

}
