package com.icignal.kepler.logicalComponent.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentAttributeGroupLeftAccordionTreeNodeListRequestDTO
 * 2. 파일명	: KPRLogicalComponentAttributeGroupLeftAccordionTreeNodeListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		어트리뷰트 그룹 설정 > 왼쪽 어코디언 트리 리스트 조회 요청 DTO
 * </PRE>
 */ 
public class KprLogicalComponentAttributeGroupLeftAccordionTreeNodeListReqDto extends CommonDataAuthReqDto {

	/** 테이블 마스터 ID */
	private String tblMstId;
	/** 테이블 관계 ID */
	private String lgcCompTblRelId;
	/** 테이블 관계 Alias */
	private String tblAlias;
	private String lgcCompId;
	private Boolean grpFlag;

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

	public String getLgcCompId() {
		return lgcCompId;
	}

	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}

	public Boolean getGrpFlag() {
		return grpFlag;
	}

	public void setGrpFlag(Boolean grpFlag) {
		this.grpFlag = grpFlag;
	}

}
