package com.icignal.kepler.targetGroup.targetGroup.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.targetGroup.dto.request
 * @date : 2016. 7. 21.
 * @author : 류동균
 * @description : 타겟그룹 목록 RequestDTO
 */
public class KprTargetGroupListReqDto extends CommonDataAuthReqDto {

	private String workflowFlag;
	private String empId;
	private String authType;
	private String brandCd;
	private String empType;



	public String getWorkflowFlag() {
		return workflowFlag;
	}

	public void setWorkflowFlag(String workflowFlag) {
		this.workflowFlag = workflowFlag;
	}

	public String getEmpId() {return empId;}

	public void setEmpId(String empId) {this.empId = empId;}

	public String getAuthType() {return authType;}

	public void setAuthType(String authType) {this.authType = authType;}

	public String getBrandCd() {return brandCd;}

	public void setBrandCd(String brandCd) {this.brandCd = brandCd;}

	public String getEmpType() {
		return empType;
	}

	public void setEmpType(String empType) {
		this.empType = empType;
	}
}
