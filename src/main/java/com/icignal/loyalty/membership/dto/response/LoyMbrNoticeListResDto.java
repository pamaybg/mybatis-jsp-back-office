package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyMbrNoticeListResDto extends GridPagingItemResDto{

	private String rid;
	private String nType;
	private String msg;
	private String showYn;
	private String actionDt;
	private String confirmDt;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getnType() {
		return nType;
	}
	public void setnType(String nType) {
		this.nType = nType;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getShowYn() {
		return showYn;
	}
	public void setShowYn(String showYn) {
		this.showYn = showYn;
	}
	public String getActionDt() {
		return actionDt;
	}
	public void setActionDt(String actionDt) {
		this.actionDt = actionDt;
	}
	public String getConfirmDt() {
		return confirmDt;
	}
	public void setConfirmDt(String confirmDt) {
		this.confirmDt = confirmDt;
	}
	
}
