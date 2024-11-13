package com.icignal.auth.dto.response;

import java.io.Serializable;

public class AuthorityMenuListResDto  implements Serializable {
	
	private static final long serialVersionUID = -3563742645861309466L;
	
	private String menuId;			//메뉴 아이디
	private String menuName;		//메뉴명
	private String menuLevel;		//메뉴 레벨
	private String progNum;			//프로그램 번호
	private String progName;		//프로그래명
	private String progTypeCd;		//프로그램 유형 코드
	private String progPath;		//프로그램 path
	private String parentMenuId;	//상위 메뉴 아이디
	private String sortSeq;			//정렬순서
	private String imgURL;			//이미지url
	private String applyType;		//유형
	private int privacyFlg;			//개인정보 처리 메뉴 여부
	private String iconImg;			//메뉴아이콘 이미지 파일
	private String mobileYn;		//모바일 화면 사용 유무
	
	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
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

	public String getProgTypeCd() {
		return progTypeCd;
	}

	public void setProgTypeCd(String progTypeCd) {
		this.progTypeCd = progTypeCd;
	}

	public String getProgPath() {
		return progPath;
	}

	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}

	public String getParentMenuId() {
		return parentMenuId;
	}

	public void setParentMenuId(String parentMenuId) {
		this.parentMenuId = parentMenuId;
	}

	public String getSortSeq() {
		return sortSeq;
	}

	public void setSortSeq(String sortSeq) {
		this.sortSeq = sortSeq;
	}

	public String getImgURL() {
		return imgURL;
	}

	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public int getPrivacyFlg() {
		return privacyFlg;
	}

	public void setPrivacyFlg(int privacyFlg) {
		this.privacyFlg = privacyFlg;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getIconImg() {
		return iconImg;
	}

	public void setIconImg(String iconImg) {
		this.iconImg = iconImg;
	}

	public String getMobileYn() {
		return mobileYn;
	}

	public void setMobileYn(String mobileYn) {
		this.mobileYn = mobileYn;
	}
}
