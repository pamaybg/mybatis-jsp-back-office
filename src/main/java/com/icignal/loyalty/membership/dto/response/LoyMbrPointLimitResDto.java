package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyMbrPointLimitResDto extends StatusResDto {

	private String mbrNo;
	private String memberName;
	private String memDiv;
	private String memberIncYn;
	private String memberPresentLimitAmt;
	private String memberAvgLimitFor3month;
	private String memberPossibleLimitAmt;
	
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemDiv() {
		return memDiv;
	}
	public void setMemDiv(String memDiv) {
		this.memDiv = memDiv;
	}
	public String getMemberIncYn() {
		return memberIncYn;
	}
	public void setMemberIncYn(String memberIncYn) {
		this.memberIncYn = memberIncYn;
	}
	public String getMemberPresentLimitAmt() {
		return memberPresentLimitAmt;
	}
	public void setMemberPresentLimitAmt(String memberPresentLimitAmt) {
		this.memberPresentLimitAmt = memberPresentLimitAmt;
	}
	public String getMemberAvgLimitFor3month() {
		return memberAvgLimitFor3month;
	}
	public void setMemberAvgLimitFor3month(String memberAvgLimitFor3month) {
		this.memberAvgLimitFor3month = memberAvgLimitFor3month;
	}
	public String getMemberPossibleLimitAmt() {
		return memberPossibleLimitAmt;
	}
	public void setMemberPossibleLimitAmt(String memberPossibleLimitAmt) {
		this.memberPossibleLimitAmt = memberPossibleLimitAmt;
	}

}
