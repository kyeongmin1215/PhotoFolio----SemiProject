package kh.com.photofolio.dto;

//user들의 총 게시물 수를 같이 저장하기 위해 만든 DTO
public class MemberInfoDTO {
	MemberDTO userDto; //회원정보 DTo
	int postCnt; // 해당 회원이 업로드한 총 게시물 수
	
	public MemberInfoDTO() {}

	public MemberInfoDTO(MemberDTO userDto, int postCnt) {
		super();
		this.userDto = userDto;
		this.postCnt = postCnt;
	}

	public MemberDTO getuserDto() {
		return userDto;
	}

	public void setuserDto(MemberDTO userDto) {
		this.userDto = userDto;
	}

	public int getPostCnt() {
		return postCnt;
	}

	public void setPostCnt(int postCnt) {
		this.postCnt = postCnt;
	}
	
	
}
