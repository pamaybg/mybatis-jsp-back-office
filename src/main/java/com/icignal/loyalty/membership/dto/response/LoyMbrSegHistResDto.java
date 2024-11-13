package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyMbrSegHistResDto extends GridPagingItemResDto {
	private String aplyDd;
	private String camGroupCode;
	private String camGroup;
	private String custValueCode;
	private String custValue;
	private String grothTypeCode;
	private String grothType;
	private String lifeCyclCode;
	private String lifeCycl;

	public String getAplyDd() {
		return aplyDd;
	}
	public void setAplyDd(String aplyDd) {
		this.aplyDd = aplyDd;
	}
	public String getCamGroupCode() {
		return camGroupCode;
	}
	public void setCamGroupCode(String camGroupCode) {
		this.camGroupCode = camGroupCode;
	}
	public String getCamGroup() {
		return camGroup;
	}
	public void setCamGroup(String camGroup) {
		this.camGroup = camGroup;
	}
	public String getCustValueCode() {
		return custValueCode;
	}
	public void setCustValueCode(String custValueCode) {
		this.custValueCode = custValueCode;
	}
	public String getCustValue() {
		return custValue;
	}
	public void setCustValue(String custValue) {
		this.custValue = custValue;
	}
	public String getGrothTypeCode() {
		return grothTypeCode;
	}
	public void setGrothTypeCode(String grothTypeCode) {
		this.grothTypeCode = grothTypeCode;
	}
	public String getGrothType() {
		return grothType;
	}
	public void setGrothType(String grothType) {
		this.grothType = grothType;
	}
	public String getLifeCyclCode() {
		return lifeCyclCode;
	}
	public void setLifeCyclCode(String lifeCyclCode) {
		this.lifeCyclCode = lifeCyclCode;
	}
	public String getLifeCycl() {
		return lifeCycl;
	}
	public void setLifeCycl(String lifeCycl) {
		this.lifeCycl = lifeCycl;
	}

}
