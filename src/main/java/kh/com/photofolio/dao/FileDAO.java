package kh.com.photofolio.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.photofolio.dto.FileDTO;

public class FileDAO {
	private BasicDataSource bds;

	public FileDAO() {
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
	
	// 파일(사진) 리스트
	public FileDTO getFileNames(int seq) {
		String sql = "select * from tbl_file where post_no=?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, seq);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				int seq_file = rs.getInt("seq_file");
				int seq_post = rs.getInt("post_no");
				String origin_name = rs.getString("origin_name");
				String system_name = rs.getString("system_name");
				return new FileDTO(seq_file, seq_post, origin_name, system_name);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 시스템 네임 불러오기
			public String getSystemName(int seq) {
				String sql = "select system_name from tbl_file where post_no=?";
				try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

					pstmt.setInt(1, seq);
					ResultSet rs = pstmt.executeQuery();

					if (rs.next()) {
						return rs.getString("system_name");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return null;
			}
			
	// 오리지널 네임 불러오기
	public String getOriginName(int seq) {
		String sql = "select origin_name from tbl_file where post_no=?";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, seq);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getString("origin_name");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}


	
	// 파일 추가
	public int insertFile(int post_no, String origin_name, String system_name) {
		String sql = "insert into tbl_file values(seq_file.nextval, ?, ?, ?)";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			System.out.println(con);

			pstmt.setInt(1, post_no);
			pstmt.setString(2, origin_name);
			pstmt.setString(3, system_name);

			int rs = pstmt.executeUpdate();
			if (rs != -1)
				return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 파일 수정
		public int modifyByPostNo(String origin_name, String system_name, int post_no) {
			String sql = "update tbl_file set origin_name=?, system_name=? where post_no=?";
			try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

				pstmt.setString(1, origin_name);
				pstmt.setString(2, system_name);
				pstmt.setInt(3, post_no);

				int rs = pstmt.executeUpdate();
				if (rs != -1)
					return rs;

			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}

		// 파일 삭제
		public int deleteByPostNo(int post_no) {
			String sql = "delete form tbl_file where post_no=?";
			try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setInt(1, post_no);

				int rs = pstmt.executeUpdate();
				if (rs != -1)
					return rs;

			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
	// 파일 불러오기(tbl_post와 tbl_file 이너조인)
	public ArrayList<FileDTO> selectAll(String id) {
		String sql= "select * from tbl_file inner join tbl_post on tbl_post.post_no = tbl_file.post_no where tbl_post.post_writer=?";
		try (Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<FileDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq_file = rs.getInt(1);
				int post_no = rs.getInt(2);
				String origin_name = rs.getString(3);
				String system_name = rs.getString(4);
				list.add(new FileDTO(seq_file, post_no, origin_name, system_name));
			}
			return list;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<FileDTO> select() {
		String sql= "select * from tbl_file order by 1 DESC";
		try (Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<FileDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq_file = rs.getInt(1);
				int post_no = rs.getInt(2);
				String origin_name = rs.getString(3);
				String system_name = rs.getString(4);
				list.add(new FileDTO(seq_file, post_no, origin_name, system_name));
			}
			return list;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
