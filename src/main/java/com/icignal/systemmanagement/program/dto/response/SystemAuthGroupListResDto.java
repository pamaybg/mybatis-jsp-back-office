package com.icignal.systemmanagement.program.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemAuthGroupListResDto extends GridPagingItemResDto{
	
	private String GroupName;
	private String GroupDesc;
	private String GroupStatus;
	private String Group_Creater;
	private String Group_Create_Date;
	private String id;
	private String authId;
	private String authCreateDate;
	private String autNm;
	private String autDesc;
	private String autNum;
	private String programId;

	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public String getGroupDesc() {
		return GroupDesc;
	}
	public void setGroupDesc(String groupDesc) {
		GroupDesc = groupDesc;
	}
	public String getGroupStatus() {
		return GroupStatus;
	}
	public void setGroupStatus(String groupStatus) {
		GroupStatus = groupStatus;
	}
	public String getGroup_Creater() {
		return Group_Creater;
	}
	public void setGroup_Creater(String group_Creater) {
		Group_Creater = group_Creater;
	}
	public String getGroup_Create_Date() {
		return Group_Create_Date;
	}
	public void setGroup_Create_Date(String group_Create_Date) {
		Group_Create_Date = group_Create_Date;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getAuthCreateDate() {
		return authCreateDate;
	}
	public void setAuthCreateDate(String authCreateDate) {
		this.authCreateDate = authCreateDate;
	}
	public String getAutNm() {
		return autNm;
	}
	public void setAutNm(String autNm) {
		this.autNm = autNm;
	}
	public String getAutNum() {
		return autNum;
	}
	public void setAutNum(String autNum) {
		this.autNum = autNum;
	}
	public String getAutDesc() {
		return autDesc;
	}
	public void setAutDesc(String autDesc) {
		this.autDesc = autDesc;
	}
	public String getProgramId() {
		return programId;
	}
	public void setProgramId(String programId) {
		this.programId = programId;
	}

	

}
