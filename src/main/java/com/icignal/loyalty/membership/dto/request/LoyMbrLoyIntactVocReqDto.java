package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.Loyalty.member.mbr.dto.request.LoyMbrLoyIntactVocRequestDTO
* @date : 2018. 11. 12.
* @author : hy.jun
* @description : Loy_intact_voc 테이블
*/
public class LoyMbrLoyIntactVocReqDto extends MKTBaseReqDto {
	private String rid;
	private String ridIntactType;
	private String occuDate;
	private String ridMbr;
	private String ridChnl;
	private String calcCmpltDate;
	private String cmpltDate;
	private String acrlExcptReasCd;
	private String vocNo;
	private String vocReasCd;
	private String vocReqby;
	private String rcptNo;
	private String vocReqAmt;
	private String offerId;
	private String vocDesc;
	private String pntTxnType;
	private String pntTxnDtlType;
	
	private String pntTxnType_1Cd;
	private String pntTxnType_2Cd;
	
	private String ridMktCamMst;
	
	private String chnlNo; //ridChnl 찾아서 넣어주기 위함.
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidIntactType() {
		return ridIntactType;
	}
	public void setRidIntactType(String ridIntactType) {
		this.ridIntactType = ridIntactType;
	}
	public String getOccuDate() {
		return occuDate;
	}
	public void setOccuDate(String occuDate) {
		this.occuDate = occuDate;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getCalcCmpltDate() {
		return calcCmpltDate;
	}
	public void setCalcCmpltDate(String calcCmpltDate) {
		this.calcCmpltDate = calcCmpltDate;
	}
	public String getCmpltDate() {
		return cmpltDate;
	}
	public void setCmpltDate(String cmpltDate) {
		this.cmpltDate = cmpltDate;
	}
	public String getAcrlExcptReasCd() {
		return acrlExcptReasCd;
	}
	public void setAcrlExcptReasCd(String acrlExcptReasCd) {
		this.acrlExcptReasCd = acrlExcptReasCd;
	}
	public String getVocNo() {
		return vocNo;
	}
	public void setVocNo(String vocNo) {
		this.vocNo = vocNo;
	}
	public String getVocReasCd() {
		return vocReasCd;
	}
	public void setVocReasCd(String vocReasCd) {
		this.vocReasCd = vocReasCd;
	}
	public String getVocReqby() {
		return vocReqby;
	}
	public void setVocReqby(String vocReqby) {
		this.vocReqby = vocReqby;
	}
	public String getRcptNo() {
		return rcptNo;
	}
	public void setRcptNo(String rcptNo) {
		this.rcptNo = rcptNo;
	}
	public String getVocReqAmt() {
		return vocReqAmt;
	}
	public void setVocReqAmt(String vocReqAmt) {
		this.vocReqAmt = vocReqAmt;
	}
	public String getOfferId() {
		return offerId;
	}
	public void setOfferId(String offerId) {
		this.offerId = offerId;
	}
	public String getVocDesc() {
		return vocDesc;
	}
	public void setVocDesc(String vocDesc) {
		this.vocDesc = vocDesc;
	}
	public String getPntTxnType() {
		return pntTxnType;
	}
	public void setPntTxnType(String pntTxnType) {
		this.pntTxnType = pntTxnType;
	}
	public String getPntTxnDtlType() {
		return pntTxnDtlType;
	}
	public void setPntTxnDtlType(String pntTxnDtlType) {
		this.pntTxnDtlType = pntTxnDtlType;
	}
	public String getPntTxnType_1Cd() {
		return pntTxnType_1Cd;
	}
	public void setPntTxnType_1Cd(String pntTxnType_1Cd) {
		this.pntTxnType_1Cd = pntTxnType_1Cd;
	}
	public String getPntTxnType_2Cd() {
		return pntTxnType_2Cd;
	}
	public void setPntTxnType_2Cd(String pntTxnType_2Cd) {
		this.pntTxnType_2Cd = pntTxnType_2Cd;
	}
	public String getRidMktCamMst() {
		return ridMktCamMst;
	}
	public void setRidMktCamMst(String ridMktCamMst) {
		this.ridMktCamMst = ridMktCamMst;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
}
