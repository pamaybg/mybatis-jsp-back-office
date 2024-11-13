package com.icignal.common.base.dto.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 최상위 반환 클래스
 * 성공 여부 및 에러 타입 반환
 * 
 * @author jskim
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class StatusResDto  {

	private boolean success;
	private int errorType;
	private String message;

	public StatusResDto() {
	}

	public StatusResDto(boolean success, String message) {
		this.success = success;
		this.message = message;
	}

	public StatusResDto(boolean success, int errorType, String message) {
		this.success = success;
		this.errorType = errorType;
		this.message = message;
	}

	public boolean getSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "StatusResponse [success=" + success + ", message=" + message
				+ ", errorType="+ errorType +"]";
	}

	public int getErrorType() {
		return errorType;
	}

	public void setErrorType(int errorType) {
		this.errorType = errorType;
	}
}
