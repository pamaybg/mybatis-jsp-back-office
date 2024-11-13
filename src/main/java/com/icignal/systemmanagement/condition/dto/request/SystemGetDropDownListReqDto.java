package com.icignal.systemmanagement.condition.dto.request;


import com.icignal.common.base.dto.request.MKTGridPagingReqDto;


/**
 * @name : getDropDownList
 * @date : 2015. 09. 23.
 * @author : 장  용
 * @description : 조건 드롭다운 리스트 조회
 */
public class SystemGetDropDownListReqDto extends MKTGridPagingReqDto {
	
	private String empId;		//직원 아이디

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}
	
}
