package kh.com.photofolio.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CommentPlusDTO {

	private int comment_no;
	private int post_no;
	private String user_id;
	private String user_nickname;
	private String content;
	private Date createdDate;
	
	public CommentPlusDTO() {}

	public CommentPlusDTO(int comment_no, int post_no, String user_id, String user_nickname, String content,
			Date createdDate) {
		super();
		this.comment_no = comment_no;
		this.post_no = post_no;
		this.user_id = user_id;
		this.user_nickname = user_nickname;
		this.content = content;
		this.createdDate = createdDate;
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

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	
	
}
