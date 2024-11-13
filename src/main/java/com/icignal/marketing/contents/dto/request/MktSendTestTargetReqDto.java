package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktSendTestTargetReqDto extends MKTBaseReqDto {

	private String userId;
	private String phone;
	private String memName;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}


}
