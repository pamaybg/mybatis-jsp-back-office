package com.icignal.loyalty.qna.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyQnaListResDto extends GridPagingItemResDto {
	private String rid;
	private String srNo;
	private String srType;
	private String mbrNo;
	private String custNm;
	private String srReqDt;
	private String srStatus;
	private String srCmpltDt;
	private String managerNm;
	private String receipt;
	private String srReqTxt;
	private String ecommMbrNo;
	private String ridMbr;
	
	public String getEcommMbrNo() {
		return ecommMbrNo;
	}
	public void setEcommMbrNo(String ecommMbrNo) {
		this.ecommMbrNo = ecommMbrNo;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSrNo() {
		return srNo;
	}
	public void setSrNo(String srNo) {
		this.srNo = srNo;
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
	public String getSrReqDt() {
		return srReqDt;
	}
	public void setSrReqDt(String srReqDt) {
		this.srReqDt = srReqDt;
	}
	public String getSrStatus() {
		return srStatus;
	}
	public void setSrStatus(String srStatus) {
		this.srStatus = srStatus;
	}
	public String getSrCmpltDt() {
		return srCmpltDt;
	}
	public void setSrCmpltDt(String srCmpltDt) {
		this.srCmpltDt = srCmpltDt;
	}
	public String getManagerNm() {
		return managerNm;
	}
	public void setManagerNm(String managerNm) {
		this.managerNm = managerNm;
	}
	public String getReceipt() {
		return receipt;
	}
	public void setReceipt(String receipt) {
		this.receipt = receipt;
	}
	public String getSrType() {
		return srType;
	}
	public void setSrType(String srType) {
		this.srType = srType;
	}
	public String getSrReqTxt() {
		return srReqTxt;
	}
	public void setSrReqTxt(String srReqTxt) {
		this.srReqTxt = srReqTxt;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	
	
}
