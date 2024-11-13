package com.icignal.systemmanagement.object.dto.response;

import com.icignal.common.base.dto.request.BaseReqDto;

public class SystemGetUIObjectDetailResDto extends BaseReqDto {
	
	private String id;
	private String objTypeCd;
	private String objCd;
	private String objId;
	private String uiObjNm;
	private String uiObjDesc;
	private String createBy;
	private String createDate;
	private String modifyBy;
	private String modifyDate;
	private String useFlag;
	
	private String empId;

	
	public String getUseFlag() {
		return useFlag;
	}
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
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
	public String getObjCd() {
		return objCd;
	}
	public void setObjCd(String objCd) {
		this.objCd = objCd;
	}
	public String getObjId() {
		return objId;
	}
	public void setObjId(String objId) {
		this.objId = objId;
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
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
}
