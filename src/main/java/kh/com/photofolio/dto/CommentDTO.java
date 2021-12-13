package kh.com.photofolio.dto;

import java.sql.Date;

public class CommentDTO {
	private int comment_no;
	private int post_no;
	private String comment_writer_id;
	private String comment_content;
	private Date comment_createdDate;

	public CommentDTO() {
	}

	public CommentDTO(int comment_no, int post_no, String comment_writer_id, String comment_content,
			Date comment_createdDate) {
		super();
		this.comment_no = comment_no;
		this.post_no = post_no;
		this.comment_writer_id = comment_writer_id;
		this.comment_content = comment_content;
		this.comment_createdDate = comment_createdDate;
	}

	public int getComment_no() {
		return comment_no;
	}

	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}

	public int getPost_no() {
		return post_no;
	}

	public void setPost_no(int post_no) {
		this.post_no = post_no;
	}

	public String getComment_writer_id() {
		return comment_writer_id;
	}

	public void setComment_writer_id(String comment_writer_id) {
		this.comment_writer_id = comment_writer_id;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public Date getComment_createdDate() {
		return comment_createdDate;
	}

	public void setComment_createdDate(Date comment_createdDate) {
		this.comment_createdDate = comment_createdDate;
	}

}
