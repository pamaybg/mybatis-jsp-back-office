package com.icignal.systemmanagement.apispec.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class SystemApiSpecListReqDto extends CommonDataAuthReqDto{

	private String chnlRid;
	private String apiSpecRid;
	private String copyRid;
	
	private String rid;
	private String apiGrpCd;
	private String apiNo;
	private String apiNm;
	private String protocol;
	private String host;
	private String port;
	private String httpMethodCd;
	private String httpContentTypeCd;
	private String reqUrl;
	private String apiDesc;
	private String statCd;
	private String createDate;
	private String systemRid;
	private String spNm;
	private String apiRid;
	private String paramTypeCd;
	private String paramSubTypeCd;
	
	
	
	public String getParamSubTypeCd() {
		return paramSubTypeCd;
	}
	public void setParamSubTypeCd(String paramSubTypeCd) {
		this.paramSubTypeCd = paramSubTypeCd;
	}
	public String getParamTypeCd() {
		return paramTypeCd;
	}
	public void setParamTypeCd(String paramTypeCd) {
		this.paramTypeCd = paramTypeCd;
	}
	public String getApiRid() {
		return apiRid;
	}
	public void setApiRid(String apiRid) {
		this.apiRid = apiRid;
	}
	public String getCopyRid() {
		return copyRid;
	}
	public void setCopyRid(String copyRid) {
		this.copyRid = copyRid;
	}
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
	
	public String getChnlRid() {
		return chnlRid;
	}

	public void setChnlRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}

	public String getApiSpecRid() {
		return apiSpecRid;
	}

	public void setApiSpecRid(String apiSpecRid) {
		this.apiSpecRid = apiSpecRid;
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

}
