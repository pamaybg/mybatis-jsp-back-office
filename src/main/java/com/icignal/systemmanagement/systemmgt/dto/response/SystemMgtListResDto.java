package com.icignal.systemmanagement.systemmgt.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemMgtListResDto extends GridPagingItemResDto{

	private String rid;
	private String createBy;
	private String createDate;
	private String systemNm;
	@MarkName(groupCode = "SYSTEM_TYPE_CD", codeField = "systemTypeCd")
	private String systemTypeCdNm;
	private String systemTypeCd;
	private String host;
	private String port;
	@MarkName(groupCode = "SYSTEM_PURPOSE_TYPE_CD", codeField = "purposeCd")
	private String purposeCdNm;
	private String purposeCd;
	@MarkName(groupCode = "COM_STAT_TYPE_2_CD", codeField = "statCd")
	private String statCdNm;
	private String statCd;
	private String company;
	private String systemDesc;
	private String apiSiteId;
	
	
	public String getApiSiteId() {
		return apiSiteId;
	}
	public void setApiSiteId(String apiSiteId) {
		this.apiSiteId = apiSiteId;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
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
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
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
	public String getSystemTypeCdNm() {
		return systemTypeCdNm;
	}
	public void setSystemTypeCdNm(String systemTypeCdNm) {
		this.systemTypeCdNm = systemTypeCdNm;
	}
	public String getPurposeCdNm() {
		return purposeCdNm;
	}
	public void setPurposeCdNm(String purposeCdNm) {
		this.purposeCdNm = purposeCdNm;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}

}
