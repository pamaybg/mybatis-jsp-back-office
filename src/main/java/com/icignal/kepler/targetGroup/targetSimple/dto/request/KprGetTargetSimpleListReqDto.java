package com.icignal.kepler.targetGroup.targetSimple.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class KprGetTargetSimpleListReqDto extends MKTBaseReqDto{
	private String targetGroupId;

	public String getTargetGroupId() {
		return targetGroupId;
	}

	public void setTargetGroupId(String targetGroupId) {
		this.targetGroupId = targetGroupId;
	}
	
}
