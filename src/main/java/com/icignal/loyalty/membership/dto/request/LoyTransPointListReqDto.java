package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyTransPointListReqDto extends CommonDataAuthReqDto {

	private String ridMbr       ;
	private String mbrStatCd    ;
	private String custNm       ;
	private String hhpNo        ;
    private String emailAddr    ;
    private String birthDt      ;
    private String mbrNo        ;
    private String pntUse       ;
    private String pntPreUse    ;
    private String cipherKey    ;
    private String pnt ;
    private String srgMbr;
    private String dropReason;
    private String tgtMbr;
    
    private String pRidMbrRcv  ;
    private String pRidMbrGiv  ;
    private String pModifyBy	;
    private String pDropMbrYn	;
    private String pReason		;
    private String    pRslt	   ;
    private String    pRsltCd	   ;
    private String    pRsltMsg    ;
     
	public String getpRslt() {
		return pRslt;
	}

	public void setpRslt(String pRslt) {
		this.pRslt = pRslt;
	}

	public String getpRsltCd() {
		return pRsltCd;
	}

	public void setpRsltCd(String pRsltCd) {
		this.pRsltCd = pRsltCd;
	}

	public String getpRsltMsg() {
		return pRsltMsg;
	}

	public void setpRsltMsg(String pRsltMsg) {
		this.pRsltMsg = pRsltMsg;
	}

	public String getpRidMbrRcv() {
		return pRidMbrRcv;
	}

	public void setpRidMbrRcv(String pRidMbrRcv) {
		this.pRidMbrRcv = pRidMbrRcv;
	}

	public String getpRidMbrGiv() {
		return pRidMbrGiv;
	}

	public void setpRidMbrGiv(String pRidMbrGiv) {
		this.pRidMbrGiv = pRidMbrGiv;
	}

	public String getpModifyBy() {
		return pModifyBy;
	}

	public void setpModifyBy(String pModifyBy) {
		this.pModifyBy = pModifyBy;
	}

	public String getpDropMbrYn() {
		return pDropMbrYn;
	}

	public void setpDropMbrYn(String pDropMbrYn) {
		this.pDropMbrYn = pDropMbrYn;
	}

	public String getpReason() {
		return pReason;
	}

	public void setpReason(String pReason) {
		this.pReason = pReason;
	}

	public String getPnt() {
		return pnt;
	}

	public void setPnt(String pnt) {
		this.pnt = pnt;
	}

	public String getSrgMbr() {
		return srgMbr;
	}

	public void setSrgMbr(String srgMbr) {
		this.srgMbr = srgMbr;
	}

	public String getDropReason() {
		return dropReason;
	}

	public void setDropReason(String dropReason) {
		this.dropReason = dropReason;
	}

	public String getTgtMbr() {
		return tgtMbr;
	}

	public void setTgtMbr(String tgtMbr) {
		this.tgtMbr = tgtMbr;
	}

	public LoyTransPointListReqDto(){
    	/* try {
             this.setCipherKey(CryptoManager.getCipherKey());
         }
         catch (Exception e) {
             LogUtil.error(e);
         }*/
    }
    
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}
	public String getBirthDt() {
		return birthDt;
	}
	public void setBirthDt(String birthDt) {
		this.birthDt = birthDt;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getPntUse() {
		return pntUse;
	}
	public void setPntUse(String pntUse) {
		this.pntUse = pntUse;
	}
	public String getPntPreUse() {
		return pntPreUse;
	}
	public void setPntPreUse(String pntPreUse) {
		this.pntPreUse = pntPreUse;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
    
    
}