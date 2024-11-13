package com.icignal.kepler.common.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: KPRNodeListRequestDTO
 * 2. 파일명	: KPRNodeListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprNodeListReqDto extends MKTBaseReqDto {
	
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