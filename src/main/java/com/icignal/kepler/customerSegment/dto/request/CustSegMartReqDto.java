package com.icignal.kepler.customerSegment.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class CustSegMartReqDto extends CommonDataAuthReqDto {


	private String rid;
	private String lgcCompId;
	private String lgcCompTblIntId;
	private String lgcCompTblIntNm;
	private String colId;
	private String csegMtNm;
	private String csegMtStatusCd;
	private String csegMtCyclTypeCd;
	private String aplyStartDd;
	private String aplyEendDd;
	private String csegMtInfoDesc;
	private String sql;
	private String logCompGrId;
	private String tblAliasColNm;
	private String dupChk;
	
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

	public String getCsegMtNm() {
		return csegMtNm;
	}

	public void setCsegMtNm(String csegMtNm) {
		this.csegMtNm = csegMtNm;
	}

	public String getCsegMtStatusCd() {
		return csegMtStatusCd;
	}

	public void setCsegMtStatusCd(String csegMtStatusCd) {
		this.csegMtStatusCd = csegMtStatusCd;
	}

	public String getCsegMtCyclTypeCd() {
		return csegMtCyclTypeCd;
	}

	public void setCsegMtCyclTypeCd(String csegMtCyclTypeCd) {
		this.csegMtCyclTypeCd = csegMtCyclTypeCd;
	}

	public String getAplyStartDd() {
		return aplyStartDd;
	}

	public void setAplyStartDd(String aplyStartDd) {
		this.aplyStartDd = aplyStartDd;
	}

	public String getAplyEendDd() {
		return aplyEendDd;
	}

	public void setAplyEendDd(String aplyEendDd) {
		this.aplyEendDd = aplyEendDd;
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

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getLogCompGrId() {
		return logCompGrId;
	}

	public void setLogCompGrId(String logCompGrId) {
		this.logCompGrId = logCompGrId;
	}

	public String getLgcCompTblIntNm() {
		return lgcCompTblIntNm;
	}

	public void setLgcCompTblIntNm(String lgcCompTblIntNm) {
		this.lgcCompTblIntNm = lgcCompTblIntNm;
	}

	public String getTblAliasColNm() {
		return tblAliasColNm;
	}

	public void setTblAliasColNm(String tblAliasColNm) {
		this.tblAliasColNm = tblAliasColNm;
	}

	public String getDupChk() {
		return dupChk;
	}

	public void setDupChk(String dupChk) {
		this.dupChk = dupChk;
	}


}
