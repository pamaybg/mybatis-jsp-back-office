package com.icignal.auth.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

public class AuthMenuLisAuthtResDto extends StatusResDto {
	
	//장용 추가
	private String imgURL;
	private List<AuthMenuNameLangResDto> menuNameLang;
	
	private String menuName;
	private String menuId;
	private String readAuth;
	private String createAuth;
	private String updateAuth;
	private String deleteAuth;
	private String dataAuth;
	private String parentMenuId;
	private String menuLevel;
	private String storeId;
	private String authCreateDate;
	private String checkedMenuId;
	
	private List<AuthMenuLisAuthtResDto> menuList;
	
	
	
	public String getAuthCreateDate() {
		return authCreateDate;
	}
	public void setAuthCreateDate(String authCreateDate) {
		this.authCreateDate = authCreateDate;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getParentMenuId() {
		return parentMenuId;
	}
	public void setParentMenuId(String parentMenuId) {
		this.parentMenuId = parentMenuId;
	}
	public String getMenuLevel() {
		return menuLevel;
	}
	public void setMenuLevel(String menuLevel) {
		this.menuLevel = menuLevel;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getReadAuth() {
		return readAuth;
	}
	public void setReadAuth(String readAuth) {
		this.readAuth = readAuth;
	}
	public String getCreateAuth() {
		return createAuth;
	}
	public void setCreateAuth(String createAuth) {
		this.createAuth = createAuth;
	}
	public String getUpdateAuth() {
		return updateAuth;
	}
	public void setUpdateAuth(String updateAuth) {
		this.updateAuth = updateAuth;
	}
	public String getDeleteAuth() {
		return deleteAuth;
	}
	public void setDeleteAuth(String deleteAuth) {
		this.deleteAuth = deleteAuth;
	}
	public String getDataAuth() {
		return dataAuth;
	}
	public void setDataAuth(String dataAuth) {
		this.dataAuth = dataAuth;
	}
	public List<AuthMenuLisAuthtResDto> getMenuList() {
		return menuList;
	}
	public void setMenuList(List<AuthMenuLisAuthtResDto> menuList) {
		this.menuList = menuList;
	}
	public String getCheckedMenuId() {
		return checkedMenuId;
	}
	public void setCheckedMenuId(String checkedMenuId) {
		this.checkedMenuId = checkedMenuId;
	}
	public String getImgURL() {
		return imgURL;
	}
	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
	public List<AuthMenuNameLangResDto> getMenuNameLang() {
		return menuNameLang;
	}
	public void setMenuNameLang(List<AuthMenuNameLangResDto> menuNameLang) {
		List<AuthMenuNameLangResDto> inMenuNameLang = menuNameLang;
		if(inMenuNameLang == null){
			inMenuNameLang = new ArrayList<AuthMenuNameLangResDto>();
		}
		
		this.menuNameLang = inMenuNameLang;
	}
	
	
	

}
