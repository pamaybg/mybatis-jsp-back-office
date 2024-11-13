package com.icignal.loyalty.game.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;

@CommCode
public class LoyGameTicketResDto extends GridPagingItemResDto {

	private String rid;
	private String createDate;
	private String createBy;
	private String mbrNo;
	private String earnDt;
	private String ofrQty;
	private String useDt;
	private String cancelEarnDt;
	private String cancelEarnRsn;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}

	public String getEarnDt() {
		return earnDt;
	}

	public void setEarnDt(String earnDt) {
		this.earnDt = earnDt;
	}

	public String getOfrQty() {
		return ofrQty;
	}

	public void setOfrQty(String ofrQty) {
		this.ofrQty = ofrQty;
	}

	public String getUseDt() {
		return useDt;
	}

	public void setUseDt(String useDt) {
		this.useDt = useDt;
	}

	public String getCancelEarnDt() {
		return cancelEarnDt;
	}

	public void setCancelEarnDt(String cancelEarnDt) {
		this.cancelEarnDt = cancelEarnDt;
	}

	public String getCancelEarnRsn() {
		return cancelEarnRsn;
	}

	public void setCancelEarnRsn(String cancelEarnRsn) {
		this.cancelEarnRsn = cancelEarnRsn;
	}
}
