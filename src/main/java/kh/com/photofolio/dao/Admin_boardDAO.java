package kh.com.photofolio.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.photofolio.dto.BoardDTO;

//게시글 조회, 삭제 등의 기능을 담은 메서드를 보관하는 클래스
public class Admin_boardDAO {

	private BasicDataSource bds;

	public Admin_boardDAO() { //커넥션 풀 연결
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	public Connection getConnection() throws SQLException { //sql 연결
		return bds.getConnection();
	}

	public int today_postCnt() throws Exception{ //오늘 게시글 수 반환
		String sql = "SELECT COUNT(*) FROM TBL_POST WHERE TO_CHAR(POST_CREATEDDATE,'YYYYMMDD') = TO_CHAR(SYSDATE,'YYYYMMDD')";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) return rs.getInt(1);
		}return -1;
	}

	public ArrayList<BoardDTO> getPostList(int startRange, int endRange) throws Exception{ //전체 게시글 정보 반환
		String sql = "select * from "
				+ "(select row_number() over (order by post_no desc) 순위, "
				+ "tbl_post.* from tbl_post) where 순위 between ? and ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<BoardDTO> list = new ArrayList<>();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setPost_no(rs.getInt(2));
				dto.setPost_writer_nickname(rs.getString(4));
				dto.setPost_title(rs.getString(5));
				dto.setPost_createdDate(rs.getDate(7));
				dto.setPost_view_count(rs.getInt(8));
				list.add(dto);
			}if(list!=null) return list;
		}return null;
	}
	
	public int getPostListCnt() throws Exception{ //전체 게시글 정보 갯수 반환
		String sql = "select count(*) from "
				+ "(select row_number() over (order by post_no desc) 순위, "
				+ "tbl_post.* from tbl_post)";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) return rs.getInt(1);
		}return -1;
	}
	

	
	public ArrayList<BoardDTO> getPostByPostNo(String post_no, int startRange, int endRange) throws Exception{ //게시글 번호로 검색
		String sql = " select * from (select row_number() over (order by post_no desc) 순위, "
				   + "tbl_post.* from tbl_post where post_no=?) where 순위 between ? and ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, post_no);
			pstmt.setInt(2, startRange);
			pstmt.setInt(3, endRange);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<BoardDTO> list = new ArrayList<>();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setPost_no(rs.getInt(2));
				dto.setPost_writer_nickname(rs.getString(4));
				dto.setPost_title(rs.getString(5));
				dto.setPost_createdDate(rs.getDate(7));
				dto.setPost_view_count(rs.getInt(8));
				list.add(dto);
			}if(list!=null) return list;
		}return null;
	}
	
	
	public int getPostByPostNoCnt(String post_no) throws Exception{ //게시글 번호로 검색 리스트 갯수
		String sql = " select count(*) from (select row_number() over (order by post_no desc) 순위, "
				   + "tbl_post.* from tbl_post where post_no=?)";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, post_no);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) return rs.getInt(1);
			}return -1;
	}
	
	

	public ArrayList<BoardDTO> getPostByWriterInfo(String value, int startRange, int endRange) throws Exception{ //게시글 작성자로 검색
		String sql = "  select * from (select row_number() over (order by post_no desc) 순위, tbl_post.* from TBL_POST\r\n"
				   + "WHERE POST_WRITER LIKE '%"+value+"%' OR POST_WRITER_NICKNAME LIKE '%"+value+"%'\r\n"
				   + "ORDER BY POST_CREATEDDATE DESC) where 순위 between ? and ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<BoardDTO> list =new ArrayList<>();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setPost_no(rs.getInt(2));
				dto.setPost_writer_nickname(rs.getString(4));
				dto.setPost_title(rs.getString(5));
				dto.setPost_createdDate(rs.getDate(7));
				dto.setPost_view_count(rs.getInt(8));
				list.add(dto);
			}if(list!=null) return list;
		}return null;
	}
	
	
	public int getPostByWriterInfoCnt(String value) throws Exception{ //게시글 작성자로 검색
		String sql = "  select count(*) from (select row_number() over (order by post_no desc) 순위, tbl_post.* from TBL_POST\r\n"
				   + "WHERE POST_WRITER LIKE '%"+value+"%' OR POST_WRITER_NICKNAME LIKE '%"+value+"%'\r\n"
				   + "ORDER BY POST_CREATEDDATE DESC)";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) return rs.getInt(1);
		}return -1;
	}
	
	

	
	public ArrayList<BoardDTO> getPostByTitleOrContent(String value, int startRange, int endRange) throws Exception{//게시글 제목/내용 속 키워드로 검색
		String sql = "select * from (SELECT row_number() over (order by post_no desc) 순위, tbl_post.* FROM TBL_POST \r\n"
				   + "WHERE POST_TITLE LIKE '%"+value+"%' OR POST_CONTENT LIKE '%"+value+"%' \r\n"
				   + "ORDER BY POST_CREATEDDATE DESC) where 순위 between ? and ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<BoardDTO> list = new ArrayList<>();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setPost_no(rs.getInt(2));
				dto.setPost_writer_nickname(rs.getString(4));
				dto.setPost_title(rs.getString(5));
				dto.setPost_createdDate(rs.getDate(7));
				dto.setPost_view_count(rs.getInt(8));
				list.add(dto);
			}if(list!=null) return list;
		}return null;
	}
	
	public int getPostByTitleOrContentCnt(String value) throws Exception {//게시글 제목/내용 속 키워드로 검색
		String sql = "select count(*) from (SELECT row_number() over (order by post_no desc) 순위, tbl_post.* FROM TBL_POST \r\n"
				   + "WHERE POST_TITLE LIKE '%"+value+"%' OR POST_CONTENT LIKE '%"+value+"%' \r\n"
				   + "ORDER BY POST_CREATEDDATE DESC)";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			ArrayList<BoardDTO> list = new ArrayList<>();
			if(rs.next()) return rs.getInt(1);
		}return -1;
	}
	
	
	public int deletePost(String post_no) throws Exception{
		String sql = "DELETE FROM TBL_POST WHERE POST_NO IN ("+post_no+")";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			int rs = pstmt.executeUpdate();
			if(rs!=0) return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}return -1;
	}
}
