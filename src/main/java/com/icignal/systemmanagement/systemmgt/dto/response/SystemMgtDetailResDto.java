package com.icignal.systemmanagement.systemmgt.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class SystemMgtDetailResDto extends StatusResDto{

	private String rid;
	private String systemNm;
	private String systemTypeCd;
	private String hostNm;
	private String port;
	private String purposeCd;
	private String statCd;
	private String company;
	private String systemDesc;
	private String createDate;
	private String apiSiteId;
	private String apiSecreetKey;
	
	
	public String getApiSiteId() {
		return apiSiteId;
	}
	public void setApiSiteId(String apiSiteId) {
		this.apiSiteId = apiSiteId;
	}
	public String getApiSecreetKey() {
		return apiSecreetKey;
	}
	public void setApiSecreetKey(String apiSecreetKey) {
		this.apiSecreetKey = apiSecreetKey;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSystemNm() {
		return systemNm;
	}
	public void setSystemNm(String systemNm) {
		this.systemNm = systemNm;
	}
	public String getSystemTypeCd() {
		return systemTypeCd;
	}
	public void setSystemTypeCd(String systemTypeCd) {
		this.systemTypeCd = systemTypeCd;
	}
	public String getHostNm() {
		return hostNm;
	}
	public void setHostNm(String hostNm) {
		this.hostNm = hostNm;
	}
	public String getPort() {
		return port;
	}
	public void setPort(String port) {
		this.port = port;
	}
	public String getPurposeCd() {
		return purposeCd;
	}
	public void setPurposeCd(String purposeCd) {
		this.purposeCd = purposeCd;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getSystemDesc() {
		return systemDesc;
	}
	public void setSystemDesc(String systemDesc) {
		this.systemDesc = systemDesc;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
}
