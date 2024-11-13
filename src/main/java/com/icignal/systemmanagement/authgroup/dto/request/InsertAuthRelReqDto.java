package com.icignal.systemmanagement.authgroup.dto.request;

import com.icignal.common.base.dto.request.BaseReqDto;

public class InsertAuthRelReqDto extends BaseReqDto {
	
	private String menuName;
	private String menuId;
	private String readAuth;
	private String createAuth;
	private String updateAuth;
	private String deleteAuth;
	private String dataAuth;
	private String parentMenuId;
	private String authId;
	private String menuLevel;
	private String empId;
	private String authCreateDate;
	
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getReadAuth() {
		return readAuth;
	}
	public void setReadAuth(String readAuth) {
		this.readAuth = readAuth;
	}
	public String getCreateAuth() {
		return createAuth;
	}
	public void setCreateAuth(String createAuth) {
		this.createAuth = createAuth;
	}
	public String getUpdateAuth() {
		return updateAuth;
	}
	public void setUpdateAuth(String updateAuth) {
		this.updateAuth = updateAuth;
	}
	public String getDeleteAuth() {
		return deleteAuth;
	}
	public void setDeleteAuth(String deleteAuth) {
		this.deleteAuth = deleteAuth;
	}
	public String getDataAuth() {
		return dataAuth;
	}
	public void setDataAuth(String dataAuth) {
		this.dataAuth = dataAuth;
	}
	public String getParentMenuId() {
		return parentMenuId;
	}
	public void setParentMenuId(String parentMenuId) {
		this.parentMenuId = parentMenuId;
	}
	public String getMenuLevel() {
		return menuLevel;
	}
	public void setMenuLevel(String menuLevel) {
		this.menuLevel = menuLevel;
	}
	public String getAuthCreateDate() {
		return authCreateDate;
	}
	public void setAuthCreateDate(String authCreateDate) {
		this.authCreateDate = authCreateDate;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	

}
