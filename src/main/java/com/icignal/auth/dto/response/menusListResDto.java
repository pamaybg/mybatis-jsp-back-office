package com.icignal.auth.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.common.util.CommonUtil;

public class menusListResDto extends GridPagingItemResDto {
	
	private List<AuthMenuNameLangResDto> menuNameLang;
	private String id;
	private String parentMenuId;
	private Integer sortSeq;
	private String fileName;
	private String modifyDate;
	
	private String progNum;
	private String progName;
	private String progType;
	private String progId;
	private String progPath;
	private String applyType;
	private String progKey;
	private String progTypeCheck;
	

	private String imgURL;
	private String menuName;
	private String menuId;
	private String imageId;
	private String menuLevel;
	private String imgFile;	
	
	private int privacyFlg; //개인정보 메뉴 여부
		
	
	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getProgPath() {
		return progPath;
	}

	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}

	public String getProgNum() {
		return progNum;
	}

	public void setProgNum(String progNum) {
		this.progNum = progNum;
	}

	public String getProgName() {
		return progName;
	}

	public void setProgName(String progName) {
		this.progName = progName;
	}

	public String getProgType() {
		return progType;
	}

	public void setProgType(String progType) {
		this.progType = progType;
	}

	public String getProgId() {
		return progId;
	}

	public void setProgId(String progId) {
		this.progId = progId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParentMenuId() {
		return parentMenuId;
	}

	public void setParentMenuId(String parentMenuId) {
		this.parentMenuId = parentMenuId;
	}

	public Integer getSortSeq() {
		return sortSeq;
	}

	public void setSortSeq(Integer sortSeq) {
		this.sortSeq = sortSeq;
	}
	
	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getImageId() {
		return imageId;
	}

	public void setImageId(String imageId) {
		this.imageId = imageId;
	}

	public String getMenuLevel() {
		return menuLevel;
	}

	public void setMenuLevel(String menuLevel) {
		this.menuLevel = menuLevel;
	}

	public String getImgFile() {
		return imgFile;
	}

	public void setImgFile(String imgFile) {
		this.imgFile = imgFile;
	}

	public String getImgURL() {
		return CommonUtil.getInstance().getImageServerUrl() + "/" + imgURL;
	}

	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
	
	public String getProgKey() {
		return progKey;
	}

	public void setProgKey(String progKey) {
		this.progKey = progKey;
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

	public String getProgTypeCheck() {
		return progTypeCheck;
	}

	public void setProgTypeCheck(String progTypeCheck) {
		this.progTypeCheck = progTypeCheck;
	}

	public int getPrivacyFlg() {
		return privacyFlg;
	}

	public void setPrivacyFlg(int privacyFlg) {
		this.privacyFlg = privacyFlg;
	}
		
	
}
