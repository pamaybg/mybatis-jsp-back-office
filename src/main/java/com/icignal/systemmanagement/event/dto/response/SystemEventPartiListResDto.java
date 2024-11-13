package com.icignal.systemmanagement.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemEventPartiListResDto extends GridPagingItemResDto {
	
	private String rid;
	private String partiDate;
	private String partiId;
	private String partiName;
	private String partiHistory;
	private String memberGrade;
	private String prizewinnerHistory;
	private String prizewinnerFlag;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPartiDate() {
		return partiDate;
	}
	public void setPartiDate(String partiDate) {
		this.partiDate = partiDate;
	}
	public String getPartiId() {
		return partiId;
	}
	public void setPartiId(String partiId) {
		this.partiId = partiId;
	}
	public String getPartiName() {
		return partiName;
	}
	public void setPartiName(String partiName) {
		this.partiName = partiName;
	}
	public String getPartiHistory() {
		return partiHistory;
	}
	public void setPartiHistory(String partiHistory) {
		this.partiHistory = partiHistory;
	}
	public String getMemberGrade() {
		return memberGrade;
	}
	public void setMemberGrade(String memberGrade) {
		this.memberGrade = memberGrade;
	}
	public String getPrizewinnerHistory() {
		return prizewinnerHistory;
	}
	public void setPrizewinnerHistory(String prizewinnerHistory) {
		this.prizewinnerHistory = prizewinnerHistory;
	}
	public String getPrizewinnerFlag() {
		return prizewinnerFlag;
	}
	public void setPrizewinnerFlag(String prizewinnerFlag) {
		this.prizewinnerFlag = prizewinnerFlag;
	}

}
