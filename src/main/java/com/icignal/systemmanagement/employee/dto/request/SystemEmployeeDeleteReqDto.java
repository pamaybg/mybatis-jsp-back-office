package com.icignal.systemmanagement.employee.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.BaseReqDto;

/**
 * @name : deleteEmployee
 * @date : 2014. 12. 05.
 * @author : 장  용
 * @description : 직원 삭제
 * 
 * @editor : 박광민
 * @editDate : 2015. 10. 14.
 * @comment : storeId 추가
 */

public class SystemEmployeeDeleteReqDto extends BaseReqDto {
	
	private List<String> listEmployeeId;		//직원 리스트 아이디
	private String storeId;

	public List<String> getListEmployeeId() {
		return listEmployeeId;
	}

	public void setListEmployeeId(List<String> listEmployeeId) {
		this.listEmployeeId = listEmployeeId;
	}

	public String getStoreId() {
		return storeId;
	}

	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	
}
