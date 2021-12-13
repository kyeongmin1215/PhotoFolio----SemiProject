package kh.com.photofolio.dto;

import java.sql.Date;

public class LikeDTO {
	
	// DTO가 필요한가?
	
	private String user_id;
	private int post_no;
	private Date date;
	
	public LikeDTO() {}

	public LikeDTO(String user_id, int post_no, Date date) {
		super();
		this.user_id = user_id;
		this.post_no = post_no;
		this.date = date;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getPost_no() {
		return post_no;
	}

	public void setPost_no(int post_no) {
		this.post_no = post_no;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	

}
