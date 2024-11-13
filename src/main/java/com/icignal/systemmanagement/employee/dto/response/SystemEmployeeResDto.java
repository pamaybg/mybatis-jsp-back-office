package com.icignal.systemmanagement.employee.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class SystemEmployeeResDto extends GridPagingItemResDto {
	private String id;
	private String employeeNo;
	private String employeeName;
	private String position;
	private String responsibility;
	private String storeName;
	private String birthday;
	private String entranceDate;
	private String workStatus;
	private String phone1;
	private String phone2;
	private String phone3;
	
	private String extention;
	private String mobile1;
	private String mobile2;
	private String mobile3;
	private String storeId;
	
	@Decrypted(masked = "none")
	private String email;
	
	private String password;
	private String ridDivision;
	
	@Decrypted(masked = "none")
	private String mobileNo;
	@Decrypted(masked = "none")
	private String phoneNo;

	private String empAuthGroup;

	private String employeeType;
	private String xAuthType;


	public String getRidDivision() {
		return ridDivision;
	}
	public void setRidDivision(String ridDivision) {
		this.ridDivision = ridDivision;
	}
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
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getEntranceDate() {
		return entranceDate;
	}
	public void setEntranceDate(String entranceDate) {
		this.entranceDate = entranceDate;
	}
	public String getWorkStatus() {
		return workStatus;
	}
	public void setWorkStatus(String workStatus) {
		this.workStatus = workStatus;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	public String getExtention() {
		return extention;
	}
	public void setExtention(String extention) {
		this.extention = extention;
	}
	public String getMobile1() {
		return mobile1;
	}
	public void setMobile1(String mobile1) {
		this.mobile1 = mobile1;
	}
	public String getMobile2() {
		return mobile2;
	}
	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}
	public String getMobile3() {
		return mobile3;
	}
	public void setMobile3(String mobile3) {
		this.mobile3 = mobile3;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getEmpAuthGroup() {
		return empAuthGroup;
	}
	public void setEmpAuthGroup(String empAuthGroup) {
		this.empAuthGroup = empAuthGroup;
	}

	public String getEmployeeType() {
		return employeeType;
	}

	public void setEmployeeType(String employeeType) {
		this.employeeType = employeeType;
	}

	public String getxAuthType() {
		return xAuthType;
	}

	public void setxAuthType(String xAuthType) {
		this.xAuthType = xAuthType;
	}
}
