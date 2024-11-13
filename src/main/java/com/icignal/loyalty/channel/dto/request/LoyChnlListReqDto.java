package com.icignal.loyalty.channel.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyChnlListReqDto
 * 2. 파일명	: LoyChnlListReqDto.java
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
public class LoyChnlListReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String chnlTypeSubCd;
	private String chnlNo;
	private String chnlNm;
	private String mbrbsCdadd;
	private String parMbrbsYn;
	private String parChnlNo;
	private String parChnlNm;
	private String pointContType;
	private String mbrbsStatusCd;
	private String trmnYn;
	private String acrlPsblYn;
	
	private String dividorTypeCd;
	

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlTypeSubCd() {
		return chnlTypeSubCd;
	}
	public void setChnlTypeSubCd(String chnlTypeSubCd) {
		this.chnlTypeSubCd = chnlTypeSubCd;
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
	public String getMbrbsCdadd() {
		return mbrbsCdadd;
	}
	public void setMbrbsCdadd(String mbrbsCdadd) {
		this.mbrbsCdadd = mbrbsCdadd;
	}
	public String getParMbrbsYn() {
		return parMbrbsYn;
	}
	public void setParMbrbsYn(String parMbrbsYn) {
		this.parMbrbsYn = parMbrbsYn;
	}
	public String getParChnlNo() {
		return parChnlNo;
	}
	public void setParChnlNo(String parChnlNo) {
		this.parChnlNo = parChnlNo;
	}
	public String getParChnlNm() {
		return parChnlNm;
	}
	public void setParChnlNm(String parChnlNm) {
		this.parChnlNm = parChnlNm;
	}
	public String getPointContType() {
		return pointContType;
	}
	public void setPointContType(String pointContType) {
		this.pointContType = pointContType;
	}
	public String getMbrbsStatusCd() {
		return mbrbsStatusCd;
	}
	public void setMbrbsStatusCd(String mbrbsStatusCd) {
		this.mbrbsStatusCd = mbrbsStatusCd;
	}
	public String getTrmnYn() {
		return trmnYn;
	}
	public void setTmnYn(String trmnYn) {
		this.trmnYn = trmnYn;
	}
	public String getAcrlPsblYn() {
		return acrlPsblYn;
	}
	public void setAcrlPsblYn(String acrlPsblYn) {
		this.acrlPsblYn = acrlPsblYn;
	}
	public String getDividorTypeCd() {
		return dividorTypeCd;
	}
	public void setDividorTypeCd(String dividorTypeCd) {
		this.dividorTypeCd = dividorTypeCd;
	}
	public void setTrmnYn(String trmnYn) {
		this.trmnYn = trmnYn;
	}

}
