package com.icignal.offer.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class CouponGuideListReqDto extends CommonDataAuthReqDto {

	private String rid;
	private String ridOfr;
	private String ridCpn;
	private String msgText;
	private String lineNo;
	private List<CouponGuideListReqDto> cpnGuideList;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getRidCpn() {
		return ridCpn;
	}
	public void setRidCpn(String ridCpn) {
		this.ridCpn = ridCpn;
	}

	public String getMsgText() {
		return msgText;
	}
	public void setMsgText(String msgText) {
		this.msgText = msgText;
	}
	
	public String getLineNo() {
		return lineNo;
	}
	public void setLineNo(String lineNo) {
		this.lineNo = lineNo;
	}
	public List<CouponGuideListReqDto> getCpnGuideList() {
		return cpnGuideList;
	}
	public void setCpnGuideList(List<CouponGuideListReqDto> cpnGuideList) {
		this.cpnGuideList = cpnGuideList;
	}
	


	
	
}
