package com.icignal.systemmanagement.employee.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
 * @name : insertEmployee
 * @date : 2014. 12. 05.
 * @author : 장  용
 * @description : 직원 등록
 */
@PersonalData
public class SystemEmployeeInfoReqDto extends CommonDataAuthReqDto {
	private String empId;

	private String storeId;		//해당 어카운트의 스토어 아이디 (차일드)
	private String employeeId;
	private String id;
	private String memId;		//해당 어카운트 아이디 ( 상위)
	private String password;

	private String employeeNo;
	private String employeeName;
	private String birthday;
	private String entranceDate;
	private String phone1;
	private String phone2;
	private String phone3;
	
	@Encrypted
	private String phoneNo;	
	
	private String extention;
	
	private String mobile1;
	private String mobile2;
	private String mobile3;
	
	@Encrypted 
	private String mobileNo;

	private String position;
	private String responsibility;
	private String workStatus;
	private String empType;

	private List<String> listEmployeeId;
	
	@Encrypted
	private String email;

	private String ridDivision;

	private String cipherKey;
	
	private List<String> empAuthGroupList;
	private String empAuthGroup;

	//사용자 유형
	private String employeeType;
	//권한 유형
	private String xAuthType;

	/*
	 * public MKTEmployeeInfoRequestDTO() { try {
	 * this.setCipherKey(CryptoManager.getCipherKey()); } catch ( Exception e ) {
	 * LogUtil.error(e); } }
	 */
	public String getRidDivision() {
		return ridDivision;
	}
	public void setRidDivision(String ridDivision) {
		this.ridDivision = ridDivision;
	}
	public String getEntranceDate() {
		return entranceDate;
	}
	public void setEntranceDate(String entranceDate) {
		this.entranceDate = entranceDate;
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
	public String getWorkStatus() {
		return workStatus;
	}
	public void setWorkStatus(String workStatus) {
		this.workStatus = workStatus;
	}
	public String getEmpType() {
		return empType;
	}
	public void setEmpType(String empType) {
		this.empType = empType;
	}
	public List<String> getListEmployeeId() {
		return listEmployeeId;
	}
	public void setListEmployeeId(List<String> listEmployeeId) {
		this.listEmployeeId = listEmployeeId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}

	public String getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}

	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	/**
	* @return the cipherKey
	*/
	@Override
	public String getCipherKey() {
		return cipherKey;
	}
	/**
	* @param cipherKey the cipherKey to set
	*/
	@Override
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
	/**
	* @return the phoneNo
	*/
	public String getPhoneNo() {
		return phoneNo;
	}
	/**
	* @param phoneNo the phoneNo to set
	*/
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	/**
	* @return the mobileNo
	*/
	public String getMobileNo() {
		return mobileNo;
	}
	/**
	* @param mobileNo the mobileNo to set
	*/
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public List<String> getEmpAuthGroupList() {
		return empAuthGroupList;
	}
	public void setEmpAuthGroupList(List<String> empAuthGroupList) {
		this.empAuthGroupList = empAuthGroupList;
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
