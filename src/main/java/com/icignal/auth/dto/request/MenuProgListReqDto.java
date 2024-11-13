package com.icignal.auth.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class MenuProgListReqDto extends GridPagingReqDto {
	
	private String menuId;
	private List<String> progId;
	
	public List<String> getProgId() {
		return progId;
	}
	public void setProgId(List<String> progId) {
		this.progId = progId;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	

}
