package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : MKTElapprovalUpdateRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결제 업데이트
 */
public class ApprovalUpdateReqDto extends CommonDataAuthReqDto{
	private String id;
	private String memId;
	private String elecAprvTypeCd;
	private String elecAprvDivCd;
	private String camId;
	private String elecAprvTitle;
	private String elecAprvSbst; 
	private String elecAprvStatusCd; 
	private String elecAprvRqtrOrgId; 
	private String elecAprvCmpltRqtDd;
	private String lastApvDd;
	private String lastApvrId;
	private String elecAprvDesc;
	private String elecAprvRqtrId;
	private String aprvType;
	private String recordRid;

	private String apvrId;
	private String dataVal;
	
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getElecAprvTypeCd() {
		return elecAprvTypeCd;
	}
	public void setElecAprvTypeCd(String elecAprvTypeCd) {
		this.elecAprvTypeCd = elecAprvTypeCd;
	}
	public String getElecAprvDivCd() {
		return elecAprvDivCd;
	}
	public void setElecAprvDivCd(String elecAprvDivCd) {
		this.elecAprvDivCd = elecAprvDivCd;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getElecAprvTitle() {
		return elecAprvTitle;
	}
	public void setElecAprvTitle(String elecAprvTitle) {
		this.elecAprvTitle = elecAprvTitle;
	}
	public String getElecAprvSbst() {
		return elecAprvSbst;
	}
	public void setElecAprvSbst(String elecAprvSbst) {
		this.elecAprvSbst = elecAprvSbst;
	}
	public String getElecAprvStatusCd() {
		return elecAprvStatusCd;
	}
	public void setElecAprvStatusCd(String elecAprvStatusCd) {
		this.elecAprvStatusCd = elecAprvStatusCd;
	}
	public String getElecAprvRqtrOrgId() {
		return elecAprvRqtrOrgId;
	}
	public void setElecAprvRqtrOrgId(String elecAprvRqtrOrgId) {
		this.elecAprvRqtrOrgId = elecAprvRqtrOrgId;
	}
	public String getElecAprvCmpltRqtDd() {
		return elecAprvCmpltRqtDd;
	}
	public void setElecAprvCmpltRqtDd(String elecAprvCmpltRqtDd) {
		this.elecAprvCmpltRqtDd = elecAprvCmpltRqtDd;
	}
	public String getLastApvDd() {
		return lastApvDd;
	}
	public void setLastApvDd(String lastApvDd) {
		this.lastApvDd = lastApvDd;
	}
	public String getLastApvrId() {
		return lastApvrId;
	}
	public void setLastApvrId(String lastApvrId) {
		this.lastApvrId = lastApvrId;
	}
	public String getElecAprvDesc() {
		return elecAprvDesc;
	}
	public void setElecAprvDesc(String elecAprvDesc) {
		this.elecAprvDesc = elecAprvDesc;
	}
	public String getElecAprvRqtrId() {
		return elecAprvRqtrId;
	}
	public void setElecAprvRqtrId(String elecAprvRqtrId) {
		this.elecAprvRqtrId = elecAprvRqtrId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAprvType() {
		return aprvType;
	}
	public void setAprvType(String aprvType) {
		this.aprvType = aprvType;
	}
	public String getRecordRid() {
		return recordRid;
	}
	public void setRecordRid(String recordRid) {
		this.recordRid = recordRid;
	}

	public String getApvrId() {return apvrId;}
	public void setApvrId(String apvrId) {this.apvrId = apvrId;}
	public String getDataVal() {return dataVal;}
	public void setDataVal(String dataVal) {this.dataVal = dataVal;}
}
