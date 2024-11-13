package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentAttributeGroupLeftAccordionTreeNodeListResponseDTO
 * 2. 파일명	: KPRLogicalComponentAttributeGroupLeftAccordionTreeNodeListResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		어트리뷰트 그룹 설정 > 왼쪽 어코디언 트리 리스트  반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentAttributeGroupLeftAccordionTreeNodeListResDto extends StatusResDto {

	/**    NodeId    */ private String id;
	/**    NodeName    */ private String text;
	/**    자식노드 허용여부    */ private boolean hasChild;
	/**    확장여부    */ private boolean expanded;
	
	/**    테이블 관계 ID   */ private String lgcCompTblRelId;
	/**    테이블 Alias.ColumnName   */ private String tblAliasColNm;
	/**    Column Master Id   */ private String colId;
	/**    Dimension Column Id */ private String dimColId;
	/**    Column Type Code */ private String colTypeCd;
	
	public String getColTypeCd() {
		return colTypeCd;
	}
	public void setColTypeCd(String colTypeCd) {
		this.colTypeCd = colTypeCd;
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
	public String getLgcCompTblRelId() {
		return lgcCompTblRelId;
	}
	public void setLgcCompTblRelId(String lgcCompTblRelId) {
		this.lgcCompTblRelId = lgcCompTblRelId;
	}
	public String getTblAliasColNm() {
		return tblAliasColNm;
	}
	public void setTblAliasColNm(String tblAliasColNm) {
		this.tblAliasColNm = tblAliasColNm;
	}
	public String getColId() {
		return colId;
	}
	public void setColId(String colId) {
		this.colId = colId;
	}
	public String getDimColId() {
		return dimColId;
	}
	public void setDimColId(String dimColId) {
		this.dimColId = dimColId;
	}
	
}