package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyMbrSemiVipHistListResDto extends GridPagingItemResDto{


	private String createDate;
	private String startDt;
	private String endDt;
	private String expireDt;
	private String rid;
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getExpireDt() {
		return expireDt;
	}
	public void setExpireDt(String expireDt) {
		this.expireDt = expireDt;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}



}
