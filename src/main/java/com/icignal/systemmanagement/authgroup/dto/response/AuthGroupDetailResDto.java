package com.icignal.systemmanagement.authgroup.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class AuthGroupDetailResDto extends StatusResDto {
	
	private String groupName;
	private String groupType;
	private String groupDesc;
	private String groupCreater;
	private String groupCreateDate;
	
	
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
	public String getGroupCreater() {
		return groupCreater;
	}
	public void setGroupCreater(String groupCreater) {
		this.groupCreater = groupCreater;
	}
	public String getGroupCreateDate() {
		return groupCreateDate;
	}
	public void setGroupCreateDate(String groupCreateDate) {
		this.groupCreateDate = groupCreateDate;
	}

}
