package kh.com.photofolio.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.photofolio.dto.*;

public class Admin_reportDAO {
//신고에 관한 기능들을 담아둔 클래스	

	private BasicDataSource bds;

	public Admin_reportDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context) iCtx.lookup("java:comp/env");
			bds = (BasicDataSource) envCtx.lookup("jdbc/bds");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public Connection getConnection() throws SQLException {
		return bds.getConnection();
	}

	public int today_reportCnt() throws Exception { // 오늘의 신고 건수 반환
		String sql = "SELECT COUNT(*) FROM TBL_REPORT WHERE TO_CHAR(REPORT_DATE,'YYYYMMDD') = TO_CHAR(SYSDATE,'YYYYMMDD')";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			ResultSet rs = pstmt.executeQuery();
			int report = 0;
			if (rs.next()) return report = rs.getInt(1);
		}return -1;
	}

	public ArrayList<ReportInfoDTO> getReportList(int startRange, int endRange) throws Exception { // 전체 신고 내역 반환
		String sql = "select * from (SELECT row_number() over (order by REPORT_DATE desc) 순위, "
				+ "REPORT_NO, REPORT_TYPE, POST_TITLE, C.REPORT_CONTENT, REPORT_DATE \r\n" + "FROM TBL_REPORT A\r\n"
				+ "INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO)\r\n"
				+ "INNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO)\r\n"
				+ "ORDER BY REPORT_DATE DESC ) where 순위 between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ReportInfoDTO> list = new ArrayList<>();
			while (rs.next()) {
				ReportDTO dto = new ReportDTO();
				dto.setReport_no(rs.getInt(2));
				dto.setReport_type(rs.getInt(3));
				String post_title = rs.getString(4);
				String report_content = rs.getString(5);
				dto.setReport_date(rs.getDate(6));
				list.add(new ReportInfoDTO(dto, post_title, report_content));
			}
			if (list != null) return list;
		} return null;
	}

	public int getReportListCnt() throws Exception { // 전체 신고 내역 갯수 반환
		String sql = "select count(*) from (SELECT row_number() over (order by REPORT_DATE desc) 순위, "
				+ "REPORT_NO, REPORT_TYPE, POST_TITLE, C.REPORT_CONTENT, REPORT_DATE \r\n" + "FROM TBL_REPORT A\r\n"
				+ "INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO)\r\n"
				+ "INNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO)\r\n" + "ORDER BY REPORT_DATE)";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) return rs.getInt(1);
		}return -1;
	}

	public ArrayList<ReportInfoDTO> getReportByReportType(String value, int startRange, int endRange) throws Exception { // 신고타입으로
																															// 검색
		String sql = "select * from (SELECT  row_number() over (order by report_no desc) 순위, "
				+ "REPORT_NO, REPORT_TYPE, POST_TITLE, REPORT_WRITER, USER_NICKNAME ,C.REPORT_CONTENT, REPORT_DATE \r\n"
				+ "FROM TBL_REPORT A \r\n" + "INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO)\r\n"
				+ "iNNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO) \r\n"
				+ "INNER JOIN TBL_USER D ON (A.REPORT_WRITER = D.USER_ID) \r\n" + "WHERE c.report_content like '%"
				+ value + "%') where 순위 between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ReportInfoDTO> list = new ArrayList<>();
			while (rs.next()) {
				ReportDTO dto = new ReportDTO();
				dto.setReport_no(rs.getInt(2));
				dto.setReport_type(rs.getInt(3));
				String post_title = rs.getString(4);
				String report_content = rs.getString(7);
				dto.setReport_date(rs.getDate(8));
				list.add(new ReportInfoDTO(dto, post_title, report_content));
			}
			if (list != null) return list;
		} return null;
	}

	public int getReportByReportTypeCnt(String value) throws Exception { // 신고타입 내역 갯수
		String sql = "select count(*) from (SELECT  row_number() over (order by report_no desc) 순위, "
				+ "REPORT_NO, REPORT_TYPE, POST_TITLE, REPORT_WRITER, USER_NICKNAME ,C.REPORT_CONTENT, REPORT_DATE \r\n"
				+ "FROM TBL_REPORT A \r\n" + "INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO)\r\n"
				+ "iNNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO) \r\n"
				+ "INNER JOIN TBL_USER D ON (A.REPORT_WRITER = D.USER_ID)) \r\n";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) return rs.getInt(1);
		}return -1;
	}

	public ArrayList<ReportInfoDTO> getReportByreportNo(String value, int startRange, int endRange) throws Exception{ // 신고번호로 검색
		String sql = "select * from (SELECT  row_number() over (order by post_no desc) 순위, REPORT_NO, REPORT_TYPE, POST_TITLE, REPORT_WRITER, USER_NICKNAME ,C.REPORT_CONTENT, REPORT_DATE \r\n"
				+ "FROM TBL_REPORT A \r\n" + "INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO)\r\n"
				+ "iNNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO) \r\n"
				+ "INNER JOIN TBL_USER D ON (A.REPORT_WRITER = D.USER_ID) \r\n"
				+ "WHERE a.report_no=?) where 순위 between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, value);
			pstmt.setInt(2, startRange);
			pstmt.setInt(3, endRange);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ReportInfoDTO> list = new ArrayList<>();
			while (rs.next()) {
				ReportDTO dto = new ReportDTO();
				dto.setReport_no(rs.getInt(2));
				dto.setReport_type(rs.getInt(3));
				String post_title = rs.getString(4);
				String report_content = rs.getString(7);
				dto.setReport_date(rs.getDate(8));
				list.add(new ReportInfoDTO(dto, post_title, report_content));
			}
			if(list!=null) return list;
		} 
		return null;
	}

	public int getReportByreportNoCnt(String value) throws Exception{ // 신고번호 갯수로 검색
		String sql = "select count(*) from (SELECT  row_number() over (order by post_no desc) 순위, REPORT_NO, REPORT_TYPE, POST_TITLE, REPORT_WRITER, USER_NICKNAME ,C.REPORT_CONTENT, REPORT_DATE \r\n"
				+ "FROM TBL_REPORT A \r\n" + "INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO)\r\n"
				+ "iNNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO) \r\n"
				+ "INNER JOIN TBL_USER D ON (A.REPORT_WRITER = D.USER_ID) \r\n" + "WHERE a.report_no=?)";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, value);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) return rs.getInt(1);
		} 
		return -1;
	}
	
	

//	public int getReportByReportContentCnt(String value) { // 신고타입 내역 갯수
//		String sql = "select count(*) from (SELECT  row_number() over (order by report_no desc) 순위, "
//				+ "REPORT_NO, REPORT_TYPE, POST_TITLE, REPORT_WRITER, USER_NICKNAME ,C.REPORT_CONTENT, REPORT_DATE \r\n"
//				+ "FROM TBL_REPORT A \r\n" + "INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO)\r\n"
//				+ "iNNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO) \r\n"
//				+ "INNER JOIN TBL_USER D ON (A.REPORT_WRITER = D.USER_ID) \r\n" + "WHERE c.report_content like '%"
//				+ value + "%')";
//		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
//			ResultSet rs = pstmt.executeQuery();
//			int recordTotalCnt = -1;
//			if (rs.next()) {
//				recordTotalCnt = rs.getInt(1);
//			}
//			return recordTotalCnt;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return -1;
//	}
//	

	public ArrayList<ReportInfoDTO> getReportByReportContent(String value, int startRange, int endRange) throws Exception{ // 사용자 신고
																											// 내용으로 검색
		String sql = "select * from (SELECT row_number() over (order by post_no desc) 순위, "
				+ "REPORT_NO, REPORT_TYPE, POST_TITLE, REPORT_WRITER, USER_NICKNAME ,C.REPORT_CONTENT, REPORT_DATE \r\n"
				+ "FROM TBL_REPORT A INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO) \r\n"
				+ "INNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO) \r\n"
				+ "INNER JOIN TBL_USER D ON (A.REPORT_WRITER = D.USER_ID) WHERE a.report_content like '%" + value
				+ "%') " + "where 순위 between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ReportInfoDTO> list = new ArrayList<>();
			while (rs.next()) {
				ReportDTO dto = new ReportDTO();
				dto.setReport_no(rs.getInt(2));
				dto.setReport_type(rs.getInt(3));
				String post_title = rs.getString(4);
				String report_content = rs.getString(7);
				dto.setReport_date(rs.getDate(8));
				list.add(new ReportInfoDTO(dto, post_title, report_content));
			}
			if(list!=null) return list;
		}return null;
	}

	public int getReportByReportContentCnt(String value) throws Exception{ // 신고 (사용자 입력) 내용으로 검색
		String sql = "select count(*) from (SELECT row_number() over (order by post_no desc) 순위, "
				+ "REPORT_NO, REPORT_TYPE, POST_TITLE, REPORT_WRITER, USER_NICKNAME ,C.REPORT_CONTENT, REPORT_DATE \r\n"
				+ "FROM TBL_REPORT A INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO) \r\n"
				+ "INNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO) \r\n"
				+ "INNER JOIN TBL_USER D ON (A.REPORT_WRITER = D.USER_ID) WHERE a.report_content like '%" + value
				+ "%')";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) return rs.getInt(1);
		}return -1;
	}

	// 바꿔바꿔 idornicknmae으로

	public ArrayList<ReportInfoDTO> getReportByIdOrNickname(String value, int startRange, int endRange) throws Exception{ // 사용자 신고 내용으로
																											// 검색
		String sql = "select * from (SELECT row_number() over (order by post_no desc) 순위, "
				+ "REPORT_NO, REPORT_TYPE, POST_TITLE, POST_CONTENT, REPORT_WRITER, USER_NICKNAME ,C.REPORT_CONTENT, REPORT_DATE \r\n"
				+ "FROM TBL_REPORT A INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO) \r\n"
				+ "INNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO) \r\n"
				+ "INNER JOIN TBL_USER D ON (A.REPORT_WRITER = D.USER_ID) " + "WHERE  REPORT_WRITER LIKE '%" + value
				+ "%' OR USER_NICKNAME LIKE '%" + value + "%') where 순위 between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ReportInfoDTO> list = new ArrayList<>();
			while (rs.next()) {
				ReportDTO dto = new ReportDTO();
				dto.setReport_no(rs.getInt(2));
				dto.setReport_type(rs.getInt(3));
				String post_title = rs.getString(4);
				String report_content = rs.getString(8);
				dto.setReport_date(rs.getDate(9));
				list.add(new ReportInfoDTO(dto, post_title, report_content));
			}
			if(list!=null) return list;
		}return null;
	}

	public int getReportByIdOrNicknameCnt(String value) throws Exception{ // 사용자 신고 내용으로 검색
		String sql = "select count(*) from (SELECT row_number() over (order by post_no desc) 순위, "
				+ "REPORT_NO, REPORT_TYPE, POST_TITLE, POST_CONTENT, REPORT_WRITER, USER_NICKNAME ,C.REPORT_CONTENT, REPORT_DATE \r\n"
				+ "FROM TBL_REPORT A INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO) \r\n"
				+ "INNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO) \r\n"
				+ "INNER JOIN TBL_USER D ON (A.REPORT_WRITER = D.USER_ID) " + "WHERE  REPORT_WRITER LIKE '%" + value
				+ "%' OR USER_NICKNAME LIKE '%" + value + "%')";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) return rs.getInt(1);
		}return -1;
	}

////////////////////////////////////////////////////////////////////////////////////////////	

	// 바꿔바꿔 keyword로

	public ArrayList<ReportInfoDTO> getReportByKeyword(String value, int startRange, int endRange) throws Exception{ // 게시물 제목/내용으로 검색
		String sql = "select * from (SELECT row_number() over (order by post_no desc) 순위, "
				+ "REPORT_NO, REPORT_TYPE, POST_TITLE, POST_CONTENT, REPORT_WRITER, USER_NICKNAME ,C.REPORT_CONTENT, REPORT_DATE\r\n"
				+ "FROM TBL_REPORT A INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO)\r\n"
				+ "iNNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO) \r\n"
				+ "INNER JOIN TBL_USER D ON (A.REPORT_WRITER = D.USER_ID) " + "WHERE  POST_TITLE LIKE '%" + value
				+ "%' OR POST_CONTENT LIKE '%" + value + "%') where 순위 between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ReportInfoDTO> list = new ArrayList<>();
			while (rs.next()) {
				ReportDTO dto = new ReportDTO();
				dto.setReport_no(rs.getInt(2));
				dto.setReport_type(rs.getInt(3));
				String post_title = rs.getString(4);
				String report_content = rs.getString(8);
				dto.setReport_date(rs.getDate(9));
				list.add(new ReportInfoDTO(dto, post_title, report_content));
			}
			if(list!=null) return list;
		}return null;
	}

	public int getReportByKeywordCnt(String value) throws Exception{ // 게시물 제목/내용으로 검색
		String sql = "select count(*) from (SELECT row_number() over (order by post_no desc) 순위, "
				+ "REPORT_NO, REPORT_TYPE, POST_TITLE, POST_CONTENT, REPORT_WRITER, USER_NICKNAME ,C.REPORT_CONTENT, REPORT_DATE\r\n"
				+ "FROM TBL_REPORT A INNER JOIN TBL_POST B ON (A.REPORTED_POST_NO =  B.POST_NO)\r\n"
				+ "iNNER JOIN TBL_REPORT_CONTENT C USING (REPORT_CONTENT_NO) \r\n"
				+ "INNER JOIN TBL_USER D ON (A.REPORT_WRITER = D.USER_ID) " + "WHERE  POST_TITLE LIKE '%" + value
				+ "%' OR POST_CONTENT LIKE '%" + value + "%')";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) return rs.getInt(1);
		}return -1;
	}

////////////////////////////////////////////////////////////////////////////////////////////	

	public int deleteReport(String report_no) throws Exception{
		String sql = "DELETE FROM TBL_REPORT WHERE REPORT_NO IN (" + report_no + ")";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			int rs = pstmt.executeUpdate();
			if (rs != 0) return 1;
		}return -1;
	}

	public ReportDTO getReportInfo(String report_no) throws Exception{//매개변수 String주의
		String sql = "select * from tbl_report where report_no=?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, report_no);
			ResultSet rs = pstmt.executeQuery();
			ReportDTO dto = new ReportDTO();
			if(rs.next()) {
				dto.setReport_no(rs.getInt(1));
				dto.setReport_type(rs.getInt(2));
				dto.setReport_writer(rs.getString(3));
				dto.setReport_content(rs.getString(4));
				dto.setReported_post_no(rs.getInt(5));
				dto.setReported_comment_no(rs.getInt(6));
				dto.setReported_content_no(rs.getInt(7));
				dto.setReport_date(rs.getDate(8));
				return dto;
			}
		}return null;
	}
	public BoardDTO getPostInfo(int post_no) throws Exception{
		String sql = "select * from tbl_post where post_no = ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, post_no);
			ResultSet rs = pstmt.executeQuery();
			BoardDTO dto = new BoardDTO();
			if(rs.next()) {
				dto.setPost_no(rs.getInt(1));
				dto.setPost_writer(rs.getString(2));
				dto.setPost_title(rs.getString(4));
				dto.setPost_content(rs.getString(5));
				return dto;
			}
		}return null;
	}
	
	public CommentDTO getCommentInfo(int comment_no) throws Exception{
		String sql = "select * from tbl_comment where comment_no = ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, comment_no);
			ResultSet rs = pstmt.executeQuery();
			CommentDTO dto = new CommentDTO();
			if(rs.next()) {
				dto.setComment_no(rs.getInt(1));
				dto.setComment_writer_id(rs.getString(3));
				dto.setComment_content(rs.getString(4));
				dto.setComment_createdDate(rs.getDate(5));
				return dto;
			}
		}return null;
	}
	
}
