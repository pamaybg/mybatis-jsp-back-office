package com.icignal.systemmanagement.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemEventListResDto extends GridPagingItemResDto {

	private String eventStatus;
	private String eventName;
	private String eventPeriod;
	private String eventShowCnt;
	private String eventPartiCnt;
	private String eventWriter;
	private String eventRegDate;
	private String eventModDate;
	private String eventPrizewinnerDate;
	private String eventShowStatus;

	private String rid;

	private String event_lang;
	private String appPopYn;
	private String seq;


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
	public String getEventName() {
		return eventName;
	}
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	public String getEventPeriod() {
		return eventPeriod;
	}
	public void setEventPeriod(String eventPeriod) {
		this.eventPeriod = eventPeriod;
	}
	public String getEventShowCnt() {
		return eventShowCnt;
	}
	public void setEventShowCnt(String eventShowCnt) {
		this.eventShowCnt = eventShowCnt;
	}
	public String getEventPartiCnt() {
		return eventPartiCnt;
	}
	public void setEventPartiCnt(String eventPartiCnt) {
		this.eventPartiCnt = eventPartiCnt;
	}
	public String getEventWriter() {
		return eventWriter;
	}
	public void setEventWriter(String eventWriter) {
		this.eventWriter = eventWriter;
	}
	public String getEventRegDate() {
		return eventRegDate;
	}
	public void setEventRegDate(String eventRegDate) {
		this.eventRegDate = eventRegDate;
	}
	public String getEventModDate() {
		return eventModDate;
	}
	public void setEventModDate(String eventModDate) {
		this.eventModDate = eventModDate;
	}
	public String getEventPrizewinnerDate() {
		return eventPrizewinnerDate;
	}
	public void setEventPrizewinnerDate(String eventPrizewinnerDate) {
		this.eventPrizewinnerDate = eventPrizewinnerDate;
	}
	public String getEventShowStatus() {
		return eventShowStatus;
	}
	public void setEventShowStatus(String eventShowStatus) {
		this.eventShowStatus = eventShowStatus;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getEvent_lang() {
		return event_lang;
	}
	public void setEvent_lang(String event_lang) {
		this.event_lang = event_lang;
	}



}
