package com.icignal.onlineapproval.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;


/**
* @name : infavor.marketing.elapproval.dto.response.MKTCommonReqApprovalValidResponseDTO
* @date : 2017. 11. 3.
* @author : 이성원
* @description :
*/
public class CommonReqApprovalMstInfoResDto extends GridPagingItemResDto{
	private Boolean aprvTypeSuc;   	//승인업무유형 (공통코드 : APRV_TYPE_CD)	

	private Boolean reqRidSuc;		//승인요청자 RID

	private Boolean fstRidSuc;		//1차 승인자 RID

	private Boolean secRidSuc;		//2차 승인자 RID 

	private Boolean recordRidSuc;	//요청건의 RID
	
	
	private String reqEmail;		 
	private String fstEmail;		 
	private String secEmail;		 
	
	
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

	

	public Boolean getAprvTypeSuc() {
		return aprvTypeSuc;
	}

	public void setAprvTypeSuc(Boolean aprvTypeSuc) {
		this.aprvTypeSuc = aprvTypeSuc;
	}

	public Boolean getReqRidSuc() {
		return reqRidSuc;
	}

	public void setReqRidSuc(Boolean reqRidSuc) {
		this.reqRidSuc = reqRidSuc;
	}

	public Boolean getFstRidSuc() {
		return fstRidSuc;
	}

	public void setFstRidSuc(Boolean fstRidSuc) {
		this.fstRidSuc = fstRidSuc;
	}

	public Boolean getSecRidSuc() {
		return secRidSuc;
	}

	public void setSecRidSuc(Boolean secRidSuc) {
		this.secRidSuc = secRidSuc;
	}

	public Boolean getRecordRidSuc() {
		return recordRidSuc;
	}

	public void setRecordRidSuc(Boolean recordRidSuc) {
		this.recordRidSuc = recordRidSuc;
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

	public String getReqEmail() {
		return reqEmail;
	}

	public void setReqEmail(String reqEmail) {
		this.reqEmail = reqEmail;
	}

	public String getFstEmail() {
		return fstEmail;
	}

	public void setFstEmail(String fstEmail) {
		this.fstEmail = fstEmail;
	}

	public String getSecEmail() {
		return secEmail;
	}

	public void setSecEmail(String secEmail) {
		this.secEmail = secEmail;
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
