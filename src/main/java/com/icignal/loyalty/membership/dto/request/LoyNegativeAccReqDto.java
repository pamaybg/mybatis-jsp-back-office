package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyNegativeAccReqDto extends CommonDataAuthReqDto {
	private String rid;
	private String strDt;
	private String endDt;
	private Integer dayCnt;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getStrDt() {
		return strDt;
	}
	public void setStrDt(String strDt) {
		this.strDt = strDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public Integer getDayCnt() {
		return dayCnt;
	}
	public void setDayCnt(Integer dayCnt) {
		this.dayCnt = dayCnt;
	}
}
