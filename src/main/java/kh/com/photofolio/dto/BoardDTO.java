package kh.com.photofolio.dto;

import java.sql.Date;

public class BoardDTO {
	private int post_no;
	private String post_writer;
	private String post_writer_nickname;
	private String post_title;
	private String post_content;
	private Date post_createdDate;
	private int post_view_count;
	private int category_no;

	public BoardDTO() {
	}

	public BoardDTO(int post_no, String post_writer, String post_writer_nickname, String post_title,
			String post_content, Date post_createdDate, int post_view_count, int category_no) {
		super();
		this.post_no = post_no;
		this.post_writer = post_writer;
		this.post_writer_nickname = post_writer_nickname;
		this.post_title = post_title;
		this.post_content = post_content;
		this.post_createdDate = post_createdDate;
		this.post_view_count = post_view_count;
		this.category_no = category_no;
	}

	
	
	public int getPost_no() {
		return post_no;
	}

	public void setPost_no(int post_no) {
		this.post_no = post_no;
	}

	public String getPost_writer() {
		return post_writer;
	}

	public void setPost_writer(String post_writer) {
		this.post_writer = post_writer;
	}

	public String getPost_writer_nickname() {
		return post_writer_nickname;
	}

	public void setPost_writer_nickname(String post_writer_nickname) {
		this.post_writer_nickname = post_writer_nickname;
	}

	public String getPost_title() {
		return post_title;
	}

	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}

	public String getPost_content() {
		return post_content;
	}

	public void setPost_content(String post_content) {
		this.post_content = post_content;
	}

	public Date getPost_createdDate() {
		return post_createdDate;
	}

	public void setPost_createdDate(Date post_createdDate) {
		this.post_createdDate = post_createdDate;
	}

	public int getPost_view_count() {
		return post_view_count;
	}

	public void setPost_view_count(int post_view_count) {
		this.post_view_count = post_view_count;
	}

	public int getCategory_no() {
		return category_no;
	}

	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}

}
