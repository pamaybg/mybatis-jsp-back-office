package com.icignal.systemmanagement.apispec.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemApiSpecListResDto extends GridPagingItemResDto{
	
	private String rid;
	@MarkName(groupCode = "LOY_API_GROUP_CD", codeField = "apiGrpCd")
	private String apiGrpCdNm;
	private String apiGrpCd;
	private String apiNo;
	private String apiNm;
	@MarkName(groupCode = "LOY_API_PROTOCOL", codeField = "protocolNm")
	private String protocolNm;
	private String protocol;
	private String host;
	private String port;
	@MarkName(groupCode = "LOY_API_HTTP_METHOD_CD", codeField = "httpMethodCd")
	private String httpMethodCdNm;
	private String httpMethodCd;
	@MarkName(groupCode = "LOY_API_CONTENT_TYPE_CD", codeField = "httpContentTypeCd")
	private String httpContentTypeCdNm;
	private String httpContentTypeCd;
	private String reqUrl;
	private String apiDesc;
	@MarkName(groupCode = "COM_STAT_TYPE_2_CD", codeField = "statCd")
	private String statCdNm;
	private String statCd;
	private String createDate;
	private String createBy;
	@MarkName(groupCode = "LOY_API_LOC_CD", codeField = "apiLoc")
	private String apiLocNm;
	private String apiLoc;
	private String systemRid;
	private String spNm;
	private String modifyDate;
	private String modifyBy;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getApiGrpCd() {
		return apiGrpCd;
	}
	public void setApiGrpCd(String apiGrpCd) {
		this.apiGrpCd = apiGrpCd;
	}
	public String getApiNo() {
		return apiNo;
	}
	public void setApiNo(String apiNo) {
		this.apiNo = apiNo;
	}
	public String getApiNm() {
		return apiNm;
	}
	public void setApiNm(String apiNm) {
		this.apiNm = apiNm;
	}
	public String getProtocol() {
		return protocol;
	}
	public void setProtocol(String protocol) {
		this.protocol = protocol;
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
	public String getHttpMethodCd() {
		return httpMethodCd;
	}
	public void setHttpMethodCd(String httpMethodCd) {
		this.httpMethodCd = httpMethodCd;
	}
	public String getHttpContentTypeCd() {
		return httpContentTypeCd;
	}
	public void setHttpContentTypeCd(String httpContentTypeCd) {
		this.httpContentTypeCd = httpContentTypeCd;
	}
	public String getReqUrl() {
		return reqUrl;
	}
	public void setReqUrl(String reqUrl) {
		this.reqUrl = reqUrl;
	}
	public String getApiDesc() {
		return apiDesc;
	}
	public void setApiDesc(String apiDesc) {
		this.apiDesc = apiDesc;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getApiGrpCdNm() {
		return apiGrpCdNm;
	}
	public void setApiGrpCdNm(String apiGrpCdNm) {
		this.apiGrpCdNm = apiGrpCdNm;
	}
	public String getProtocolNm() {
		return protocolNm;
	}
	public void setProtocolNm(String protocolNm) {
		this.protocolNm = protocolNm;
	}
	public String getHttpMethodCdNm() {
		return httpMethodCdNm;
	}
	public void setHttpMethodCdNm(String httpMethodCdNm) {
		this.httpMethodCdNm = httpMethodCdNm;
	}
	public String getHttpContentTypeCdNm() {
		return httpContentTypeCdNm;
	}
	public void setHttpContentTypeCdNm(String httpContentTypeCdNm) {
		this.httpContentTypeCdNm = httpContentTypeCdNm;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}
	public String getApiLoc() {
		return apiLoc;
	}
	public void setApiLoc(String apiLoc) {
		this.apiLoc = apiLoc;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getApiLocNm() {
		return apiLocNm;
	}
	public void setApiLocNm(String apiLocNm) {
		this.apiLocNm = apiLocNm;
	}
	public String getSystemRid() {
		return systemRid;
	}
	public void setSystemRid(String systemRid) {
		this.systemRid = systemRid;
	}
	public String getSpNm() {
		return spNm;
	}
	public void setSpNm(String spNm) {
		this.spNm = spNm;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
}
