package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;



/**
 * @name : MKTElapprovalDetailRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결제 상세 조회
 */
public class ApprovalAdminDetailReqDto extends CommonDataAuthReqDto{
	private String id;     			   //아이디
	private String elecAprvType;
	private String elecAprvTblNm;	
	private String ridElecReqTmpl;
	private String ridElecAprvTmpl;
	private String ridElecRjtTmpl;
	private String elecReqFuncNm;
	private String elecAprvFuncNm;
	private String elecRjtFuncNm;
	private String elecReqAutomailId;
	private String elecAprvAutomailId;
	private String elecRjtAutomailId;
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
	public String getRidElecAprvTmpl() {
		return ridElecAprvTmpl;
	}
	public void setRidElecAprvTmpl(String ridElecAprvTmpl) {
		this.ridElecAprvTmpl = ridElecAprvTmpl;
	}
	public String getRidElecRjtTmpl() {
		return ridElecRjtTmpl;
	}
	public void setRidElecRjtTmpl(String ridElecRjtTmpl) {
		this.ridElecRjtTmpl = ridElecRjtTmpl;
	}
	public String getElecReqFuncNm() {
		return elecReqFuncNm;
	}
	public void setElecReqFuncNm(String elecReqFuncNm) {
		this.elecReqFuncNm = elecReqFuncNm;
	}
	public String getElecAprvFuncNm() {
		return elecAprvFuncNm;
	}
	public void setElecAprvFuncNm(String elecAprvFuncNm) {
		this.elecAprvFuncNm = elecAprvFuncNm;
	}
	public String getElecRjtFuncNm() {
		return elecRjtFuncNm;
	}
	public void setElecRjtFuncNm(String elecRjtFuncNm) {
		this.elecRjtFuncNm = elecRjtFuncNm;
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
	

	
	
	
}
