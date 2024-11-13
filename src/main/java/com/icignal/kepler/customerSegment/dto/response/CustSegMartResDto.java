package com.icignal.kepler.customerSegment.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class CustSegMartResDto extends GridPagingItemResDto {
	
	private String rid; 
	private String createDate;
	private String createBy;
	private String modifyBy;
	private String modifyDate;
	private String csegHadId; 
	private String csegMtNm; //고객 세분화 마트 항목 
	
	private String csegMtTypeCd;
	private String csegMtTypeNm;  //유형
	
	private String csegMtStatusCd;

	@MarkName(groupCode = "ANL_CSEG_MT_STATUS_CD", codeField = "csegMtStatusCd")
	private String csegMtStatusNm; //상태

	// 릴레이션
	private String aplyStartDd; //적용 시작시간
	private String aplyEendDd;  //적용 종료 시간
	
	private String csegMtCyclTypeCd; //배치주기 

	@MarkName(groupCode = "ANL_CSEG_MT_CYCL_TYPE_CD", codeField = "csegMtCyclTypeCd")
	private String csegMtCyclTypeNm;

	private String csegMtInfoDesc;    //설명
	
	private String sql;						//고객 세분화 마트 항목을 생성시키는 SQL 문
	private String lgcCompId;  			//logical component Id
	private String lgcCompNm; 
	private String lgcCompTblIntId;  //logical component 그룹 Id
	private String lgcCompTblIntNm;
	private String colId; 					////logical component 항목 Id
	private String colNm; 	
	private String dpNm;
	private String tblAliasColNm;
	private String seq;
	private String seqCreate;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getCsegMtNm() {
		return csegMtNm;
	}
	public void setCsegMtNm(String csegMtNm) {
		this.csegMtNm = csegMtNm;
	}
	public String getCsegMtTypeNm() {
		return csegMtTypeNm;
	}
	public void setCsegMtTypeNm(String csegMtTypeNm) {
		this.csegMtTypeNm = csegMtTypeNm;
	}
	public String getCsegMtStatusNm() {
		return csegMtStatusNm;
	}
	public void setCsegMtStatusNm(String csegMtStatusNm) {
		this.csegMtStatusNm = csegMtStatusNm;
	}
	public String getAplyStartDd() {
		return aplyStartDd;
	}
	public void setAplyStartDd(String aplyStartDd) {
		this.aplyStartDd = aplyStartDd;
	}
	
	public String getCsegMtTypeCd() {
		return csegMtTypeCd;
	}
	public void setCsegMtTypeCd(String csegMtTypeCd) {
		this.csegMtTypeCd = csegMtTypeCd;
	}
	public String getCsegMtStatusCd() {
		return csegMtStatusCd;
	}
	public void setCsegMtStatusCd(String csegMtStatusCd) {
		this.csegMtStatusCd = csegMtStatusCd;
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
	public String getCsegHadId() {
		return csegHadId;
	}
	public void setCsegHadId(String csegHadId) {
		this.csegHadId = csegHadId;
	}
	public String getAplyEendDd() {
		return aplyEendDd;
	}
	public void setAplyEendDd(String aplyEendDd) {
		this.aplyEendDd = aplyEendDd;
	}
	public String getCsegMtCyclTypeCd() {
		return csegMtCyclTypeCd;
	}
	public void setCsegMtCyclTypeCd(String csegMtCyclTypeCd) {
		this.csegMtCyclTypeCd = csegMtCyclTypeCd;
	}
	public String getCsegMtInfoDesc() {
		return csegMtInfoDesc;
	}
	public void setCsegMtInfoDesc(String csegMtInfoDesc) {
		this.csegMtInfoDesc = csegMtInfoDesc;
	}
	public String getSql() {
		return sql;
	}
	public void setSql(String sql) {
		this.sql = sql;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getLgcCompId() {
		return lgcCompId;
	}
	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}
	public String getLgcCompTblIntId() {
		return lgcCompTblIntId;
	}
	public void setLgcCompTblIntId(String lgcCompTblIntId) {
		this.lgcCompTblIntId = lgcCompTblIntId;
	}
	public String getColId() {
		return colId;
	}
	public void setColId(String colId) {
		this.colId = colId;
	}
	public String getCsegMtCyclTypeNm() {
		return csegMtCyclTypeNm;
	}
	public void setCsegMtCyclTypeNm(String csegMtCyclTypeNm) {
		this.csegMtCyclTypeNm = csegMtCyclTypeNm;
	}
	public String getLgcCompNm() {
		return lgcCompNm;
	}
	public void setLgcCompNm(String lgcCompNm) {
		this.lgcCompNm = lgcCompNm;
	}
	public String getLgcCompTblIntNm() {
		return lgcCompTblIntNm;
	}
	public void setLgcCompTblIntNm(String lgcCompTblIntNm) {
		this.lgcCompTblIntNm = lgcCompTblIntNm;
	}
	public String getColNm() {
		return colNm;
	}
	public void setColNm(String colNm) {
		this.colNm = colNm;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getTblAliasColNm() {
		return tblAliasColNm;
	}
	public void setTblAliasColNm(String tblAliasColNm) {
		this.tblAliasColNm = tblAliasColNm;
	}
	public String getDpNm() {
		return dpNm;
	}
	public void setDpNm(String dpNm) {
		this.dpNm = dpNm;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getSeqCreate() {
		return seqCreate;
	}
	public void setSeqCreate(String seqCreate) {
		this.seqCreate = seqCreate;
	}
}
