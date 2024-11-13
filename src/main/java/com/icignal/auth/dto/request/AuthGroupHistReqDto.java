package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.BaseReqDto;

public class AuthGroupHistReqDto extends BaseReqDto {
	private String createBy;
	private String modifyBy;
	
	private String ridUser;
	private String idEmployee;
	private String autGroupId;
	private String modifyProgNm;
	private String isNewStartDate;
	private String isNewEndDate;
	
	private String authUserRelId;
	
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
	public String getAutGroupId() {
		return autGroupId;
	}
	public void setAutGroupId(String autGroupId) {
		this.autGroupId = autGroupId;
	}
	public String getModifyProgNm() {
		return modifyProgNm;
	}
	public void setModifyProgNm(String modifyProgNm) {
		this.modifyProgNm = modifyProgNm;
	}
	public String getIsNewStartDate() {
		return isNewStartDate;
	}
	public void setIsNewStartDate(String isNewStartDate) {
		this.isNewStartDate = isNewStartDate;
	}
	public String getIsNewEndDate() {
		return isNewEndDate;
	}
	public void setIsNewEndDate(String isNewEndDate) {
		this.isNewEndDate = isNewEndDate;
	}
	public String getAuthUserRelId() {
		return authUserRelId;
	}
	public void setAuthUserRelId(String authUserRelId) {
		this.authUserRelId = authUserRelId;
	}
	public String getRidUser() {
		return ridUser;
	}
	public void setRidUser(String ridUser) {
		this.ridUser = ridUser;
	}
}
