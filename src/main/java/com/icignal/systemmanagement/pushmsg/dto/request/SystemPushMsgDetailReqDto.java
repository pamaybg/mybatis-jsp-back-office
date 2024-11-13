package com.icignal.systemmanagement.pushmsg.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemPushMsgDetailReqDto extends CommonCondReqDto {
	
	private String pushMsgId;

	public String getPushMsgId() {
		return pushMsgId;
	}

	public void setPushMsgId(String pushMsgId) {
		this.pushMsgId = pushMsgId;
	}

}
