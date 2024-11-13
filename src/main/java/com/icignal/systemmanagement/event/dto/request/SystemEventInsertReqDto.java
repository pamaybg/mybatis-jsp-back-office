package com.icignal.systemmanagement.event.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemEventInsertReqDto extends CommonCondReqDto {

	private String eventStatus;
	private String startDate;
	private String endDate;
	private String win_notice_date;
	private String win_notice_exposure;
	private Boolean updateFlag;
	private String seq;
	private String eventId;
	private String appPopYn;


	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getAppPopYn() {
		return appPopYn;
	}
	public void setAppPopYn(String appPopYn) {
		this.appPopYn = appPopYn;
	}
	public String getEventStatus() {
		return eventStatus;
	}
	public void setEventStatus(String eventStatus) {
		this.eventStatus = eventStatus;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getWin_notice_date() {
		return win_notice_date;
	}
	public void setWin_notice_date(String win_notice_date) {
		this.win_notice_date = win_notice_date;
	}
	public String getWin_notice_exposure() {
		return win_notice_exposure;
	}
	public void setWin_notice_exposure(String win_notice_exposure) {
		this.win_notice_exposure = win_notice_exposure;
	}
	public Boolean getUpdateFlag() {
		return updateFlag;
	}
	public void setUpdateFlag(Boolean updateFlag) {
		this.updateFlag = updateFlag;
	}
	public String getEventId() {
		return eventId;
	}
	public void setEventId(String eventId) {
		this.eventId = eventId;
	}

}
