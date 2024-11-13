package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.BaseReqDto;

public class InsertUIObjectDetailReqDto extends BaseReqDto {

	private String id;
	private String objTypeCd;
	private String objCd;
	private String objId;
	private String uiObjNm;
	private String uiObjDesc;
	private String useFlag;
	private String objNm;
	private String createBy;
	private String createDate;
	private String modifyBy;
	private String modifyDate;

	private String empId;
	
	private String pgmId;
	
	private String authId;
	
	public String getObjId() {
		return objId;
	}
	public void setObjId(String objId) {
		this.objId = objId;
	}
	public String getPgmId() {
		return pgmId;
	}
	public void setPgmId(String pgmId) {
		this.pgmId = pgmId;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
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
	public String getObjTypeCd() {
		return objTypeCd;
	}
	public void setObjTypeCd(String objTypeCd) {
		this.objTypeCd = objTypeCd;
	}
	public String getUiObjNm() {
		return uiObjNm;
	}
	public void setUiObjNm(String uiObjNm) {
		this.uiObjNm = uiObjNm;
	}
	public String getUiObjDesc() {
		return uiObjDesc;
	}
	public void setUiObjDesc(String uiObjDesc) {
		this.uiObjDesc = uiObjDesc;
	}
	public String getUseFlag() {
		return useFlag;
	}
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
}
