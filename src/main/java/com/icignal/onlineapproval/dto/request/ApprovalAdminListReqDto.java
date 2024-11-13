package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
* @name : infavor.marketing.elapproval.dto.request.MKTApprovalAdminListRequestDTO
* @date : 2017. 11. 7.
* @author : 이성원
* @description :
*/
public class ApprovalAdminListReqDto extends CommonDataAuthReqDto{
	private String id;                    //아이디
	private String elecAprvType;
	private String elecAprvTblNm;
	private String ridElecReqTmpl;
	private String elecReqFuncNm;
	private String ridElecAprvTmpl;
	private String elecAprvFuncNm;
	private String ridElecRjtTmpl;
	private String elecRjtFuncNm;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getElecAprvType() {
		return elecAprvType;
	}
	public void setElecAprvType(String elecAprvType) {
		this.elecAprvType = elecAprvType;
	}
	public String getElecAprvTblNm() {
		return elecAprvTblNm;
	}
	public void setElecAprvTblNm(String elecAprvTblNm) {
		this.elecAprvTblNm = elecAprvTblNm;
	}
	public String getRidElecReqTmpl() {
		return ridElecReqTmpl;
	}
	public void setRidElecReqTmpl(String ridElecReqTmpl) {
		this.ridElecReqTmpl = ridElecReqTmpl;
	}
	public String getElecReqFuncNm() {
		return elecReqFuncNm;
	}
	public void setElecReqFuncNm(String elecReqFuncNm) {
		this.elecReqFuncNm = elecReqFuncNm;
	}
	public String getRidElecAprvTmpl() {
		return ridElecAprvTmpl;
	}
	public void setRidElecAprvTmpl(String ridElecAprvTmpl) {
		this.ridElecAprvTmpl = ridElecAprvTmpl;
	}
	public String getElecAprvFuncNm() {
		return elecAprvFuncNm;
	}
	public void setElecAprvFuncNm(String elecAprvFuncNm) {
		this.elecAprvFuncNm = elecAprvFuncNm;
	}
	public String getRidElecRjtTmpl() {
		return ridElecRjtTmpl;
	}
	public void setRidElecRjtTmpl(String ridElecRjtTmpl) {
		this.ridElecRjtTmpl = ridElecRjtTmpl;
	}
	public String getElecRjtFuncNm() {
		return elecRjtFuncNm;
	}
	public void setElecRjtFuncNm(String elecRjtFuncNm) {
		this.elecRjtFuncNm = elecRjtFuncNm;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	

	
	
	
	
}
