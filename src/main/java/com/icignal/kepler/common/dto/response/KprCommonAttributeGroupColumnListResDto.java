package com.icignal.kepler.common.dto.response;

/*
 * 1. 클래스명	: KPRCommonAttributeGroupColumnListResponseDTO
 * 2. 파일명	: KPRCommonAttributeGroupColumnListResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.response
 * 4. 작성자명	: 류동균
 * 5. 작성일자	: 2016. 6. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *		속성그룹컬럼 목록 ResponseDTO
 * </PRE>
 */ 
public class KprCommonAttributeGroupColumnListResDto  {

	private String id; // 어트리뷰트그룹컬럼 아이디
	private String text; // 어트리뷰트그룹컬럼명;
	private String parentId; // 트리 상위 아이디
	private String colType; // 컬럼 유형
	private String atribGroupColId;

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

	public String getColType() {
		return colType;
	}

	public void setColType(String colType) {
		this.colType = colType;
	}

	public String getAtribGroupColId() {
		return atribGroupColId;
	}

	public void setAtribGroupColId(String atribGroupColId) {
		this.atribGroupColId = atribGroupColId;
	}
}