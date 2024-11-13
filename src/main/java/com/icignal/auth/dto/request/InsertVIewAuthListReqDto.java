package com.icignal.auth.dto.request;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class InsertVIewAuthListReqDto extends GridPagingReqDto {
	
	private String authId;
	private String empId;
	private List<String> menuIdList;
	
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public List<String> getMenuIdList() {
		return menuIdList;
	}
	public void setMenuIdList(List<String> menuIdList) {
		List<String> inMenuIdList = menuIdList;
		
		if(inMenuIdList == null){
			inMenuIdList = new ArrayList<String>();
		}
		this.menuIdList = inMenuIdList;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}

}
