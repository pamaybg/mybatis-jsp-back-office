package com.icignal.loyalty.coupon.dto.request;

import java.util.Date;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyCouponDetailReqDto extends CommonDataAuthReqDto {

	private String rid;
	private String rst;
	private String rstMsg;
	private String rstCd;
	private String mbrNo;
	private String ofrNo;
	private Integer cpnAmt;
	private String issueDt;
	private String issueTime;
	private String validStartDay;
	private Date validStDate;
	private Date issueDate;
	private String chnlNo;
	private String rcptNo;
	private String cpnNo;
	private String prodId;
 private String rstCpnNo;
 private String saveNewCoupon;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRst() {
		return rst;
	}

	public void setRst(String rst) {
		this.rst = rst;
	}

	public String getRstMsg() {
		return rstMsg;
	}

	public void setRstMsg(String rstMsg) {
		this.rstMsg = rstMsg;
	}

	public String getRstCd() {
		return rstCd;
	}

	public void setRstCd(String rstCd) {
		this.rstCd = rstCd;
	}

	public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}

	public String getOfrNo() {
		return ofrNo;
	}

	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}

	public Integer getCpnAmt() {
		return cpnAmt;
	}

	public void setCpnAmt(Integer cpnAmt) {
		this.cpnAmt = cpnAmt;
	}





	public String getIssueTime() {
		return issueTime;
	}

	public void setIssueTime(String issueTime) {
		this.issueTime = issueTime;
	}

	public String getRcptNo() {
		return rcptNo;
	}

	public void setRcptNo(String rcptNo) {
		this.rcptNo = rcptNo;
	}

	public String getChnlNo() {
		return chnlNo;
	}

	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}

	public String getCpnNo() {
		return cpnNo;
	}

	public void setCpnNo(String cpnNo) {
		this.cpnNo = cpnNo;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public String getValidStartDay() {
		return validStartDay;
	}

	public void setValidStartDay(String validStartDay) {
		this.validStartDay = validStartDay;
	}

	public String getRstCpnNo() {
		return rstCpnNo;
	}

	public void setRstCpnNo(String rstCpnNo) {
		this.rstCpnNo = rstCpnNo;
	}

	public String getIssueDt() {
		return issueDt;
	}

	public void setIssueDt(String issueDt) {
		this.issueDt = issueDt;
	}

	public Date getValidStDate() {
		return validStDate;
	}

	public void setValidStDate(Date validStDate) {
		this.validStDate = validStDate;
	}

	public Date getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}

	public String getSaveNewCoupon() {
		return saveNewCoupon;
	}

	public void setSaveNewCoupon(String saveNewCoupon) {
		this.saveNewCoupon = saveNewCoupon;
	}




}
