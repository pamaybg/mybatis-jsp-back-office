package com.icignal.common.base.dto.response;

import java.io.Serializable;

import com.icignal.common.base.dto.request.BaseReqDto;
import com.icignal.common.util.CommonUtil;


/**
 * @name : menuFrontResponseDTO 
 * @date : 2015. 10. 07.
 * @author : 안형욱
 */ 

public class MenuFrontResDto extends BaseReqDto implements Serializable{

     
	 /**
     * 
     */
    private static final long serialVersionUID = -8771245443667080808L;
    
    
    private String authGroup;
	 private String progNum;
	 private String progName;
	 private String progTypeCd;
	 private String progPath;
	 private String menuId;
	 
	 private String menuName;
	 private Integer menuLevel;
	 private String imageId;
	 
	 private String parentMenuId;
	 private Integer sortSeq;
	 private String imgURL;
	 private String applyType;
	 
	 private String iconImg;

	 
	 
	public String getApplyType() {
		return applyType;
	}
	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getImgURL() {
		return imgURL;
	}
	public void setImgURL(String imgURL) {
		this.imgURL = CommonUtil.getInstance().getImageServerUrl()+"/"+imgURL;
	}
	public String getAuthGroup() {
		return authGroup;
	}
	public void setAuthGroup(String authGroup) {
		this.authGroup = authGroup;
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
	public Integer getMenuLevel() {
		return menuLevel;
	}
	public void setMenuLevel(Integer menuLevel) {
		this.menuLevel = menuLevel;
	}
	public String getImageId() {
		return imageId;
	}
	public void setImageId(String imageId) {
		this.imageId = imageId;
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
	public String getIconImg() {
		return iconImg;
	}
	public void setIconImg(String iconImg) {
		this.iconImg = iconImg;
	}	
}
