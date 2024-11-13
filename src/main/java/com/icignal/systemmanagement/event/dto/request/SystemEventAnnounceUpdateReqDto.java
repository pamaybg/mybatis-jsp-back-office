package com.icignal.systemmanagement.event.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemEventAnnounceUpdateReqDto extends CommonCondReqDto {
	
	private String eventId;
	private String announceStatus;
	private String announceTitle;
	private String announceDesc;
	
	private String winnerLang;

	public String getEventId() {
		return eventId;
	}

	public void setEventId(String eventId) {
		this.eventId = eventId;
	}

	public String getAnnounceStatus() {
		return announceStatus;
	}

	public void setAnnounceStatus(String announceStatus) {
		this.announceStatus = announceStatus;
	}

	public String getAnnounceTitle() {
		return announceTitle;
	}

	public void setAnnounceTitle(String announceTitle) {
		this.announceTitle = announceTitle;
	}

	public String getAnnounceDesc() {
		return announceDesc;
	}

	public void setAnnounceDesc(String announceDesc) {
		this.announceDesc = announceDesc;
	}

	public String getWinnerLang() {
		return winnerLang;
	}

	public void setWinnerLang(String winnerLang) {
		this.winnerLang = winnerLang;
	}

}
