package com.icignal.kepler.logicalComponent.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentAttributeGroupLeftAccordionListResponseDTO
 * 2. 파일명	: KPRLogicalComponentAttributeGroupLeftAccordionListResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		어트리뷰트 그룹 설정 > 왼쪽 어코디언 리스트 반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentAttributeGroupLeftAccordionListResDto extends StatusResDto {

	/** 로지컬 컴포넌트 테이블 관계 ID */
	private String id;
	/** 테이블 마스터 디스플레이명 */
	private String text;
	/** 테이블 마스터 ID */
	private String tblMstId;
	/** 테이블 관계 ID */
	private String lgcCompTblRelId;
	/** 테이블 마스터 Alias */
	private String tblAlias;
	/** 테이블명 && Alias */
	private String tblNmAlias;
	private String tblTypeCd;

	private List<KprLogicalComponentAttributeGroupLeftAccordionTreeNodeListResDto> treeList;

	public String getTblNmAlias() {
		return tblNmAlias;
	}

	public void setTblNmAlias(String tblNmAlias) {
		this.tblNmAlias = tblNmAlias;
	}

	public String getLgcCompTblRelId() {
		return lgcCompTblRelId;
	}

	public void setLgcCompTblRelId(String lgcCompTblRelId) {
		this.lgcCompTblRelId = lgcCompTblRelId;
	}

	public String getTblAlias() {
		return tblAlias;
	}

	public void setTblAlias(String tblAlias) {
		this.tblAlias = tblAlias;
	}

	public String getTblMstId() {
		return tblMstId;
	}

	public void setTblMstId(String tblMstId) {
		this.tblMstId = tblMstId;
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

	public List<KprLogicalComponentAttributeGroupLeftAccordionTreeNodeListResDto> getTreeList() {
		return treeList;
	}

	public void setTreeList(List<KprLogicalComponentAttributeGroupLeftAccordionTreeNodeListResDto> treeList) {
		this.treeList = treeList;
	}

	public String getTblTypeCd() {
		return tblTypeCd;
	}

	public void setTblTypeCd(String tblTypeCd) {
		this.tblTypeCd = tblTypeCd;
	}

}