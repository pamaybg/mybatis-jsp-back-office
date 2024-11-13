package com.icignal.systemmanagement.authgroup.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class AuthGroupEmployeeResDto extends GridPagingItemResDto {
	
	private String empEmail;
	private String empName;
	private String empType;
	@MarkName(groupCode = "WORK_STATUS", codeField = "empTypeCd")
	private String empTypeCd;
	private String empCreater;
	private String empCreateDate;
	private String id;
	private String userId;
	private String ridCrmUser;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmpEmail() {
		return empEmail;
	}
	public void setEmpEmail(String empEmail) {
		this.empEmail = empEmail;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getEmpType() {
		return empType;
	}
	public void setEmpType(String empType) {
		this.empType = empType;
	}
	public String getEmpCreater() {
		return empCreater;
	}
	public void setEmpCreater(String empCreater) {
		this.empCreater = empCreater;
	}
	public String getEmpCreateDate() {
		return empCreateDate;
	}
	public void setEmpCreateDate(String empCreateDate) {
		this.empCreateDate = empCreateDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRidCrmUser() {
		return ridCrmUser;
	}
	public void setRidCrmUser(String ridCrmUser) {
		this.ridCrmUser = ridCrmUser;
	}
	public String getEmpTypeCd() {
		return empTypeCd;
	}
	public void setEmpTypeCd(String empTypeCd) {
		this.empTypeCd = empTypeCd;
	}

}
