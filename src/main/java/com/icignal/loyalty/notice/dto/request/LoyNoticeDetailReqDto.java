package com.icignal.loyalty.notice.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class LoyNoticeDetailReqDto extends CommonCondReqDto {

	private String noticeId;
	private String noticeStatus;
	private String noticeTitle;
	private String noticeDesc;
	private String noticeLang;
	private String noticeSubId;
	private String openDate;
	private List<String> imageId;
	private String type;



	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}

	public String getNoticeStatus() {
		return noticeStatus;
	}

	public void setNoticeStatus(String noticeStatus) {
		this.noticeStatus = noticeStatus;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeDesc() {
		return noticeDesc;
	}

	public void setNoticeDesc(String noticeDesc) {
		this.noticeDesc = noticeDesc;
	}

	public String getOpenDate() {
		return openDate;
	}

	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public List<String> getImageId() {
		return imageId;
	}

	public void setImageId(List<String> imageId) {
		this.imageId = imageId;
	}

	public String getNoticeLang() {
		return noticeLang;
	}

	public void setNoticeLang(String noticeLang) {
		this.noticeLang = noticeLang;
	}

	public String getNoticeSubId() {
		return noticeSubId;
	}

	public void setNoticeSubId(String noticeSubId) {
		this.noticeSubId = noticeSubId;
	}

}
