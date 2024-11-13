package com.icignal.systemmanagement.event.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemEventListReqDto extends CommonCondReqDto {
	
	private String eventId;
	private String eventSubId;
	private String eventLang;

	public String getEventId() {
		return eventId;
	}

	public void setEventId(String eventId) {
		this.eventId = eventId;
	}

	public String getEventLang() {
		return eventLang;
	}

	public void setEventLang(String eventLang) {
		this.eventLang = eventLang;
	}

	public String getEventSubId() {
		return eventSubId;
	}

	public void setEventSubId(String eventSubId) {
		this.eventSubId = eventSubId;
	}

}
