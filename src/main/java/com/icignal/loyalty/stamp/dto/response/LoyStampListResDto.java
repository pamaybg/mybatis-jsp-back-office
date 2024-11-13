package com.icignal.loyalty.stamp.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * 
* <pre>
* infavor.loyalty.simulation.dto.response
*  |_ LOYChnlComboResponseDTO.java
* </pre>
* @작성일		: 2017. 1. 11. 
* @작성자		: wjlee 
* @프로그램설명	:
 */
@CommCode
public class LoyStampListResDto extends GridPagingItemResDto{

	private String txnNo;
	private String apprDt;
	@MarkName(groupCode="STAMP_TXN_SUB_TYPE_CD", codeField="txn2Cd")
	private String txnType2Cd;
	private String mbrNo;
	private String custNm;
	@MarkName(groupCode="MEMBER_TYPE", codeField="memDivCd")
	private String memDiv;
	private String memDivCd;
	@MarkName(groupCode="MEMBER_GRADE", codeField="memGradeCd")
	private String memGrade;
	private String acrlStamp;
	private String useStamp;
	private String giftStamp;
	private String avlStamp;
	private String giftMbrNo;
	private String giftCustNm;
	private String chnlNo;
	private String chnlNm;
	private String prodId;
	private String prodNm;
	private String unitCost;
	private String rid;
	private String mbrRid;
	private String chnlRid;
	private String ridProd;
	private String memGradeCd;
	private String txn2Cd;
	
	
	
	
	public String getMemGradeCd() {
		return memGradeCd;
	}
	public void setMemGradeCd(String memGradeCd) {
		this.memGradeCd = memGradeCd;
	}
	public String getTxn2Cd() {
		return txn2Cd;
	}
	public void setTxn2Cd(String txn2Cd) {
		this.txn2Cd = txn2Cd;
	}
	public String getTxnNo() {
		return txnNo;
	}
	public void setTxnNo(String txnNo) {
		this.txnNo = txnNo;
	}
	public String getApprDt() {
		return apprDt;
	}
	public void setApprDt(String apprDt) {
		this.apprDt = apprDt;
	}
	public String getTxnType2Cd() {
		return txnType2Cd;
	}
	public void setTxnType2Cd(String txnType2Cd) {
		this.txnType2Cd = txnType2Cd;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getAcrlStamp() {
		return acrlStamp;
	}
	public void setAcrlStamp(String acrlStamp) {
		this.acrlStamp = acrlStamp;
	}
	public String getUseStamp() {
		return useStamp;
	}
	public void setUseStamp(String useStamp) {
		this.useStamp = useStamp;
	}
	public String getGiftStamp() {
		return giftStamp;
	}
	public void setGiftStamp(String giftStamp) {
		this.giftStamp = giftStamp;
	}
	public String getAvlStamp() {
		return avlStamp;
	}
	public void setAvlStamp(String avlStamp) {
		this.avlStamp = avlStamp;
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
	
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getUnitCost() {
		return unitCost;
	}
	public void setUnitCost(String unitCost) {
		this.unitCost = unitCost;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMemDiv() {
		return memDiv;
	}
	public void setMemDiv(String memDiv) {
		this.memDiv = memDiv;
	}
	public String getMemGrade() {
		return memGrade;
	}
	public void setMemGrade(String memGrade) {
		this.memGrade = memGrade;
	}
	public String getGiftMbrNo() {
		return giftMbrNo;
	}
	public void setGiftMbrNo(String giftMbrNo) {
		this.giftMbrNo = giftMbrNo;
	}
	public String getGiftCustNm() {
		return giftCustNm;
	}
	public void setGiftCustNm(String giftCustNm) {
		this.giftCustNm = giftCustNm;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}
	public String getChnlRid() {
		return chnlRid;
	}
	public void setChnlRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}
	public String getRidProd() {
		return ridProd;
	}
	public void setRidProd(String ridProd) {
		this.ridProd = ridProd;
	}
	public String getMemDivCd() {
		return memDivCd;
	}
	public void setMemDivCd(String memDivCd) {
		this.memDivCd = memDivCd;
	}
	
	
	

}
