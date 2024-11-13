package com.icignal.systemmanagement.condition.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * @name : menuList
 * @date : 2015. 10. 13.
 * @author : 장  용
 * @description : 화면 목록 조회
 */
@CommCode
public class SystemgetMenuListResDto extends GridPagingItemResDto {
	
	private String menuId;
	private String menuName;
	
	private String menuTypeCd;
	
	@MarkName(groupCode="ADMIN_PROG_TYPE", codeField="menuTypeCd")
	private String menuLevel;
	
	private String menuSeq;
	
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
	public String getMenuSeq() {
		return menuSeq;
	}
	public void setMenuSeq(String menuSeq) {
		this.menuSeq = menuSeq;
	}
	public String getMenuTypeCd() {
		return menuTypeCd;
	}
	public void setMenuTypeCd(String menuTypeCd) {
		this.menuTypeCd = menuTypeCd;
	}
	
	
}
