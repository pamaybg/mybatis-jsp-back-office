package com.icignal.offer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class OfferJoinChnlResDto extends GridPagingItemResDto {

	// 시스템
	private String rid;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;

	// 릴레이션
	private String ridSupplyChnl;
	private String ridOfrgrpSel;
	private String ofrgrpSelNm;
	private String ridStmp;
	private String stmpNm;
	
	// 기본 필드
	private String ridOfr;			/* 연결 오퍼 RID*/
	private String ridChnlM;		/* 연결 채널 RID*/
	private String chnlNo;			/* 채널번호 */
	private String chnlNm;     		/* 채널명 */
	
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
	public String getRidSupplyChnl() {
		return ridSupplyChnl;
	}
	public void setRidSupplyChnl(String ridSupplyChnl) {
		this.ridSupplyChnl = ridSupplyChnl;
	}
	public String getRidOfrgrpSel() {
		return ridOfrgrpSel;
	}
	public void setRidOfrgrpSel(String ridOfrgrpSel) {
		this.ridOfrgrpSel = ridOfrgrpSel;
	}
	public String getOfrgrpSelNm() {
		return ofrgrpSelNm;
	}
	public void setOfrgrpSelNm(String ofrgrpSelNm) {
		this.ofrgrpSelNm = ofrgrpSelNm;
	}
	public String getRidStmp() {
		return ridStmp;
	}
	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
	public String getStmpNm() {
		return stmpNm;
	}
	public void setStmpNm(String stmpNm) {
		this.stmpNm = stmpNm;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getRidChnlM() {
		return ridChnlM;
	}
	public void setRidChnlM(String ridChnlM) {
		this.ridChnlM = ridChnlM;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
}
