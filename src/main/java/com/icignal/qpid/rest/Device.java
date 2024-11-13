package com.icignal.qpid.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.icignal.qpid.rest.RestManager.OS_TYPE;

/**
 * 디바이스 정보 클래스
 * 
 * @author jskim
 * 
 */
public class Device {

	private String deviceToken;
	private String outsideId;
	private OS_TYPE os;

	private Content content;

	@JsonProperty("device_token")
	public String getDeviceToken() {
		return deviceToken;
	}

	public void setDeviceToken(String deviceToken) {
		this.deviceToken = deviceToken;
	}

	@JsonProperty("outside_id")
	public String getOutsideId() {
		return outsideId;
	}

	public void setOutsideId(String outsideId) {
		this.outsideId = outsideId;
	}

	@JsonProperty("os")
	public OS_TYPE getOs() {
		return os;
	}

	public void setOs(OS_TYPE os) {
		this.os = os;
	}

	@JsonProperty("content")
	public Content getContent() {
		return content;
	}

	public void setContent(Content content) {
		this.content = content;
	}
}

