package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyMbrChnlHistContentsReqDto extends CommonDataAuthReqDto {
	private String rid;
	private String chnlTypeCd;

	

	public String getChnlTypeCd() {
		return chnlTypeCd;
	}

	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}
	










}
