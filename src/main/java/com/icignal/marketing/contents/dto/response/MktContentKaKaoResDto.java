package com.icignal.marketing.contents.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MktContentKaKaoResDto extends GridPagingItemResDto  {
	private String ridContsMst;
	private String seq;
	private String type;
	private String btnName;
	private String pcUrl;
	private String mobileUrl;
	private String counts;
	private String createBy;
	private String modifyBy;
	private String toCallbackNo;
	
	
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getCounts() {
		return counts;
	}
	public void setCounts(String counts) {
		this.counts = counts;
	}
	public String getRidContsMst() {
		return ridContsMst;
	}
	public void setRidContsMst(String ridContsMst) {
		this.ridContsMst = ridContsMst;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getBtnName() {
		return btnName;
	}
	public void setBtnName(String btnName) {
		this.btnName = btnName;
	}
	public String getPcUrl() {
		return pcUrl;
	}
	public void setPcUrl(String pcUrl) {
		this.pcUrl = pcUrl;
	}
	public String getMobileUrl() {
		return mobileUrl;
	}
	public void setMobileUrl(String mobileUrl) {
		this.mobileUrl = mobileUrl;
	}

	public String getToCallbackNo() {
		return toCallbackNo;
	}

	public void setToCallbackNo(String toCallbackNo) {
		this.toCallbackNo = toCallbackNo;
	}
}
