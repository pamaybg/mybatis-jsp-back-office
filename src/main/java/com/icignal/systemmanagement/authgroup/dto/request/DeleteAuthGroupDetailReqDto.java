package com.icignal.systemmanagement.authgroup.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class DeleteAuthGroupDetailReqDto extends MKTBaseReqDto {
	
	private String empId;
	private List<String> delIdList;
	private List<String> authIdList;
	private List<String> ridCrmUserList;
	private String authGroupId;
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public List<String> getDelIdList() {
		return delIdList;
	}
	public void setDelIdList(List<String> delIdList) {
		this.delIdList = delIdList;
	}
	public String getAuthGroupId() {
		return authGroupId;
	}
	public void setAuthGroupId(String authGroupId) {
		this.authGroupId = authGroupId;
	}
	public List<String> getRidCrmUserList() {
		return ridCrmUserList;
	}
	public void setRidCrmUserList(List<String> ridCrmUserList) {
		this.ridCrmUserList = ridCrmUserList;
	}
	public List<String> getAuthIdList() {
		return authIdList;
	}
	public void setAuthIdList(List<String> authIdList) {
		this.authIdList = authIdList;
	}

}
