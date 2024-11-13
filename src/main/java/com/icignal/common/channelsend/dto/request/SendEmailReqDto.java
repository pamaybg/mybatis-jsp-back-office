package com.icignal.common.channelsend.dto.request;

public class SendEmailReqDto {

	private String from_name;
	private String from_email;
	private String to_name;
	private String to_email;
	private String subject;
	private String map_content;

	public String getFrom_name() {
		return from_name;
	}
	public void setFrom_name(String from_name) {
		this.from_name = from_name;
	}
	public String getFrom_email() {
		return from_email;
	}
	public void setFrom_email(String from_email) {
		this.from_email = from_email;
	}
	public String getTo_name() {
		return to_name;
	}
	public void setTo_name(String to_name) {
		this.to_name = to_name;
	}
	public String getTo_email() {
		return to_email;
	}
	public void setTo_email(String to_email) {
		this.to_email = to_email;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMap_content() {
		return map_content;
	}
	public void setMap_content(String map_content) {
		this.map_content = map_content;
	}

}
