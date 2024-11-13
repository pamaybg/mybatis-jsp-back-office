package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyMbrGroupCngListResDto extends GridPagingItemResDto {

	private String createDate;
	private String chgItem   ;
	private String bchngVal  ;
	private String achngVal  ;
	private String cdNm      ;
	private String desc1     ;
	private String ridParent ;
	private String createBy;

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
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

}
