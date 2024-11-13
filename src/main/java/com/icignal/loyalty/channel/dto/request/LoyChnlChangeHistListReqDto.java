package com.icignal.loyalty.channel.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyChnlChangeHistListReqDto
 * 2. 파일명	: LoyChnlChangeHistListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.request
 * 4. 작성자명	: 이성원
 * 5. 작성일자	: 2017. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyChnlChangeHistListReqDto extends CommonDataAuthReqDto{

	private String rid;
	private String createDate;
	private String chgItem;
	private String cdNm;
	private String bchngVal;
	private String achngVal;
	private String createBy;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getChgItem() {
		return chgItem;
	}
	public void setChgItem(String chgItem) {
		this.chgItem = chgItem;
	}
	public String getCdNm() {
		return cdNm;
	}
	public void setCdNm(String cdNm) {
		this.cdNm = cdNm;
	}
	public String getBchngVal() {
		return bchngVal;
	}
	public void setBchngVal(String bchngVal) {
		this.bchngVal = bchngVal;
	}
	public String getAchngVal() {
		return achngVal;
	}
	public void setAchngVal(String achngVal) {
		this.achngVal = achngVal;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

}
