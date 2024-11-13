package com.icignal.systemmanagement.batchrgst.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
* @name : infavor.loyalty.batchRgst.dto.response.LOYRcptAftrRgstItemResponseDTO
* @date : 2018. 11. 26.
* @author : hy.jun
* @description :
*/
@SuppressWarnings("serial")
public class SystemRcptAftrRgstItemResDto extends GridPagingItemResDto {
	private String rid;
	private String mbrNo;
	private String custNm;
	private String mbrStatCd;
	private String mbrStatCdNm;
	private String txnDt;
	private String chnlNo;
	private String chnlNm;
	private String txnAmt;
	private String posNo;
	private String pntAmt;
	private String apprDt;
	private String apprNo;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getMbrStatCdNm() {
		return mbrStatCdNm;
	}
	public void setMbrStatCdNm(String mbrStatCdNm) {
		this.mbrStatCdNm = mbrStatCdNm;
	}
	public String getTxnDt() {
		return txnDt;
	}
	public void setTxnDt(String txnDt) {
		this.txnDt = txnDt;
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
	public String getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
	}
	public String getPosNo() {
		return posNo;
	}
	public void setPosNo(String posNo) {
		this.posNo = posNo;
	}
	public String getPntAmt() {
		return pntAmt;
	}
	public void setPntAmt(String pntAmt) {
		this.pntAmt = pntAmt;
	}
	public String getApprDt() {
		return apprDt;
	}
	public void setApprDt(String apprDt) {
		this.apprDt = apprDt;
	}
	public String getApprNo() {
		return apprNo;
	}
	public void setApprNo(String apprNo) {
		this.apprNo = apprNo;
	}
}
