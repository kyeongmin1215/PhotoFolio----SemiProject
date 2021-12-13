package kh.com.photofolio.dto;

import java.sql.Date;

public class ReportDTO {
	private int report_no;
	private int report_type;
	private String report_writer;
	private String report_content;
	private int reported_post_no;
	private int reported_comment_no;
	private int reported_content_no;
	private Date report_date;

	public ReportDTO() {
	}

	public ReportDTO(int report_no, int report_type, String report_writer, String report_content, int reported_post_no,
			int reported_comment_no, int reported_content_no, Date report_date) {
		super();
		this.report_no = report_no;
		this.report_type = report_type;
		this.report_writer = report_writer;
		this.report_content = report_content;
		this.reported_post_no = reported_post_no;
		this.reported_comment_no = reported_comment_no;
		this.reported_content_no = reported_content_no;
		this.report_date = report_date;
	}

	public int getReport_no() {
		return report_no;
	}

	public void setReport_no(int report_no) {
		this.report_no = report_no;
	}

	public int getReport_type() {
		return report_type;
	}

	public void setReport_type(int report_type) {
		this.report_type = report_type;
	}

	public String getReport_writer() {
		return report_writer;
	}

	public void setReport_writer(String report_writer) {
		this.report_writer = report_writer;
	}

	public String getReport_content() {
		return report_content;
	}

	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}

	public int getReported_post_no() {
		return reported_post_no;
	}

	public void setReported_post_no(int reported_post_no) {
		this.reported_post_no = reported_post_no;
	}

	public int getReported_comment_no() {
		return reported_comment_no;
	}

	public void setReported_comment_no(int reported_comment_no) {
		this.reported_comment_no = reported_comment_no;
	}

	public int getReported_content_no() {
		return reported_content_no;
	}

	public void setReported_content_no(int reported_content_no) {
		this.reported_content_no = reported_content_no;
	}

	public Date getReport_date() {
		return report_date;
	}

	public void setReport_date(Date report_date) {
		this.report_date = report_date;
	}

}
