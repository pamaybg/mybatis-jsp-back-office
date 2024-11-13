package com.icignal.systemmanagement.employee.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : MKTUserDetailRequestDTO.java
 * @date : 2017. 11. 24.
 * @author : jun.lee
 * @description : 로그인 사용자 정보 
 */
public class SystemUserDetailReqDto extends MKTBaseReqDto {
	
	//로그인 사용자 비밀번호 변경
	private String empId;
	private String userId;
	private String userPwBef1;
	private String userPwBef2;
	private String userPw;
	private String preUserPw;
	private String ridCrmuser;
	private String pwdChangeTerm;
	
	//로그인 사용자 정보 신규/수정/삭제
	private String idEmployee;
	private String ridLoyPgm;
	private String pwExpirDate;
	private String userStat;
	private String rid;
	private String empNo;
	
	//LoginHist
	private String server;
	
	private String firstLoginFlg;
	private Boolean byAdmin = false; //관리자에 의한 비밀번호 변경 여부 (true 일 경우 변경 후 무조건 첫로그인 시 비밀번호 변경하도록 설정된다.)
	private String pwdCheckCnt;
	
	private String acesStartDate;
	private String acesEndDate;
	
	
	public String getPwdCheckCnt() {
		return pwdCheckCnt;
	}
	public void setPwdCheckCnt(String pwdCheckCnt) {
		this.pwdCheckCnt = pwdCheckCnt;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
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
	public String getPreUserPw() {
		return preUserPw;
	}
	public void setPreUserPw(String preUserPw) {
		this.preUserPw = preUserPw;
	}
	public String getRidCrmuser() {
		return ridCrmuser;
	}
	public void setRidCrmuser(String ridCrmuser) {
		this.ridCrmuser = ridCrmuser;
	}
	public String getIdEmployee() {
		return idEmployee;
	}
	public void setIdEmployee(String idEmployee) {
		this.idEmployee = idEmployee;
	}
	public String getRidLoyPgm() {
		return ridLoyPgm;
	}
	public void setRidLoyPgm(String ridLoyPgm) {
		this.ridLoyPgm = ridLoyPgm;
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
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getPwdChangeTerm() {
		return pwdChangeTerm;
	}
	public void setPwdChangeTerm(String pwdChangeTerm) {
		this.pwdChangeTerm = pwdChangeTerm;
	}
	public String getFirstLoginFlg() {
		return firstLoginFlg;
	}
	public void setFirstLoginFlg(String firstLoginFlg) {
		this.firstLoginFlg = firstLoginFlg;
	}
	public void setByAdmin(Boolean byAdmin) {
		this.byAdmin = byAdmin;
	}
	public Boolean isByAdmin() {
		return byAdmin;
	}
	public String getServer() {
		return server;
	}
	public void setServer(String server) {
		this.server = server;
	}
	public Boolean getByAdmin() {
		return byAdmin;
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
