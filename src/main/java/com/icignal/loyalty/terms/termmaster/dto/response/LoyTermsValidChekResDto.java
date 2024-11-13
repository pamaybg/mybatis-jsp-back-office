package com.icignal.loyalty.terms.termmaster.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyTermsValidChekResDto extends StatusResDto{

	private String rid;
	private int cnt;
	private String statCd;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getStatCd() {
		return statCd;
	}

	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	
}
