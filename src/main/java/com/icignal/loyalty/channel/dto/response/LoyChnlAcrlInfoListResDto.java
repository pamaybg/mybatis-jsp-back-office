package com.icignal.loyalty.channel.dto.response;

/*
 * 1. 클래스명	: LoyChnlAcrlInfoListResDto
 * 2. 파일명	: LOYChnlAcrlInfoListResponseDTO.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: 이성원
 * 5. 작성일자	: 2017. 10. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyChnlAcrlInfoListResDto {
	
	private String rid;
	private String grntMinAmt;
	private String mbrDivCd;
	private String tierCd;
	private String acrlUnit;
	private String acrlPnt;
	private String acrlPntLmt;
	private String activeYn;
	private String aplyStartDd;
	private String aplyEndDd;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrDivCd() {
		return mbrDivCd;
	}
	public void setMbrDivCd(String mbrDivCd) {
		this.mbrDivCd = mbrDivCd;
	}
	public String getTierCd() {
		return tierCd;
	}
	public void setTierCd(String tierCd) {
		this.tierCd = tierCd;
	}
	public String getAcrlUnit() {
		return acrlUnit;
	}
	public void setAcrlUnit(String acrlUnit) {
		this.acrlUnit = acrlUnit;
	}
	public String getAcrlPnt() {
		return acrlPnt;
	}
	public void setAcrlPnt(String acrlPnt) {
		this.acrlPnt = acrlPnt;
	}
	public String getAcrlPntLmt() {
		return acrlPntLmt;
	}
	public void setAcrlPntLmt(String acrlPntLmt) {
		this.acrlPntLmt = acrlPntLmt;
	}
	public String getActiveYn() {
		return activeYn;
	}
	public void setActiveYn(String activeYn) {
		this.activeYn = activeYn;
	}
	public String getAplyStartDd() {
		return aplyStartDd;
	}
	public void setAplyStartDd(String aplyStartDd) {
		this.aplyStartDd = aplyStartDd;
	}
	public String getAplyEndDd() {
		return aplyEndDd;
	}
	public void setAplyEndDd(String aplyEndDd) {
		this.aplyEndDd = aplyEndDd;
	}
	public String getGrntMinAmt() {
		return grntMinAmt;
	}
	public void setGrntMinAmt(String grntMinAmt) {
		this.grntMinAmt = grntMinAmt;
	}

}
