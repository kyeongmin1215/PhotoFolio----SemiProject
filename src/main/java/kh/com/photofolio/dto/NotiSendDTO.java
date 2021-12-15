package kh.com.photofolio.dto;

public class NotiSendDTO {
	
	private NotiDTO notiDto;
	private String profilephoto_path;
	private int user_type;
	
	public NotiSendDTO() {}

	public NotiSendDTO(NotiDTO notiDto, String profilephoto_path, int user_type) {
		super();
		this.notiDto = notiDto;
		this.profilephoto_path = profilephoto_path;
		this.user_type = user_type;
	}

	public NotiDTO getNotiDto() {
		return notiDto;
	}

	public void setNotiDto(NotiDTO notiDto) {
		this.notiDto = notiDto;
	}

	public String getProfilephoto_path() {
		return profilephoto_path;
	}

	public void setProfilephoto_path(String profilephoto_path) {
		this.profilephoto_path = profilephoto_path;
	}

	public int getUser_type() {
		return user_type;
	}

	public void setUser_type(int user_type) {
		this.user_type = user_type;
	}

	
}
