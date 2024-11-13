package com.icignal.auth.dto.request;


import com.icignal.common.base.dto.request.BaseReqDto;

public class InsertUserDetailReqDto extends BaseReqDto {
	
	private String idEmployee;
	private String ridLoyPgm;
	private String userId;
	private String userPw;
	private String pwExpirDate;
	private String userStat;
	private String createBy;
	private String modifyBy;
	private String rid;

	
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
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
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
}
