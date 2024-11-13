package com.icignal.systemmanagement.pushmsg.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class SystemTestPushResultListReqDto extends CommonDataAuthReqDto {
	private String ciperKey;
	private String pushMsgId;

	public String getCiperKey() {
		return ciperKey;
	}
	public void setCiperKey(String ciperKey) {
		this.ciperKey = ciperKey;
	}
	public String getPushMsgId() {
		return pushMsgId;
	}
	public void setPushMsgId(String pushMsgId) {
		this.pushMsgId = pushMsgId;
	}
}
