package com.icignal.systemmanagement.event.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemEventPartiListReqDto extends CommonCondReqDto {

	
	private String eventId;
	private String event_mbr_id;
	private String check_yn;
	
	public String getEvent_mbr_id() {
		return event_mbr_id;
	}
	public void setEvent_mbr_id(String event_mbr_id) {
		this.event_mbr_id = event_mbr_id;
	}
	public String getCheck_yn() {
		return check_yn;
	}
	public void setCheck_yn(String check_yn) {
		this.check_yn = check_yn;
	}
	public String getEventId() {
		return eventId;
	}
	public void setEventId(String eventId) {
		this.eventId = eventId;
	}
}
