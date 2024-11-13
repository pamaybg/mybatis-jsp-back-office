package com.icignal.systemmanagement.authgroup.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class AuthGroupInsertReqDto extends MKTBaseReqDto {
	
	private String groupName;
	private String groupType;
	private String groupDesc;
	private String empId;
	private String groupId;
	
	
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getGroupType() {
		return groupType;
	}
	public void setGroupType(String groupType) {
		this.groupType = groupType;
	}
	public String getGroupDesc() {
		return groupDesc;
	}
	public void setGroupDesc(String groupDesc) {
		this.groupDesc = groupDesc;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

}
