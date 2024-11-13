package com.icignal.loyalty.channel.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyChnlInsertChangeHistReqDto
 * 2. 파일명	: LoyChnlInsertChangeHistReqDto.java
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
public class LoyChnlInsertChangeHistReqDto extends CommonDataAuthReqDto{
	
	private String rid;
	private String flag;
	private String bchngVal;
	private String achngVal;
	private String chgItem;
	private String cdNm;
	private String desc1;
	private String ridParent;
	private String chgTgtType;
	private String atrb1;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
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
	public String getDesc1() {
		return desc1;
	}
	public void setDesc1(String desc1) {
		this.desc1 = desc1;
	}
	public String getRidParent() {
		return ridParent;
	}
	public void setRidParent(String ridParent) {
		this.ridParent = ridParent;
	}
	public String getChgTgtType() {
		return chgTgtType;
	}
	public void setChgTgtType(String chgTgtType) {
		this.chgTgtType = chgTgtType;
	}
	public String getAtrb1() {
		return atrb1;
	}
	public void setAtrb1(String atrb1) {
		this.atrb1 = atrb1;
	}
	
}
