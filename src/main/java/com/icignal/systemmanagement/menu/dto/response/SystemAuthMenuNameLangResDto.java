package com.icignal.systemmanagement.menu.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemAuthMenuNameLangResDto extends GridPagingItemResDto {
	
	private String langName;
	private String langCode;
	private String menuLangName;
	private String menuLangCode;
	private String iconImg;
	
	public String getLangName() {
		return langName;
	}
	public void setLangName(String langName) {
		this.langName = langName;
	}
	public String getLangCode() {
		return langCode;
	}
	public void setLangCode(String langCode) {
		this.langCode = langCode;
	}
	public String getMenuLangName() {
		return menuLangName;
	}
	public void setMenuLangName(String menuLangName) {
		this.menuLangName = menuLangName;
	}
	public String getMenuLangCode() {
		return menuLangCode;
	}
	public void setMenuLangCode(String menuLangCode) {
		this.menuLangCode = menuLangCode;
	}
	public String getIconImg() {
		return iconImg;
	}
	public void setIconImg(String iconImg) {
		this.iconImg = iconImg;
	}

}
