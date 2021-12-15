package kh.com.photofolio.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.photofolio.dto.NotiDTO;
import kh.com.photofolio.dto.NotiSendDTO;

public class NotiDAO {
	
	private BasicDataSource bds;

	public NotiDAO() {
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
	
	// 알림 데이터 생성
	public int insertNoti(NotiDTO dto) throws Exception {
		String sql = "INSERT INTO tbl_noti VALUES(noti_no.NEXTVAL, ?, ?, ?, SYSDATE)";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, dto.getNoti_sender());
			pstmt.setString(2, dto.getNoti_receiver());
			pstmt.setString(3, dto.getNoti_msg());
			return pstmt.executeUpdate();
		} 
	}
	
	// 알림 가져오기(내림차순)
	public ArrayList<NotiSendDTO> selectNoti(String noti_receiver) throws Exception {
		String sql = "SELECT noti_no, noti_sender, noti_receiver, noti_msg, noti_date, profilephoto_path, user_type "
					+ "FROM tbl_noti JOIN tbl_user "
						+ "ON(noti_sender = user_id) "
						+ "WHERE noti_receiver = ? "
						+ "ORDER BY noti_no DESC";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, noti_receiver);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<NotiSendDTO> list = new ArrayList<>();
			while(rs.next()) {
				NotiSendDTO dto = new NotiSendDTO();
				dto.setNotiDto(new NotiDTO(rs.getInt("noti_no"), 
											rs.getString("noti_sender"), 
											rs.getString("noti_receiver"), 
											rs.getString("noti_msg"), 
											rs.getDate("noti_date")));
				dto.setProfilephoto_path(rs.getString("profilephoto_path"));
				dto.setUser_type(rs.getInt("user_type"));
				list.add(dto);
			}
			return list;
		} 
	}
	
	// 알림 제거하기
	public int deleteNoti(int noti_no) throws Exception {
		String sql = "DELETE FROM tbl_noti WHERE noti_no = ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setInt(1, noti_no);
			return pstmt.executeUpdate();
		}

	}

}
