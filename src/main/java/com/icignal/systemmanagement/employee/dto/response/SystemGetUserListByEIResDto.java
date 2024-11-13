package com.icignal.systemmanagement.employee.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemGetUserListByEIResDto extends GridPagingItemResDto {
	
	private String rid;
	private String userId;
	private String pwExpireDate;
	private String pgmNm;
	private String userPwCnt;
	private String acesStartDate;
	private String acesEndDate;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPwExpireDate() {
		return pwExpireDate;
	}
	public void setPwExpireDate(String pwExpireDate) {
		this.pwExpireDate = pwExpireDate;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getUserPwCnt() {
		return userPwCnt;
	}
	public void setUserPwCnt(String userPwCnt) {
		this.userPwCnt = userPwCnt;
	}
	public String getAcesStartDate() {
		return acesStartDate;
	}
	public void setAcesStartDate(String acesStartDate) {
		this.acesStartDate = acesStartDate;
	}
	public String getAcesEndDate() {
		return acesEndDate;
	}
	public void setAcesEndDate(String acesEndDate) {
		this.acesEndDate = acesEndDate;
	}
	
}
