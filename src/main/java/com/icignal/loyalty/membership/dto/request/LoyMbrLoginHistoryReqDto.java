package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyMbrLoginHistoryReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String ridChnl;
	private String accessDt;
	
	public String getAccessDt() {
		return accessDt;
	}
	public void setAccessDt(String accessDt) {
		this.accessDt = accessDt;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	
}
