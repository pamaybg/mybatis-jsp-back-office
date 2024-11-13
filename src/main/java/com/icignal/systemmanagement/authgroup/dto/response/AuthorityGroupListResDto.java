package com.icignal.systemmanagement.authgroup.dto.response;

import java.io.Serializable;
import java.util.List;

public class AuthorityGroupListResDto  implements Serializable {
	
	private static final long serialVersionUID = -4595369350808190228L;
	
	private String id;				//권한그룹 아이디
	private String GroupName;		//권한그룹명
	private String GroupDesc;		//권한그룹 설명
	private String GroupStatus;		//권한그룹 상태코드
	private String type;			//유형
	
	private List<AuthorityDataListResDto> authDataList;		//권한데이터 목록
	
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
	
	public List<AuthorityDataListResDto> getAuthDataList() {
		return authDataList;
	}

	public void setAuthDataList(List<AuthorityDataListResDto> authDataList) {
		this.authDataList = authDataList;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	

}
