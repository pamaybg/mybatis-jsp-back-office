package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyAgreTermsResDto extends GridPagingItemResDto {

	private String agreTypeCd;
	private String agreYn;
	private String ver;
	private String rid;
	
	public String getAgreTypeCd() {
		return agreTypeCd;
	}
	public void setAgreTypeCd(String agreTypeCd) {
		this.agreTypeCd = agreTypeCd;
	}
	public String getAgreYn() {
		return agreYn;
	}
	public void setAgreYn(String agreYn) {
		this.agreYn = agreYn;
	}
	public String getVer() {
		return ver;
	}
	public void setVer(String ver) {
		this.ver = ver;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	
}
