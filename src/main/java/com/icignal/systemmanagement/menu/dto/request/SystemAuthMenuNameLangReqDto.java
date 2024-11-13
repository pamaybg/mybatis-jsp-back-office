package com.icignal.systemmanagement.menu.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class SystemAuthMenuNameLangReqDto extends GridPagingReqDto{
	
	private String menuId;

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	
	

}
