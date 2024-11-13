package com.icignal.systemmanagement.condition.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : getConditionList
 * @date : 2015. 10. 13.
 * @author : 장  용
 * @description : 조건 목록 조회
 */
public class SystemGetDropDownListResDto extends GridPagingItemResDto {
	
	private String id;		//아이디
	private String groupName;	//그룹 명
	private String groupCode;	//그룹 코드
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGroupCode() {
		return groupCode;
	}
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
}
