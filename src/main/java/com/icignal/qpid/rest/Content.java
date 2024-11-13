package com.icignal.qpid.rest;

import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.icignal.qpid.rest.RestManager.Push_TYPE;

/**
 * 디바이스 정보 클래스
 *
 * @author jskim
 *
 */
public class Content {
	private Push_TYPE type;
	private String title;
	private String desc;
	private String logoUrl;
	private String contents;
	private Map<String, Object> param;
	
	private List<String> cuidArr;
	

	@JsonProperty("type")
	public Push_TYPE getType() {
		return type;
	}

	public void setType(Push_TYPE type) {
		this.type = type;
	}

	@JsonProperty("title")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@JsonProperty("desc")
	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	@JsonProperty("logo_url")
	public String getLogoUrl() {
		return logoUrl;
	}

	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
	}

	@JsonProperty("contents")
	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	@JsonProperty("param")
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}


	public List<String> getCuidArr() {
		return cuidArr;
	}

	public void setCuidArr(List<String> cuidArr) {
		this.cuidArr = cuidArr;
	}

}

