package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class InsertProgDetailReqDto extends MKTBaseReqDto {
	
	private String progNo;
	private String progName;
	private String progType;
	private String progPath;
	private String progId;
	private String empId;
	
	
	public String getProgId() {
		return progId;
	}
	public void setProgId(String progId) {
		this.progId = progId;
	}
	public String getProgNo() {
		return progNo;
	}
	public void setProgNo(String progNo) {
		this.progNo = progNo;
	}
	public String getProgName() {
		return progName;
	}
	public void setProgName(String progName) {
		this.progName = progName;
	}
	public String getProgType() {
		return progType;
	}
	public void setProgType(String progType) {
		this.progType = progType;
	}
	public String getProgPath() {
		return progPath;
	}
	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}

}
