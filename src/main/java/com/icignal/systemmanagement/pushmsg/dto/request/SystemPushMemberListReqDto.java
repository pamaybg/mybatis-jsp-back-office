package com.icignal.systemmanagement.pushmsg.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class SystemPushMemberListReqDto extends CommonDataAuthReqDto {
	private String ciperKey;

	public String getCiperKey() {
		return ciperKey;
	}
	public void setCiperKey(String ciperKey) {
		this.ciperKey = ciperKey;
	}
}
