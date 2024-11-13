package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyMbrClupListResDto extends GridPagingItemResDto {
	private String chnlNm;
	private String regDt;
	private String delDt;
	private String activeFlg;
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getDelDt() {
		return delDt;
	}
	public void setDelDt(String delDt) {
		this.delDt = delDt;
	}
	public String getActiveFlg() {
		return activeFlg;
	}
	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}
	
	
	

}
