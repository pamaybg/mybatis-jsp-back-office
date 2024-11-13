package com.icignal.loyalty.family.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyFamilyCallbackResDto extends StatusResDto{

	private String Rst;
	private String RstCd;
	private String RstMsg;
	
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
}
