package com.icignal.kepler.targetGroup.targetSimple.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class KprGetTargetSimpleListResDto extends StatusResDto {
	
	private String id;
	private String text; 
	private String parentId; 
	private String hasChild; 
	private String expanded; 
	private String colType; 
	private String attributeGroupColumnId; 
	private String tempAttributeGroupColumnId; 
	private String lgcCompTblRelId; 
	private String seq; 
	private String colId; 
	private String colAlias; 
	private String dpNm; 
	private String dimColId; 
	private String calColYn; 
	private String calDtlHis;
	private String tblAliasColNm;
	private String atribGroupId;
	private String segKeyYn;
	private String dateKeyYn;
	private String evtTriggerKeyYn;
	private String sqlValue;
	private String dataTypeCd;
	private String inputType;
	
	
	public String getDataTypeCd() {
		return dataTypeCd;
	}
	public void setDataTypeCd(String dataTypeCd) {
		this.dataTypeCd = dataTypeCd;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getHasChild() {
		return hasChild;
	}
	public void setHasChild(String hasChild) {
		this.hasChild = hasChild;
	}
	public String getExpanded() {
		return expanded;
	}
	public void setExpanded(String expanded) {
		this.expanded = expanded;
	}
	public String getColType() {
		return colType;
	}
	public void setColType(String colType) {
		this.colType = colType;
	}
	public String getAttributeGroupColumnId() {
		return attributeGroupColumnId;
	}
	public void setAttributeGroupColumnId(String attributeGroupColumnId) {
		this.attributeGroupColumnId = attributeGroupColumnId;
	}
	public String getTempAttributeGroupColumnId() {
		return tempAttributeGroupColumnId;
	}
	public void setTempAttributeGroupColumnId(String tempAttributeGroupColumnId) {
		this.tempAttributeGroupColumnId = tempAttributeGroupColumnId;
	}
	public String getLgcCompTblRelId() {
		return lgcCompTblRelId;
	}
	public void setLgcCompTblRelId(String lgcCompTblRelId) {
		this.lgcCompTblRelId = lgcCompTblRelId;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getColId() {
		return colId;
	}
	public void setColId(String colId) {
		this.colId = colId;
	}
	public String getColAlias() {
		return colAlias;
	}
	public void setColAlias(String colAlias) {
		this.colAlias = colAlias;
	}
	public String getDpNm() {
		return dpNm;
	}
	public void setDpNm(String dpNm) {
		this.dpNm = dpNm;
	}
	public String getDimColId() {
		return dimColId;
	}
	public void setDimColId(String dimColId) {
		this.dimColId = dimColId;
	}
	public String getCalColYn() {
		return calColYn;
	}
	public void setCalColYn(String calColYn) {
		this.calColYn = calColYn;
	}
	public String getCalDtlHis() {
		return calDtlHis;
	}
	public void setCalDtlHis(String calDtlHis) {
		this.calDtlHis = calDtlHis;
	}
	public String getTblAliasColNm() {
		return tblAliasColNm;
	}
	public void setTblAliasColNm(String tblAliasColNm) {
		this.tblAliasColNm = tblAliasColNm;
	}
	public String getAtribGroupId() {
		return atribGroupId;
	}
	public void setAtribGroupId(String atribGroupId) {
		this.atribGroupId = atribGroupId;
	}
	public String getSegKeyYn() {
		return segKeyYn;
	}
	public void setSegKeyYn(String segKeyYn) {
		this.segKeyYn = segKeyYn;
	}
	public String getDateKeyYn() {
		return dateKeyYn;
	}
	public void setDateKeyYn(String dateKeyYn) {
		this.dateKeyYn = dateKeyYn;
	}
	public String getEvtTriggerKeyYn() {
		return evtTriggerKeyYn;
	}
	public void setEvtTriggerKeyYn(String evtTriggerKeyYn) {
		this.evtTriggerKeyYn = evtTriggerKeyYn;
	}
	public String getSqlValue() {
		return sqlValue;
	}
	public void setSqlValue(String sqlValue) {
		this.sqlValue = sqlValue;
	}

	public String getInputType() {
		return inputType;
	}

	public void setInputType(String inputType) {
		this.inputType = inputType;
	}
}
