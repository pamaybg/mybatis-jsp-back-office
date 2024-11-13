package com.icignal.systemmanagement.organization.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class SystemOrganziationNodeListReqDto extends MKTBaseReqDto {
	private String empId;
	private String reportFlag;

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getReportFlag() {
		return reportFlag;
	}

	public void setReportFlag(String reportFlag) {
		this.reportFlag = reportFlag;
	}
}