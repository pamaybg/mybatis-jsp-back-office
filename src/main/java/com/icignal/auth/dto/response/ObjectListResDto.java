package com.icignal.auth.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class ObjectListResDto extends GridPagingItemResDto {

	private String id;
	private String objTypeCd;
	private String objCd;
	private String objNm;
	private String objDesc;
	private String modifyBy;
	private String modifyDate;
	
	
	public String getObjTypeCd() {
		return objTypeCd;
	}
	public void setObjTypeCd(String objTypeCd) {
		this.objTypeCd = objTypeCd;
	}
	public String getObjCd() {
		return objCd;
	}
	public void setObjCd(String objCd) {
		this.objCd = objCd;
	}
	public String getObjNm() {
		return objNm;
	}
	public void setObjNm(String objNm) {
		this.objNm = objNm;
	}
	public String getObjDesc() {
		return objDesc;
	}
	public void setObjDesc(String objDesc) {
		this.objDesc = objDesc;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
