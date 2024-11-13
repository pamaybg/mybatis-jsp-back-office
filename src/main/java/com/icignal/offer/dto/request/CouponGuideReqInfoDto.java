package com.icignal.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class CouponGuideReqInfoDto extends CommonDataAuthReqDto {


	private String lineNo;
	private String msgText;
	public String getLineNo() {
		return lineNo;
	}
	public void setLineNo(String lineNo) {
		this.lineNo = lineNo;
	}
	public String getMsgText() {
		return msgText;
	}
	public void setMsgText(String msgText) {
		this.msgText = msgText;
	}

	
	
}
