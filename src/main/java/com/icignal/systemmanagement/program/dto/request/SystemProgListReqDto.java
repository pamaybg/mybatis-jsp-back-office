package com.icignal.systemmanagement.program.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class SystemProgListReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String prgId;
	private List<String> progId;
	private String empId;
	private String createDate;
	private String authId;
	private String childprgId;
	
	
	
	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public List<String> getProgId() {
		return progId;
	}

	public void setProgId(List<String> progId) {
		this.progId = progId;
	}

	public String getPrgId() {
		return prgId;
	}

	public void setPrgId(String prgId) {
		this.prgId = prgId;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getAuthId() {
		return authId;
	}

	public void setAuthId(String authId) {
		this.authId = authId;
	}

	public String getChildprgId() {
		return childprgId;
	}

	public void setChildprgId(String childprgId) {
		this.childprgId = childprgId;
	}
	
	

}
