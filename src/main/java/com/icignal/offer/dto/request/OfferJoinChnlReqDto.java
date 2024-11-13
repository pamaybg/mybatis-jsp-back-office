package com.icignal.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class OfferJoinChnlReqDto extends CommonDataAuthReqDto {

	// 시스템
	private String rid;

	// 릴레이션
	private String ridSupplyChnl;
	private String ridOfrgrpSel;
	private String ridStmp;
	private String prodLimitYn;
	private String chnlLimitYn;
	// 코드
	private String ridOfr;
	private String ridChnlM;
	private String relTypeCd;
	
	private String offYn;
	
	//getter, setter
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getRidStmp() {
		return ridStmp;
	}
	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
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
	public String getRelTypeCd() {
		return relTypeCd;
	}
	public void setRelTypeCd(String relTypeCd) {
		this.relTypeCd = relTypeCd;
	}
	public String getProdLimitYn() {
		return prodLimitYn;
	}
	public void setProdLimitYn(String prodLimitYn) {
		this.prodLimitYn = prodLimitYn;
	}
	public String getChnlLimitYn() {
		return chnlLimitYn;
	}
	public void setChnlLimitYn(String chnlLimitYn) {
		this.chnlLimitYn = chnlLimitYn;
	}
	public String getOffYn() {
		return offYn;
	}
	public void setOffYn(String offYn) {
		this.offYn = offYn;
	}
	
}
