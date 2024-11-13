package com.icignal.offer.dto.response;


import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class CouponGuideResDto extends GridPagingItemResDto {
	
	private String rid;
	private String lineNo;
	private String msgText;
	private List<CouponGuideResDto> msgInfo;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
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
	public List<CouponGuideResDto> getMsgInfo() {
		return msgInfo;
	}
	public void setMsgInfo(List<CouponGuideResDto> msgInfo) {
		this.msgInfo = msgInfo;
	}


	
}
