package com.icignal.systemmanagement.noticebo.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemNoticeBoListResDto extends GridPagingItemResDto{

	private String rid;
	private String noticeNm;
	private String noticeContent;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;
	
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
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
}
