package kh.com.photofolio.dto;

public class FollowDTO {
	
	// 팔로잉, 팔로워 목록 가져오는 용도
	// 팔로잉 테이블과 매칭되지 않음을 주의
	
	private String user_id;
	private String user_nickname;
	private String profilePhoto_path;
	
	public FollowDTO() {}

	public FollowDTO(String user_id, String user_nickname, String profilePhoto_path) {
		super();
		this.user_id = user_id;
		this.user_nickname = user_nickname;
		this.profilePhoto_path = profilePhoto_path;
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

	public String getProfilePhoto_path() {
		return profilePhoto_path;
	}

	public void setProfilePhoto_path(String profilePhoto_path) {
		this.profilePhoto_path = profilePhoto_path;
	}

}
