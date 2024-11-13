package com.icignal.auth.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class GetAuthGroupListByEIRUResDto extends GridPagingItemResDto {
	
	private String id;
	private String authGroupName;
	private String authGroupType;
	private String authGroupDesc;
	private String modifyDate;
	private String autGroupId;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAuthGroupName() {
		return authGroupName;
	}
	public void setAuthGroupName(String authGroupName) {
		this.authGroupName = authGroupName;
	}
	public String getAuthGroupType() {
		return authGroupType;
	}
	public void setAuthGroupType(String authGroupType) {
		this.authGroupType = authGroupType;
	}
	public String getAuthGroupDesc() {
		return authGroupDesc;
	}
	public void setAuthGroupDesc(String authGroupDesc) {
		this.authGroupDesc = authGroupDesc;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	/**
	* @return the autGroupId
	*/
	public String getAutGroupId() {
		return autGroupId;
	}
	/**
	* @param autGroupId the autGroupId to set
	*/
	public void setAutGroupId(String autGroupId) {
		this.autGroupId = autGroupId;
	}
}
