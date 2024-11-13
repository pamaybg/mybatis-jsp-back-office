package com.icignal.systemmanagement.employee.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.BaseReqDto;

public class SystemDeleteAuthGroupByRidReqDto extends BaseReqDto {

	private List<String> objRelIdList;
	private String id;
	private String empId;
	private String ridUser;
	private String autGroupId;


	public List<String> getObjRelIdList() {
		return objRelIdList;
	}
	public void setObjRelIdList(List<String> objRelIdList) {
		this.objRelIdList = objRelIdList;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	/**
	* @return the ridUser
	*/
	public String getRidUser() {
		return ridUser;
	}
	/**
	* @param ridUser the ridUser to set
	*/
	public void setRidUser(String ridUser) {
		this.ridUser = ridUser;
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
