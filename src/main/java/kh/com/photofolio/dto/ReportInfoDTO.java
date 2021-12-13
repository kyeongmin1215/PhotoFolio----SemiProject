package kh.com.photofolio.dto;

public class ReportInfoDTO {
	ReportDTO reportDto;
	String post_title;
	String report_content;
	
	public ReportInfoDTO() {}

	public ReportInfoDTO(ReportDTO reportDto, String post_title, String report_content) {
		super();
		this.reportDto = reportDto;
		this.post_title = post_title;
		this.report_content = report_content;
	}

	public ReportDTO getReportDto() {
		return reportDto;
	}

	public void setReportDto(ReportDTO reportDto) {
		this.reportDto = reportDto;
	}

	public String getPost_title() {
		return post_title;
	}

	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}

	public String getReport_content() {
		return report_content;
	}

	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}
	
	
}
