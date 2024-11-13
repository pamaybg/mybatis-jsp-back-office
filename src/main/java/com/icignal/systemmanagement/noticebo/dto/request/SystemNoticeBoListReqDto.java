package com.icignal.systemmanagement.noticebo.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class SystemNoticeBoListReqDto extends CommonDataAuthReqDto{

	private String rid;
	private String noticeNm;
	private String noticeContent;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getNoticeNm() {
		return noticeNm;
	}
	public void setNoticeNm(String noticeNm) {
		this.noticeNm = noticeNm;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
}
