package com.icignal.auth.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.BaseReqDto;

public class DeleteMenuListReqDto extends BaseReqDto {
	
	private String menuId;
	private List<DeleteMenuListReqDto> array;
	
	public List<DeleteMenuListReqDto> getArray() {
		return array;
	}
	public void setArray(List<DeleteMenuListReqDto> array) {
		this.array = array;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	
	

}
