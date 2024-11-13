package com.icignal.systemmanagement.employee.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemEmployeeItemDto extends GridPagingItemResDto {
	private String id;
	private String employeeNo;
	private String employeeName;
	
	@MarkName(groupCode = "POSITION", codeField = "position")
	private String position;
	
	@MarkName(groupCode = "RESPONSIBILITY", codeField = "responsibility")
	private String responsibility;
	private String storeName;

	private String storeType;
	private String storeId;
	
	@MarkName(groupCode = "ACCOUNT_DATA_TYPE", codeField = "storeType")
	private String markName;

	@MarkName(groupCode = "EMPLOYEE_TYPE", codeField = "employeeType")
	private String employeeTypeNm;
	private String employeeType;

	@MarkName(groupCode = "EMPLOYEE_AUTH_TYPE", codeField = "xAuthType")
	private String xAuthTypeNm;
	private String xAuthType;

	private String brandName;
	private String brandCode;

	public String getStoreType() {
		return storeType;
	}
	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	
	public String getMarkName() {
		return markName;
	}
	public void setMarkName(String markName) {
		this.markName = markName;
	}
	
	@MarkName(groupCode = "WORK_STATUS", codeField = "workStatus")
	private String workStatus;
	private Boolean adminUser;
	
	public Boolean getAdminUser() {
		return adminUser;
	}
	public void setAdminUser(Boolean adminUser) {
		this.adminUser = adminUser;
	}
	//2015.10.14 이필수 삭제시 지정된 관리자를 삭제 할수 없게 managerId 추가
	private String managerId;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmployeeNo() {
		return employeeNo;
	}
	public void setEmployeeNo(String employeeNo) {
		this.employeeNo = employeeNo;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getResponsibility() {
		return responsibility;
	}
	public void setResponsibility(String responsibility) {
		this.responsibility = responsibility;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getWorkStatus() {
		return workStatus;
	}
	public void setWorkStatus(String workStatus) {
		this.workStatus = workStatus;
	}
	/**
	 * @return the managerId
	 */
	public String getManagerId() {
		return managerId;
	}
	/**
	 * @param managerId the managerId to set
	 */
	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}

	public String getEmployeeTypeNm() {
		return employeeTypeNm;
	}

	public void setEmployeeTypeNm(String employeeTypeNm) {
		this.employeeTypeNm = employeeTypeNm;
	}

	public String getEmployeeType() {
		return employeeType;
	}

	public void setEmployeeType(String employeeType) {
		this.employeeType = employeeType;
	}

	public String getxAuthTypeNm() {
		return xAuthTypeNm;
	}

	public void setxAuthTypeNm(String xAuthTypeNm) {
		this.xAuthTypeNm = xAuthTypeNm;
	}

	public String getxAuthType() {
		return xAuthType;
	}

	public void setxAuthType(String xAuthType) {
		this.xAuthType = xAuthType;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getBrandCode() {
		return brandCode;
	}

	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}
}
