package com.icignal.onlineapproval.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


/**
 * @name : MKTElapprovalListResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결제 목록 조회
 */

@CommCode
public class ApprovalAdminListResDto extends GridPagingItemResDto{
	private String id;                    //아이디
	
	@MarkName(groupCode = "APRV_TYPE_CD", codeField = "elecAprvTypeCd")
	private String elecAprvType;
	private String elecAprvTypeCd;
	private String elecAprvTblNm;
	private String ridElecReqTmpl;
	private String elecReqFuncNm;
	private String ridElecAprvTmpl;
	private String elecAprvFuncNm;
	private String ridElecRjtTmpl;
	private String elecRjtFuncNm;
	private String elecReqAutomailId;
	private String elecAprvAutomailId;
	private String elecRjtAutomailId;
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
	public String getElecReqAutomailId() {
		return elecReqAutomailId;
	}
	public void setElecReqAutomailId(String elecReqAutomailId) {
		this.elecReqAutomailId = elecReqAutomailId;
	}
	public String getElecAprvAutomailId() {
		return elecAprvAutomailId;
	}
	public void setElecAprvAutomailId(String elecAprvAutomailId) {
		this.elecAprvAutomailId = elecAprvAutomailId;
	}
	public String getElecRjtAutomailId() {
		return elecRjtAutomailId;
	}
	public void setElecRjtAutomailId(String elecRjtAutomailId) {
		this.elecRjtAutomailId = elecRjtAutomailId;
	}
	public String getElecAprvTypeCd() {
		return elecAprvTypeCd;
	}
	public void setElecAprvTypeCd(String elecAprvTypeCd) {
		this.elecAprvTypeCd = elecAprvTypeCd;
	}
	
	

}
