package com.icignal.kepler.targetGroup.targetSimple.dto.response;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class KprGetTargetSimpleListTagetGroupResDto extends MKTBaseReqDto {
	private String targetGroupName;
	private String targetGroupDesc;
	private String cnt;
	public String getTargetGroupName() {
		return targetGroupName;
	}
	public void setTargetGroupName(String targetGroupName) {
		this.targetGroupName = targetGroupName;
	}
	public String getTargetGroupDesc() {
		return targetGroupDesc;
	}
	public void setTargetGroupDesc(String targetGroupDesc) {
		this.targetGroupDesc = targetGroupDesc;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	
	
}
