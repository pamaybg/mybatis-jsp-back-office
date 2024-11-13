package com.icignal.auth.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MenuListResDto extends GridPagingItemResDto {
	
	private String menuId;
	private String menuName;
	private String menuLevel;
	private String parentMenuId;
	private String langName;
	private String langCode;
	private Integer sortSeq;
	private String imageId;
	private String progId;
	private String imgFile;
	private String imgURL;
	private String lang;
	private String privacyFlg;
	private String mobileFlg;
	private String id;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getParentMenuId() {
		return parentMenuId;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public void setParentMenuId(String parentMenuId) {
		this.parentMenuId = parentMenuId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuLevel() {
		return menuLevel;
	}
	public void setMenuLevel(String menuLevel) {
		this.menuLevel = menuLevel;
	}
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
	public Integer getSortSeq() {
		return sortSeq;
	}
	public void setSortSeq(Integer sortSeq) {
		this.sortSeq = sortSeq;
	}
	public String getImageId() {
		return imageId;
	}
	public void setImageId(String imageId) {
		this.imageId = imageId;
	}
	public String getProgId() {
		return progId;
	}
	public void setProgId(String progId) {
		this.progId = progId;
	}
	public String getImgFile() {
		return imgFile;
	}
	public void setImgFile(String imgFile) {
		this.imgFile = imgFile;
	}
	public String getImgURL() {
		return imgURL;
	}
	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getPrivacyFlg() {
		return privacyFlg;
	}
	public void setPrivacyFlg(String privacyFlg) {
		this.privacyFlg = privacyFlg;
	}
	public String getMobileFlg() {return mobileFlg;}
	public void setMobileFlg(String mobileFlg) {this.mobileFlg = mobileFlg;}

}
