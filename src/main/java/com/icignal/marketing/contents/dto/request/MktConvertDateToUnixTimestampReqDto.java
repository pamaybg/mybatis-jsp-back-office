package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktConvertDateToUnixTimestampReqDto extends MKTBaseReqDto{
	
	private String parameter;

	
	public String getParameter() {
		return parameter;
	}
	public void setParameter(String parameter) {
		this.parameter = parameter;
	}
}
