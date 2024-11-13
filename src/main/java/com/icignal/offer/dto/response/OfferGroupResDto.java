package com.icignal.offer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class OfferGroupResDto extends GridPagingItemResDto {
	
	// 시스템
	private String rid;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;
	
	// 코드
	private String statCd;
    @MarkName(groupCode = "LOY_OFR_STAT_TYPE", codeField = "statCd")
    private String statCdNm;
    private String ofrgrpType;
	@MarkName(groupCode = "LOY_OFRGRP_TYPE", codeField = "ofrgrpType")
    private String ofrgrpTypeNm;

	// 기본 필드
	private String ofrgrpNo;
	private String ofrgrpNm;
	private String descText;
	private String totAmt;
	
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
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}
	public String getOfrgrpType() {
		return ofrgrpType;
	}
	public void setOfrgrpType(String ofrgrpType) {
		this.ofrgrpType = ofrgrpType;
	}
	public String getOfrgrpTypeNm() {
		return ofrgrpTypeNm;
	}
	public void setOfrgrpTypeNm(String ofrgrpTypeNm) {
		this.ofrgrpTypeNm = ofrgrpTypeNm;
	}
	public String getOfrgrpNo() {
		return ofrgrpNo;
	}
	public void setOfrgrpNo(String ofrgrpNo) {
		this.ofrgrpNo = ofrgrpNo;
	}
	public String getOfrgrpNm() {
		return ofrgrpNm;
	}
	public void setOfrgrpNm(String ofrgrpNm) {
		this.ofrgrpNm = ofrgrpNm;
	}
	public String getDescText() {
		return descText;
	}
	public void setDescText(String descText) {
		this.descText = descText;
	}
	public String getTotAmt() {
		return totAmt;
	}
	public void setTotAmt(String totAmt) {
		this.totAmt = totAmt;
	}

}
