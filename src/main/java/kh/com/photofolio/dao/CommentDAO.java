package kh.com.photofolio.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.photofolio.dto.CommentDTO;
import kh.com.photofolio.dto.CommentPlusDTO;

public class CommentDAO {

	private BasicDataSource bds;

	public CommentDAO() {
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
	
	
	// 댓글 등록
	public int insert(CommentDTO dto) {
		String sql = "insert into tbl_comment values(seq_comment.nextval, ?, ?, ?, sysdate)";
		try (Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, dto.getPost_no());
			pstmt.setString(2, dto.getComment_writer_id());
			pstmt.setString(3, dto.getComment_content());
			
			int rs = pstmt.executeUpdate();
			if (rs != -1) return rs;
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 댓글 리스트 조회
	public ArrayList<CommentPlusDTO> getCommentList(int post_no){
		String sql = "select * from tbl_comment full outer join tbl_user on(tbl_comment.comment_writer_id= tbl_user.user_id) where post_no = ? order by 1 DESC";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setInt(1, post_no);
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<CommentPlusDTO> list = new ArrayList<>();
			while(rs.next()) {
				int comment_no = rs.getInt("comment_no");
				String id = rs.getString("comment_writer_id");
				String content = rs.getString("comment_content");
				Date comment_createdDate = rs.getDate("comment_createdDate");
				String nickname = rs.getString("user_nickname");
				list.add(new CommentPlusDTO(comment_no, post_no, id, nickname, content, comment_createdDate));
			}	
			return list;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//닉네임 뽑아오기 
	public String selectNN(String id) {
		String sql = "select tbl_user.user_nickname from tbl_user inner join tbl_comment on tbl_user.user_id=tbl_comment.comment_writer_id where tbl_user.user_id=?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			 
			
			if(rs.next()) {
				String NN = rs.getString("user_nickname");
				return NN;
			}
		}catch(Exception e) {
			e.printStackTrace();
		} return null;
		
	}
	//댓글 삭제
	public int deleteBySeq(int seq) {
		String sql = "delete from tbl_comment where comment_no=?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setInt(1, seq);
			int rs = pstmt.executeUpdate();
			
			if(rs != -1) return rs;
		}catch(Exception e) {
			e.printStackTrace();
		}return -1;
	}
	//댓글 수정
	public int modify(int no, String content) {
		String sql  = "update tbl_comment set comment_content=? where comment_no = ?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, content);
			pstmt.setInt(2, no);
			int rs = pstmt.executeUpdate();
			
			if(rs != -1) return rs;
		}catch(Exception e) {
			e.printStackTrace();
		}return -1;
	}
	//댓글 총 갯수 뽑아내기 
	
	
		public int cntComment(int post_no) throws Exception {
			String sql = "SELECT COUNT(comment_no) FROM tbl_comment WHERE post_no = ?";
			try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

				pstmt.setInt(1, post_no);
				ResultSet rs = pstmt.executeQuery();
				if (rs.next()) return rs.getInt(1);
			}
			return -1;
		}
}
