package com.icignal.systemmanagement.condition.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;


/**
 * @name : getMenuList
 * @date : 2015. 09. 23.
 * @author : 장  용
 * @description : 템플릿 프롬프트 검증
 */
public class SystemGetMenuListReqDto extends GridPagingReqDto {
	
	private String empId;		//직원 아이디

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}
	
}
