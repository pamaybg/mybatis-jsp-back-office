package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyCallAddNewCustResDto extends StatusResDto{
	
	private String Rst;
	private String RstCd;
	private String RstMsg;
	private String custNo;
	private String mbrNo;
	private String mbrCardNo;
	
	public String getRst() {
		return Rst;
	}
	public void setRst(String rst) {
		Rst = rst;
	}
	public String getRstCd() {
		return RstCd;
	}
	public void setRstCd(String rstCd) {
		RstCd = rstCd;
	}
	public String getRstMsg() {
		return RstMsg;
	}
	public void setRstMsg(String rstMsg) {
		RstMsg = rstMsg;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getMbrCardNo() {
		return mbrCardNo;
	}
	public void setMbrCardNo(String mbrCardNo) {
		this.mbrCardNo = mbrCardNo;
	}
	
}
