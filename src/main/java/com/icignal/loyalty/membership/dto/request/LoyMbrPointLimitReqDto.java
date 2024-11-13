package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyMbrPointLimitReqDto extends CommonDataAuthReqDto {
	private String ridMbr;
	private String mbrNo;
	private String bchngData;
	private String achngData;

	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getBchngData() {
		return bchngData;
	}
	public void setBchngData(String bchngData) {
		this.bchngData = bchngData;
	}
	public String getAchngData() {
		return achngData;
	}
	public void setAchngData(String achngData) {
		this.achngData = achngData;
	}


}
