package com.icignal.systemmanagement.event.dto.response;

import java.util.List;


public class SystemEventAnnounceDetailResDto {
	
	private String announceLang;
	private String exposure_yn;
	private String announceTitle;
	private String announceDesc;
	
	private List<String> langList;
	
	public String getAnnounceLang() {
		return announceLang;
	}
	public void setAnnounceLang(String announceLang) {
		this.announceLang = announceLang;
	}
	public String getExposure_yn() {
		return exposure_yn;
	}
	public void setExposure_yn(String exposure_yn) {
		this.exposure_yn = exposure_yn;
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
	public List<String> getLangList() {
		return langList;
	}
	public void setLangList(List<String> langList) {
		this.langList = langList;
	}
	
	

}
