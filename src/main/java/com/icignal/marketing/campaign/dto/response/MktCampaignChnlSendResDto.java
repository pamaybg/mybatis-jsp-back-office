package com.icignal.marketing.campaign.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MktCampaignChnlSendResDto extends GridPagingItemResDto {
	
	private String sendDate;
	private String memId;
	private String empId;
	
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	
}


