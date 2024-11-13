package com.icignal.systemmanagement.condition.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;


/**
 * @name : getBaseTable
 * @date : 2015. 10. 13.
 * @author : 장  용
 * @description : 기본 테이블 목록 조회
 */
public class SystemGetBaseTableListReqDto extends GridPagingReqDto {
	
	private String empId;		//직원 아이디
	private String accntId;
	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getAccntId() {
		return accntId;
	}

	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	
	
}
