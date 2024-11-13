package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyMbrGroupClubReqDto extends CommonDataAuthReqDto {

	private String rid;
	private String ridMbr;
	private String ridChnl;
	private String delDt;
	private String regDt;
	private String activeFlg;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getDelDt() {
		return delDt;
	}
	public void setDelDt(String delDt) {
		this.delDt = delDt;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getActiveFlg() {
		return activeFlg;
	}
	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}


}
