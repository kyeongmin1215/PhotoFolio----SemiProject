package kh.com.photofolio.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.photofolio.dto.ReportDTO;

public class ReportDAO {
	private BasicDataSource bds;

	public ReportDAO() {
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

	// 신고 추가
	public int insert(ReportDTO dto) {
		String sql = "insert into tbl_report values(seq_report.nextval, ?, ?, ?, ?, ?, ?, sysdate)";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, dto.getReport_type());
			pstmt.setString(2, dto.getReport_writer());
			pstmt.setString(3, dto.getReport_content());
			pstmt.setInt(4, dto.getReported_post_no());
			pstmt.setInt(5, dto.getReported_comment_no());
			pstmt.setInt(6, dto.getReported_content_no());

			int rs = pstmt.executeUpdate();
			if (rs != -1)
				return rs;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;

	}

	// 신고 조회(게시글 번호로 조회)
	public ReportDTO selectBySeq(int post_no) {
		String sql = "select * from tbl_report where reported_post_no=?";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, post_no);

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				int report_no = rs.getInt("report_no");
				int report_type = rs.getInt("report_type");
				String report_writer = rs.getString("report_writer");
				String report_content = rs.getString("report_content");
				int reported_post_no = rs.getInt("reported_post_no");
				int reported_comment_no = rs.getInt("reported_comment_no");
				int report_content_no = rs.getInt("report_content_no");
				Date report_date = rs.getDate("report_date");
				return new ReportDTO(report_no, report_type, report_writer, report_content, reported_post_no,
						reported_comment_no, report_content_no, report_date);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 신고 리스트 report_type 으로 번호로 조회
	public ArrayList<ReportDTO> selectByType(int type) {
		String sql = "select * from tbl_report where report_type=?";
		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, type);

			ResultSet rs = pstmt.executeQuery();
			ArrayList<ReportDTO> list = new ArrayList<>();
			while (rs.next()) {
				int report_no = rs.getInt("report_no");
				int report_type = rs.getInt("report_type");
				String report_writer = rs.getString("report_writer");
				String report_content = rs.getString("report_content");
				int reported_post_no = rs.getInt("reported_post_no");
				int reported_comment_no = rs.getInt("reported_comment_no");
				int report_content_no = rs.getInt("report_content_no");
				Date report_date = rs.getDate("report_date");
				list.add(new ReportDTO(report_no, report_type, report_writer, report_content, reported_post_no,
						reported_comment_no, report_content_no, report_date));
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
