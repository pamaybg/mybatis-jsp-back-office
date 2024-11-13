package com.icignal.auth.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class GetUserPwdInfoResDto extends StatusResDto {
	
	private String userPwBef1;
	private String userPwBef2;
	private String userPw;
	private String userId;
	private String empNo;
	
	
	public String getUserPwBef1() {
		return userPwBef1;
	}
	public void setUserPwBef1(String userPwBef1) {
		this.userPwBef1 = userPwBef1;
	}
	public String getUserPwBef2() {
		return userPwBef2;
	}
	public void setUserPwBef2(String userPwBef2) {
		this.userPwBef2 = userPwBef2;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	
}
