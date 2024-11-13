package com.icignal.auth.dto.request;

import java.util.List;

import com.icignal.auth.dto.response.AuthMenuListResDto;
import com.icignal.common.base.dto.request.MKTBaseReqDto;


public class InsertAuthDetailReqDto extends MKTBaseReqDto {
	
	private String dataType;
	
	private String empId;
	private String menuId;
	private String authId;
	private String authNo;
	private String authName;
	private String authDesc;
	private String authCreateDate;
	private String readAuth;
	private String createAuth;
	private String updateAuth;
	private String deleteAuth;
	private String dataAuth;
	private List<AuthMenuListResDto> menuList;
	private String pgmObjType;
	
	
	
	
	public String getDataAuth() {
		return dataAuth;
	}
	public void setDataAuth(String dataAuth) {
		this.dataAuth = dataAuth;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getAuthNo() {
		return authNo;
	}
	public void setAuthNo(String authNo) {
		this.authNo = authNo;
	}
	public String getAuthName() {
		return authName;
	}
	public void setAuthName(String authName) {
		this.authName = authName;
	}
	public String getAuthDesc() {
		return authDesc;
	}
	public void setAuthDesc(String authDesc) {
		this.authDesc = authDesc;
	}
	public String getAuthCreateDate() {
		return authCreateDate;
	}
	public void setAuthCreateDate(String authCreateDate) {
		this.authCreateDate = authCreateDate;
	}
	public List<AuthMenuListResDto> getMenuList() {
		return menuList;
	}
	public void setMenuList(List<AuthMenuListResDto> menuList) {
		this.menuList = menuList;
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
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	public String getPgmObjType() {
		return pgmObjType;
	}
	public void setPgmObjType(String pgmObjType) {
		this.pgmObjType = pgmObjType;
	}
	

}
