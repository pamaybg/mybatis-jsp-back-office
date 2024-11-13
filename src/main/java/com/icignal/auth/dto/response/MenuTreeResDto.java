package com.icignal.auth.dto.response;

import java.util.ArrayList;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MenuTreeResDto extends GridPagingItemResDto {
	
	private ArrayList<MenuListResDto> menuList;

	public ArrayList<MenuListResDto> getMenuList() {
		return menuList;
	}

	public void setMenuList(ArrayList<MenuListResDto> menuList) {
		this.menuList = menuList;
	}

}
