package com.icignal.loyalty.channel.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyChnlDetailReqDto
 * 2. 파일명	: LoyChnlDetailReqDto.java
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
public class LoyChnlDetailReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String chnlNm;
	private String mbrbsCdadd;
	private String chnlTypeSubCd;
	private String stnDiv;
	private String zipCd;
	private String adrDtl;
	private String mbrbsStatusCd;
	private String mgmtChnlNm;
	private String roadNmAdrZipCd;
	private String roadNmAdr;
	private String bizrNo;
	private String reprNm;
	private String telNo;
	private String faxNo;
	private String trmnYn;
	private String runOnlineYn;
	private String hpNo;
	private String email;
	private String acrlPsblYn;
	private String stnPointOprtYn;
	private String stnTkcgr;
	private String stnTkcgrCmpno;
	private String mobileSouponYn;
//	private String cipherKey;
	
//   public LoyChannelDetailReqDto() {
//        try {
//            this.setCipherKey(CryptoManager.getCipherKey());
//        }
//        catch ( Exception e ) {
//            LogUtil.error(e);
//        }
//    }
	   
   
	   
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
	public String getMgmtChnlNm() {
		return mgmtChnlNm;
	}
	public void setMgmtChnlNm(String mgmtChnlNm) {
		this.mgmtChnlNm = mgmtChnlNm;
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
	public String getMobileSouponYn() {
		return mobileSouponYn;
	}
	public void setMobileSouponYn(String mobileSouponYn) {
		this.mobileSouponYn = mobileSouponYn;
	}

//	public String getCipherKey() {
//		return cipherKey;
//	}
//	public void setCipherKey(String cipherKey) {
//		this.cipherKey = cipherKey;
//	}
	
}
