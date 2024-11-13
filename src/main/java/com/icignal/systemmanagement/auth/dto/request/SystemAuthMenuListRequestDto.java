package com.icignal.systemmanagement.auth.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class SystemAuthMenuListRequestDto extends MKTBaseReqDto{
	
	private String menuId;
	private String authId;
	private String authGroupId;
	private String empId;
	
	//권한삭제
	private List<String> authIds;
	
	
	public List<String> getAuthIds() {
		return authIds;
	}
	public void setAuthIds(List<String> authIds) {
		this.authIds = authIds;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getAuthGroupId() {
		return authGroupId;
	}
	public void setAuthGroupId(String authGroupId) {
		this.authGroupId = authGroupId;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	

}
