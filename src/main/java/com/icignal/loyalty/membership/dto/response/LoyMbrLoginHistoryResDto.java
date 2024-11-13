package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyMbrLoginHistoryResDto extends GridPagingItemResDto {
	private String rid;
	private String ridChnl;
	private String accessDt;
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
	public String getAccessDt() {
		return accessDt;
	}
	public void setAccessDt(String accessDt) {
		this.accessDt = accessDt;
	}

	
	
}

