package com.icignal.systemmanagement.condition.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;


/**
 * @name : removeCondition
 * @date : 2015. 10. 13.
 * @author : 장  용
 * @description : 조건 삭제
 */
public class SystemRemoveConditionReqDto extends MKTBaseReqDto {
	
	private String empId;		//직원 아이디
	private String conditionId;	//조건 아이디

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getConditionId() {
		return conditionId;
	}

	public void setConditionId(String conditionId) {
		this.conditionId = conditionId;
	}

	
}