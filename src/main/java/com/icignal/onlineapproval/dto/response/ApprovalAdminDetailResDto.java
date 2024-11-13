package com.icignal.onlineapproval.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : MKTElapprovalDetailResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결제 상세 정보 조회
 */
public class ApprovalAdminDetailResDto extends GridPagingItemResDto{
	private String id;     			   //아이디
	private String elecAprvType;
	private String elecAprvTblNm;	
	private String ridElecReqTmpl;
	private String elecReqTmpl;
	private String ridElecAprvTmpl;
	private String elecAprvTmpl;
	private String ridElecRjtTmpl;
	private String elecRjtTmpl;
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
	public String getElecReqTmpl() {
		return elecReqTmpl;
	}
	public void setElecReqTmpl(String elecReqTmpl) {
		this.elecReqTmpl = elecReqTmpl;
	}
	public String getElecAprvTmpl() {
		return elecAprvTmpl;
	}
	public void setElecAprvTmpl(String elecAprvTmpl) {
		this.elecAprvTmpl = elecAprvTmpl;
	}
	public String getElecRjtTmpl() {
		return elecRjtTmpl;
	}
	public void setElecRjtTmpl(String elecRjtTmpl) {
		this.elecRjtTmpl = elecRjtTmpl;
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
