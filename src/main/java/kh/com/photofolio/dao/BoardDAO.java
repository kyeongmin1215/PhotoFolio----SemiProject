package kh.com.photofolio.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.photofolio.dto.BoardDTO;
import kh.com.photofolio.dto.BoardInfoDTO;
import kh.com.photofolio.dto.FileDTO;

public class BoardDAO {
	private BasicDataSource bds;

	public BoardDAO() {
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

	// 조회수
	public int post_viewCount(int post_no) {
		String sql = "update tbl_post set post_view_count = post_view_count+1 where post_no=?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, post_no);
			int rs = pstmt.executeUpdate();
			if (rs != -1)
				return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 게시글 조회
	public ArrayList<BoardDTO> selectAll() {
		String sql = "select * from tbl_post order by 1 DESC";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			ResultSet rs = pstmt.executeQuery();
			ArrayList<BoardDTO> list = new ArrayList<>();
			while (rs.next()) {
				int post_no = rs.getInt("post_no");
				String post_writer = rs.getString("post_writer");
				String post_writer_nickname = rs.getString("post_writer_nickname");
				String post_title = rs.getString("post_title");
				String post_content = rs.getString("post_content");
				Date post_createdDate = rs.getDate("post_createdDate");
				int post_view_count = rs.getInt("post_view_count");
				int category_no = rs.getInt("category_no");
				list.add(new BoardDTO(post_no, post_writer, post_writer_nickname, post_title, post_content,
						post_createdDate, post_view_count, category_no));
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 게시글 삭제
	public int deleteByPost(int post_no) {
		String sql = "delete from tbl_post where post_no = ?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, post_no);
			int rs = pstmt.executeUpdate();
			if (rs != -1)
				return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 게시글 수정
	public int modifyByPost(int post_no, String post_title, String post_content) {
		String sql = "update tbl_post set post_title=?, post_content=? where post_no=?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, post_title);
			pstmt.setString(2, post_content);
			pstmt.setInt(3, post_no);

			int rs = pstmt.executeUpdate();
			if (rs != -1)
				return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 게시글 번호 검색
	public BoardDTO selectBySeq(int seq) {
		String sql = "select * from tbl_post where post_no=?";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, seq);

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				int post_no = rs.getInt("post_no");
				String post_writer = rs.getString("post_writer");
				String post_writer_nickname = rs.getString("post_writer_nickname");
				String post_title = rs.getString("post_title");
				String post_content = rs.getString("post_content");
				Date post_createdDate = rs.getDate("post_createdDate");
				int post_view_count = rs.getInt("post_view_count");
				int category_no = rs.getInt("category_no");
				return new BoardDTO(post_no, post_writer, post_writer_nickname, post_title, post_content,
						post_createdDate, post_view_count, category_no);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;

	}

	// 시퀀스 값 메서드화
	public int getSequence() {
		String sql = "select seq_post.nextval from dual";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			ResultSet rs = pstmt.executeQuery();

			if (rs.next())
				return rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 페이징 메서드
		public ArrayList<BoardDTO> getBoardList(int startRange, int endRange) {
			String sql = "select * from" + "(select row_number() over(order by post_no desc) 순위," + "a.* from tbl_post a)"
					+ "where 순위 between ? and ?";
			try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

				pstmt.setInt(1, startRange);
				pstmt.setInt(2, endRange);

				ResultSet rs = pstmt.executeQuery();
				ArrayList<BoardDTO> list = new ArrayList<>();
				while (rs.next()) {
					int post_no = rs.getInt("post_no");
					String post_writer = rs.getString("post_writer");
					String post_writer_nickname = rs.getString("post_writer_nickname");
					String post_title = rs.getString("post_title");
					String post_content = rs.getString("post_content");
					Date post_createdDate = rs.getDate("post_createdDate");
					int post_view_count = rs.getInt("post_view_count");
					int category_no = rs.getInt("category_no");
					list.add(new BoardDTO(post_no, post_writer, post_writer_nickname, post_title, post_content,
							post_createdDate, post_view_count, category_no));
				}
				return list;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}

	// 총 데이터 수
	public int countAll() {
		String sql = "select count(*) from tbl_post";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			ResultSet rs = pstmt.executeQuery();

			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 게시글 등록
	public int insert(BoardDTO dto) {
		String sql = "insert into tbl_post values(?, ?, ?, ?, ?, sysdate, 0, ?)";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, dto.getPost_no());
			pstmt.setString(2, dto.getPost_writer());
			pstmt.setString(3, dto.getPost_writer_nickname());
			pstmt.setString(4, dto.getPost_title());
			pstmt.setString(5, dto.getPost_content());
			pstmt.setInt(6, dto.getCategory_no());

			int rs = pstmt.executeUpdate();
			if (rs != -1)
				return rs;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//내 게시글만 출력
	public ArrayList<BoardDTO> selectById(String id){
		String sql = "select * from tbl_post where post_writer=? order by 1 DESC";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt= con.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<BoardDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				int post_no = rs.getInt("post_no");
				String post_writer = rs.getString("post_writer");
				String post_writer_nickname =rs.getString("post_writer_nickname");
				String post_title=rs.getString("post_title");
				String post_content = rs.getString("post_content");
				Date post_createdDate = rs.getDate("post_createdDate");
				int post_view_count = rs.getInt("post_view_count");
				int category_no=rs.getInt("category_no");
				list.add(new BoardDTO(post_no, post_writer, post_writer_nickname, post_title, post_content, post_createdDate, post_view_count, category_no));
				
			}
			return list;
			
		}catch(Exception e) {
			e.printStackTrace();
		}return null;
	}
	
	public ArrayList<BoardInfoDTO> getBoardByWriter(String value) throws Exception{
		String sql = "select profilephoto_path,  \r\n"
				   + "post_no, post_writer,post_writer_nickname,post_title, post_content, post_createdDate, post_view_count,category_no,\r\n"
				   + "seq_file, origin_name, system_name,\r\n"
				   + "count(c.user_id) as \"좋아요수\", \r\n"
				   + "count(comment_no) as \"댓글수\"\r\n"
				   + "from tbl_post a \r\n"
				   + "inner join tbl_user b on (a.post_writer = b.user_id)\r\n"
				   + "left outer join  tbl_like c using(post_no) \r\n"
				   + "inner join tbl_file d using (post_no) \r\n"
				   + "left outer join tbl_comment e using(post_no)\r\n"
				   + "group by profilephoto_path,  \r\n"
				   + "post_no, post_writer,post_writer_nickname,post_title, post_content, post_createdDate, post_view_count,category_no,\r\n"
				   + "seq_file, origin_name, system_name\r\n"
				   + "having post_writer_nickname like '%"+value+"%' or post_writer like '%"+value+"%' "
				   + "or post_title like '%"+value+"%' or post_content like '%"+value+"%'"
				   + "order by post_no desc";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			ArrayList<BoardInfoDTO> list = new ArrayList<>();
			while(rs.next()) {
				BoardInfoDTO dto = new BoardInfoDTO();
				dto.setProfilephoto_path(rs.getString("profilephoto_path"));
				dto.setPost_no(rs.getInt("post_no"));
				dto.setPost_writer(rs.getString("post_writer"));
				dto.setPost_writer_nickname(rs.getString("post_writer_nickname"));
				dto.setPost_title(rs.getString("post_title"));
				dto.setPost_content(rs.getString("post_content"));
				dto.setPost_createdDate(rs.getDate("post_createdDate"));
				dto.setPost_view_count(rs.getInt("post_view_count"));
				dto.setCategory_no(rs.getInt("category_no"));
				dto.setSeq_file(rs.getInt("seq_file"));
				dto.setOrigin_name(rs.getString("origin_name"));
				dto.setSystem_name(rs.getString("system_name"));
				dto.setLikeCnt(rs.getInt(13));
				dto.setCommentCnt(rs.getInt(14));
				list.add(dto);
			}
			if(list!=null) return list;
		}return null;
	}
	
	//
	public ArrayList<BoardInfoDTO> getBoardByCategory(int category) throws Exception{
		String sql = "select profilephoto_path,  \r\n" 
				+"post_no, post_writer,post_writer_nickname,post_title, post_content, \r\n"
				+"post_createdDate, post_view_count,category_no, \r\n"
				+"seq_file, origin_name, system_name, \r\n"
				+"count(c.user_id) as \"좋아요수\", \r\n"
				+ "count(comment_no) as \"댓글수\"\r\n"
				+ "from tbl_post a \r\n"
				+"inner join tbl_user b on (a.post_writer = b.user_id)\r\n"
				+ "full outer join  tbl_like c using(post_no) \r\n"
				+ "inner join tbl_file d using (post_no) \r\n"
				+ "full outer join tbl_comment e using(post_no) \r\n"
				+ "group by profilephoto_path,  \r\n"
				+ "post_no, post_writer,post_writer_nickname,post_title, post_content, \r\n"
				+ "post_createdDate, post_view_count,category_no, \r\n"
				+ " seq_file, origin_name, system_name\r\n"
				+ "having category_no = ? \r\n"
			    + "order by post_no desc";
		try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
				pstmt.setInt(1, category);
				ResultSet rs = pstmt.executeQuery();
				ArrayList<BoardInfoDTO> list = new ArrayList<>();
				while(rs.next()) {
					BoardInfoDTO dto = new BoardInfoDTO();
					dto.setProfilephoto_path(rs.getString("profilephoto_path"));
					dto.setPost_no(rs.getInt("post_no"));
					dto.setPost_writer(rs.getString("post_writer"));
					dto.setPost_writer_nickname(rs.getString("post_writer_nickname"));
					dto.setPost_title(rs.getString("post_title"));
					dto.setPost_content(rs.getString("post_content"));
					dto.setPost_createdDate(rs.getDate("post_createdDate"));
					dto.setPost_view_count(rs.getInt("post_view_count"));
					dto.setCategory_no(rs.getInt("category_no"));
					dto.setSeq_file(rs.getInt("seq_file"));
					dto.setOrigin_name(rs.getString("origin_name"));
					dto.setSystem_name(rs.getString("system_name"));
					dto.setLikeCnt(rs.getInt(13));
					dto.setCommentCnt(rs.getInt(14));
					list.add(dto);
				}
				if(list!=null) return list;
			}return null;
		}
		         
	// 게시글 조회
		public ArrayList<BoardInfoDTO> getAllBoard() throws Exception{
			String sql = "select profilephoto_path,  \r\n"
					   + "post_no, post_writer,post_writer_nickname,post_title, post_content, post_createdDate, post_view_count,category_no,\r\n"
					   + "seq_file, origin_name, system_name,\r\n"
					   + "count(c.user_id) as \"좋아요수\", \r\n"
					   + "count(comment_no) as \"댓글수\"\r\n"
					   + "from tbl_post a \r\n"
					   + "inner join tbl_user b on (a.post_writer = b.user_id)\r\n"
					   + "left outer join  tbl_like c using(post_no) \r\n"
					   + "inner join tbl_file d using (post_no) \r\n"
					   + "left outer join tbl_comment e using(post_no)\r\n"
					   + "group by profilephoto_path,  \r\n"
					   + "post_no, post_writer,post_writer_nickname,post_title, post_content, post_createdDate, post_view_count,category_no,\r\n"
					   + "seq_file, origin_name, system_name \r\n"
					   + "order by post_no desc";
			try(Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				ResultSet rs = pstmt.executeQuery();
				ArrayList<BoardInfoDTO> list = new ArrayList<>();
				while(rs.next()) {
					BoardInfoDTO dto = new BoardInfoDTO();
					dto.setProfilephoto_path(rs.getString("profilephoto_path"));
					dto.setPost_no(rs.getInt("post_no"));
					dto.setPost_writer(rs.getString("post_writer"));
					dto.setPost_writer_nickname(rs.getString("post_writer_nickname"));
					dto.setPost_title(rs.getString("post_title"));
					dto.setPost_content(rs.getString("post_content"));
					dto.setPost_createdDate(rs.getDate("post_createdDate"));
					dto.setPost_view_count(rs.getInt("post_view_count"));
					dto.setCategory_no(rs.getInt("category_no"));
					dto.setSeq_file(rs.getInt("seq_file"));
					dto.setOrigin_name(rs.getString("origin_name"));
					dto.setSystem_name(rs.getString("system_name"));
					dto.setLikeCnt(rs.getInt(13));
					dto.setCommentCnt(rs.getInt(14));
					list.add(dto);
				}
				if(list!=null) return list;
			}return null;
		}
		
		public int updateNickname(String subNN, String id) throws Exception {
			String sql = "update tbl_post set post_writer_nickname =? where post_writer=?";
			
			try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

				pstmt.setString(1, subNN);
				pstmt.setString(2, id);
				

				int rs = pstmt.executeUpdate();
				if (rs != -1) 
					return rs;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
}
