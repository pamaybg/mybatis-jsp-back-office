package com.icignal.systemmanagement.employee.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemEmployeeReqDto extends CommonCondReqDto {
	
	private String storeId;		//해당 어카운트의 스토어 아이디
	private String storeType;
	private List<Object> accountList;
	private String ridDivision;
	private List<Object> divisionList;
	private int dept;
	private String xBrandCd;
	
	public int getDept() {
		return dept;
	}

	public void setDept(int dept) {
		this.dept = dept;
	}

	public List<Object> getDivisionList() {
		return divisionList;
	}

	public void setDivisionList(List<Object> divisionList) {
		this.divisionList = divisionList;
	}

	public String getRidDivision() {
		return ridDivision;
	}

	public void setRidDivision(String ridDivision) {
		this.ridDivision = ridDivision;
	}

	public List<Object> getAccountList() {
		return accountList;
	}

	public void setAccountList(List<Object> accountList) {
		this.accountList = accountList;
	}

	public String getStoreId() {
		return storeId;
	}

	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}

	public String getStoreType() {
		return storeType;
	}

	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}

	public String getxBrandCd() {
		return xBrandCd;
	}

	public void setxBrandCd(String xBrandCd) {
		this.xBrandCd = xBrandCd;
	}
}
