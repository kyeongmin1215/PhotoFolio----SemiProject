package kh.com.photofolio.dto;

import java.sql.Date;

public class MemberDTO {

	
	private String user_id;
	private int user_type;
	private String user_email;
	private String user_password;
	private String user_phone;
	private String user_nickname;
	private String user_address;
	private String profilePhoto_path;
	private Date user_signup_date;
	
	public MemberDTO() {}

	public MemberDTO(String user_id, int user_type, String user_email, String user_password, String user_phone,
			String user_nickname, String user_address, String profilePhoto_path, Date user_signup_date) {
		super();
		this.user_id = user_id;
		this.user_type = user_type;
		this.user_email = user_email;
		this.user_password = user_password;
		this.user_phone = user_phone;
		this.user_nickname = user_nickname;
		this.user_address = user_address;
		this.profilePhoto_path = profilePhoto_path;
		this.user_signup_date = user_signup_date;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getUser_type() {
		return user_type;
	}

	public void setUser_type(int user_type) {
		this.user_type = user_type;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getUser_address() {
		return user_address;
	}

	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}

	public String getProfilePhoto_path() {
		return profilePhoto_path;
	}

	public void setProfilePhoto_path(String profilePhoto_path) {
		this.profilePhoto_path = profilePhoto_path;
	}

	public Date getUser_signup_date() {
		return user_signup_date;
	}

	public void setUser_signup_date(Date user_signup_date) {
		this.user_signup_date = user_signup_date;
	}
	
	
}
