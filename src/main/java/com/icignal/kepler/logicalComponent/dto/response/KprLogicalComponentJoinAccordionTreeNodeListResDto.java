package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentJoinAccordionTreeNodeListResponseDTO
 * 2. 파일명	: KPRLogicalComponentJoinAccordionTreeNodeListResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명	
 *		조인설정 > 왼쪽 어코디언 트리 노드 반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentJoinAccordionTreeNodeListResDto extends StatusResDto {

	/**    NodeId    */ private String id;
	/**    Node Parent Id    */ private String parentId;
	/**    NodeName    */ private String text;
	/**    자식노드 허용여부    */ private boolean hasChild;
	/**    확장여부    */ private boolean expanded;
	/**    테이블타입    */ private String tblTypeCd;
	/**    스키마 테이블명   */ private String schmaTblNm;
	/**    노드 타입 */ private String colType;
	
	public String getColType() {
		return colType;
	}
	public void setColType(String colType) {
		this.colType = colType;
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
	public String getTblTypeCd() {
		return tblTypeCd;
	}
	public void setTblTypeCd(String tblTypeCd) {
		this.tblTypeCd = tblTypeCd;
	}
	public String getSchmaTblNm() {
		return schmaTblNm;
	}
	public void setSchmaTblNm(String schmaTblNm) {
		this.schmaTblNm = schmaTblNm;
	}
	
}