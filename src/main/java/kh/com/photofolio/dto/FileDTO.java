package kh.com.photofolio.dto;

public class FileDTO {
	private int seq_file;
	private int post_no;
	private String origin_name;
	private String system_name;

	public FileDTO() {
	}

	public FileDTO(int seq_file, int post_no, String origin_name, String system_name) {
		super();
		this.seq_file = seq_file;
		this.post_no = post_no;
		this.origin_name = origin_name;
		this.system_name = system_name;
	}

	public int getSeq_file() {
		return seq_file;
	}

	public void setSeq_file(int seq_file) {
		this.seq_file = seq_file;
	}

	public int getPost_no() {
		return post_no;
	}

	public void setPost_no(int post_no) {
		this.post_no = post_no;
	}

	public String getOrigin_name() {
		return origin_name;
	}

	public void setOrigin_name(String origin_name) {
		this.origin_name = origin_name;
	}

	public String getSystem_name() {
		return system_name;
	}

	public void setSystem_name(String system_name) {
		this.system_name = system_name;
	}

}