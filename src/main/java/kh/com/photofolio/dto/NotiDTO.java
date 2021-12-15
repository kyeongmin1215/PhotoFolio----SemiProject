package kh.com.photofolio.dto;

import java.sql.Date;

public class NotiDTO {

	private int noti_no;
	private String noti_sender;
	private String noti_receiver;
	private String noti_msg;
	private Date noti_date;
	
	public NotiDTO() {}

	public NotiDTO(int noti_no, String noti_sender, String noti_receiver, String noti_msg, Date noti_date) {
		super();
		this.noti_no = noti_no;
		this.noti_sender = noti_sender;
		this.noti_receiver = noti_receiver;
		this.noti_msg = noti_msg;
		this.noti_date = noti_date;
	}

	public int getNoti_no() {
		return noti_no;
	}

	public void setNoti_no(int noti_no) {
		this.noti_no = noti_no;
	}

	public String getNoti_sender() {
		return noti_sender;
	}

	public void setNoti_sender(String noti_sender) {
		this.noti_sender = noti_sender;
	}

	public String getNoti_receiver() {
		return noti_receiver;
	}

	public void setNoti_receiver(String noti_receiver) {
		this.noti_receiver = noti_receiver;
	}

	public String getNoti_msg() {
		return noti_msg;
	}

	public void setNoti_msg(String noti_msg) {
		this.noti_msg = noti_msg;
	}

	public Date getNoti_date() {
		return noti_date;
	}

	public void setNoti_date(Date noti_date) {
		this.noti_date = noti_date;
	}
	
}
