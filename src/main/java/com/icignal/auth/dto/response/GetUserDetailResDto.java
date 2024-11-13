package com.icignal.auth.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class GetUserDetailResDto extends GridPagingItemResDto {
	
	private String empNo;
	private String ridLoyPgm;
	private String loyPgm;
	private String userId;
	private String userPw;
	private String pwExpirDate;
	private String userStat;
	
	
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getLoyPgm() {
		return loyPgm;
	}
	public void setLoyPgm(String loyPgm) {
		this.loyPgm = loyPgm;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getPwExpirDate() {
		return pwExpirDate;
	}
	public void setPwExpirDate(String pwExpirDate) {
		this.pwExpirDate = pwExpirDate;
	}
	public String getUserStat() {
		return userStat;
	}
	public void setUserStat(String userStat) {
		this.userStat = userStat;
	}
	public String getRidLoyPgm() {
		return ridLoyPgm;
	}
	public void setRidLoyPgm(String ridLoyPgm) {
		this.ridLoyPgm = ridLoyPgm;
	}
}
