package com.icignal.qpid.rest;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 디바이스 정보 클래스
 * 
 * @author jskim
 * 
 */
public class Notification {
	private String applicationId;
	private String reqApplicationToken;
	private String reqApplicationId;

	private Payload payload;

	private ArrayList<Device> devices;
	@JsonProperty("application_id")
	public String getApplicationId() {
		return applicationId;
	}

	public void setApplicationId(String applicationId) {
		this.applicationId = applicationId;
	}

	@JsonProperty("request_application_token")
	public String getReqApplicationToken() {
		return reqApplicationToken;
	}

	public void setReqApplicationToken(String reqApplicationToken) {
		this.reqApplicationToken = reqApplicationToken;
	}

	@JsonProperty("request_application_id")
	public String getReqApplicationId() {
		return reqApplicationId;
	}

	public void setReqApplicationId(String reqApplicationId) {
		this.reqApplicationId = reqApplicationId;
	}


	@JsonProperty("device")
	public ArrayList<Device> getDevices() {
		if (this.devices == null)
			this.devices = new ArrayList<Device>();
		return devices;
	}

	public void setDevices(ArrayList<Device> devices) {
		this.devices = devices;
	}

	public Payload getPayload() {
		return payload;
	}

	public void setPayload(Payload payload) {
		this.payload = payload;
	}

}

