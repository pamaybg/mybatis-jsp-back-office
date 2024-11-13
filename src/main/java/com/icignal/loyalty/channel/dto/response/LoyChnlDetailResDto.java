package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyChnlDetailResDto
 * 2. 파일명	: LoyChnlDetailResDto.java
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
@PersonalData
public class LoyChnlDetailResDto extends StatusResDto{

	private String rid;
	private String chnlNm;
	private String mbrbsCdadd;
	private String chnlTypeSubCd;
	private String ouTypeCd;
	private String stnDiv;
	private String zipCd;
	private String adrDtl;
	private String mbrbsStatusCd;
	private String stnMgmtDiv;
	private String roadNmAdrZipCd;
	private String roadNmAdr;
	private String bizrNo;
	private String reprNm;
	private String telNo;
	private String faxNo;
	private String trmnYn;
	private String runOnlineYn;
	@Decrypted(masked = "tel")
	private String hpNo;
	private String email;
	private String acrlPsblYn;
	private String stnPointOprtYn;
	private String stnTkcgr;
	private String stnTkcgrCmpno;
	private String mobileCouponYn;
	private String chnlNo;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getChnlTypeSubCd() {
		return chnlTypeSubCd;
	}
	public void setChnlTypeSubCd(String chnlTypeSubCd) {
		this.chnlTypeSubCd = chnlTypeSubCd;
	}
	public String getStnDiv() {
		return stnDiv;
	}
	public void setStnDiv(String stnDiv) {
		this.stnDiv = stnDiv;
	}
	public String getZipCd() {
		return zipCd;
	}
	public void setZipCd(String zipCd) {
		this.zipCd = zipCd;
	}
	public String getAdrDtl() {
		return adrDtl;
	}
	public void setAdrDtl(String adrDtl) {
		this.adrDtl = adrDtl;
	}
	public String getMbrbsStatusCd() {
		return mbrbsStatusCd;
	}
	public void setMbrbsStatusCd(String mbrbsStatusCd) {
		this.mbrbsStatusCd = mbrbsStatusCd;
	}
	public String getStnMgmtDiv() {
		return stnMgmtDiv;
	}
	public void setStnMgmtDiv(String stnMgmtDiv) {
		this.stnMgmtDiv = stnMgmtDiv;
	}
	public String getRoadNmAdrZipCd() {
		return roadNmAdrZipCd;
	}
	public void setRoadNmAdrZipCd(String roadNmAdrZipCd) {
		this.roadNmAdrZipCd = roadNmAdrZipCd;
	}
	public String getRoadNmAdr() {
		return roadNmAdr;
	}
	public void setRoadNmAdr(String roadNmAdr) {
		this.roadNmAdr = roadNmAdr;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	public String getReprNm() {
		return reprNm;
	}
	public void setReprNm(String reprNm) {
		this.reprNm = reprNm;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getFaxNo() {
		return faxNo;
	}
	public void setFaxNo(String faxNo) {
		this.faxNo = faxNo;
	}
	public String getTrmnYn() {
		return trmnYn;
	}
	public void setTrmnYn(String trmnYn) {
		this.trmnYn = trmnYn;
	}
	public String getRunOnlineYn() {
		return runOnlineYn;
	}
	public void setRunOnlineYn(String runOnlineYn) {
		this.runOnlineYn = runOnlineYn;
	}
	public String getHpNo() {
		return hpNo;
	}
	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAcrlPsblYn() {
		return acrlPsblYn;
	}
	public void setAcrlPsblYn(String acrlPsblYn) {
		this.acrlPsblYn = acrlPsblYn;
	}
	public String getStnPointOprtYn() {
		return stnPointOprtYn;
	}
	public void setStnPointOprtYn(String stnPointOprtYn) {
		this.stnPointOprtYn = stnPointOprtYn;
	}
	public String getStnTkcgr() {
		return stnTkcgr;
	}
	public void setStnTkcgr(String stnTkcgr) {
		this.stnTkcgr = stnTkcgr;
	}
	public String getStnTkcgrCmpno() {
		return stnTkcgrCmpno;
	}
	public void setStnTkcgrCmpno(String stnTkcgrCmpno) {
		this.stnTkcgrCmpno = stnTkcgrCmpno;
	}
	public String getMobileCouponYn() {
		return mobileCouponYn;
	}
	public void setMobileCouponYn(String mobileCouponYn) {
		this.mobileCouponYn = mobileCouponYn;
	}
	public String getOuTypeCd() {
		return ouTypeCd;
	}
	public void setOuTypeCd(String ouTypeCd) {
		this.ouTypeCd = ouTypeCd;
	}
	/**
	* @return the chnlNo
	*/
	public String getChnlNo() {
		return chnlNo;
	}
	/**
	* @param chnlNo the chnlNo to set
	*/
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}


}
