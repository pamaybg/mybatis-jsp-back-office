package com.icignal.marketing.common.checker.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;


public class MktNewPermissionResDto extends StatusResDto {
    
	private String targetLevelId;
	private String conId;
	private String conPw;
	private String conClass;
	private String conUrl;
	private String tblSchemaNm;
	private String tblNm;
	private String colNm;
	private String atribVal;
	private String whereVal;
	private String destColNm;
	private String attrib01;
	private String mapCol;
	
	public String getTargetLevelId() {
		return targetLevelId;
	}
	public void setTargetLevelId(String targetLevelId) {
		this.targetLevelId = targetLevelId;
	}
	public String getConId() {
		return conId;
	}
	public void setConId(String conId) {
		this.conId = conId;
	}
	public String getConPw() {
		return conPw;
	}
	public void setConPw(String conPw) {
		this.conPw = conPw;
	}
	public String getConClass() {
		return conClass;
	}
	public void setConClass(String conClass) {
		this.conClass = conClass;
	}
	public String getConUrl() {
		return conUrl;
	}
	public void setConUrl(String conUrl) {
		this.conUrl = conUrl;
	}
	public String getTblSchemaNm() {
		return tblSchemaNm;
	}
	public void setTblSchemaNm(String tblSchemaNm) {
		this.tblSchemaNm = tblSchemaNm;
	}
	public String getTblNm() {
		return tblNm;
	}
	public void setTblNm(String tblNm) {
		this.tblNm = tblNm;
	}
	public String getColNm() {
		return colNm;
	}
	public void setColNm(String colNm) {
		this.colNm = colNm;
	}
	public String getAtribVal() {
		return atribVal;
	}
	public void setAtribVal(String atribVal) {
		this.atribVal = atribVal;
	}
	public String getWhereVal() {
		return whereVal;
	}
	public void setWhereVal(String whereVal) {
		this.whereVal = whereVal;
	}
	public String getDestColNm() {
		return destColNm;
	}
	public void setDestColNm(String destColNm) {
		this.destColNm = destColNm;
	}
	public String getAttrib01() {
		return attrib01;
	}
	public void setAttrib01(String attrib01) {
		this.attrib01 = attrib01;
	}
	public String getMapCol() {
		return mapCol;
	}
	public void setMapCol(String mapCol) {
		this.mapCol = mapCol;
	}
    

}
