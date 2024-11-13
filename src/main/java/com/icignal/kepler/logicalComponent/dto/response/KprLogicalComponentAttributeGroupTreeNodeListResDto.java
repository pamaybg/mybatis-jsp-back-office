package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentAttributeGroupTreeNodeListResponseDTO
 * 2. 파일명	: KPRLogicalComponentAttributeGroupTreeNodeListResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		어트리뷰트 그룹 트리 노드 반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentAttributeGroupTreeNodeListResDto extends StatusResDto {

    /** NodeId */
    private String id;
    /** Node Parent Id */
    private String parentId;
    /** NodeName */
    private String text;
    /** 자식노드 허용여부 */
    private boolean hasChild;
    /** 확장여부 */
    private boolean expanded;
    /** 노드 타입 */
    private String colType;

    /** 아이디 */
    private String attributeGroupColumnId = "";
    /** 아이디 */
    private String tempAttributeGroupColumnId = "";
    /** 컬럼 순서 Attribute Group별 순서 */
    private String seq = "";
    /** 로지컬컴포넌트 테이블 REL ID */
    private String lgcCompTblRelId = "";
    /** 컬럼 ID */
    private String colId = "";
    /** 디스플레이명(한글컬럼명) */
    private String dpNm = "";
    /** 디멘전컬럼 ID */
    private String dimColId = "";
    /** 변환식 한글테이블명,필드명으로 구성 ex) 구매테이블2.상품수/구매테이블2.구매횟수 */
    private String calDtl = "";
    /** Cal Dtl을 만들 때 화면에서 사용하던 Buffer */
    private String calDtlHis = "";
    /**
     * 테이블 ALIAS+컬럼명 1. 변환필드가 아닐 때,--->영문테이블Alias,컬럼명 ex) T1.컬럼명 2. 변환필드 일 때, ---> 변환식(영문테이블Alias,컬럼명으로 구성) ex) T1.컬럼명1/T2.컬럼명2
     */
    private String tblAliasColNm = "";
    /** 변환필드여부 */
    private String calColYn = "";
    /** 어트리뷰트그룹 ID */
    private String atribGroupId = "";
    /** 세그먼트키여부 */
    private String segKeyYn = "";
    /** 이벤트트리거 키 여부 */
    private String evtTriggerKeyYn = "";
    /** 로지컬 컴포넌트 ID */
    private String lgcCompId = "";
    /** 해당 컬럼의 유니크 Alias */
    private String colAlias = "";

    /** 기준 날짜 YN */
    private String dateKeyYn = "";
    /** 선택형 query */
    private String sqlValue="";

    
	public String getSqlValue() {
		return sqlValue;
	}
	public void setSqlValue(String sqlValue) {
		this.sqlValue = sqlValue;
	}
	public String getEvtTriggerKeyYn() {
        return evtTriggerKeyYn;
    }
    public void setEvtTriggerKeyYn(String evtTriggerKeyYn) {
        this.evtTriggerKeyYn = evtTriggerKeyYn;
    }
    public String getDateKeyYn() {
		return dateKeyYn;
	}
	public void setDateKeyYn(String dateKeyYn) {
		this.dateKeyYn = dateKeyYn;
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
	public String getColId() {
		return colId;
	}
	public void setColId(String colId) {
		this.colId = colId;
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
	public String getCalDtl() {
		return calDtl;
	}
	public void setCalDtl(String calDtl) {
		this.calDtl = calDtl;
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
	public String getCalColYn() {
		return calColYn;
	}
	public void setCalColYn(String calColYn) {
		this.calColYn = calColYn;
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
	public String getLgcCompId() {
		return lgcCompId;
	}
	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}
	public String getColAlias() {
		return colAlias;
	}
	public void setColAlias(String colAlias) {
		this.colAlias = colAlias;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public boolean isHasChild() {
		return hasChild;
	}
	public void setHasChild(boolean hasChild) {
		this.hasChild = hasChild;
	}
	public boolean isExpanded() {
		return expanded;
	}
	public void setExpanded(boolean expanded) {
		this.expanded = expanded;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getColType() {
		return colType;
	}
	public void setColType(String colType) {
		this.colType = colType;
	}
	
}