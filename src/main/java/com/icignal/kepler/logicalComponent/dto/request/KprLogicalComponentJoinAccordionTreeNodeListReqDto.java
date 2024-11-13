package com.icignal.kepler.logicalComponent.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentJoinAccordionTreeNodeListRequestDTO
 * 2. 파일명	: KPRLogicalComponentJoinAccordionTreeNodeListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		조인설정 > 왼쪽 어코디언 트리 리스트 요청 DTO
 * </PRE>
 */ 
public class KprLogicalComponentJoinAccordionTreeNodeListReqDto extends CommonDataAuthReqDto {

	/** DB ID */
	private String dbInformId;
	/** 테이블 타입 ID */
	private String tblTypeCdId;

	/** 테이블 ID 리스트 */
	private List<String> tblIdList;

	public String getDbInformId() {
		return dbInformId;
	}

	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}

	public String getTblTypeCdId() {
		return tblTypeCdId;
	}

	public void setTblTypeCdId(String tblTypeCdId) {
		this.tblTypeCdId = tblTypeCdId;
	}

	public List<String> getTblIdList() {
		return tblIdList;
	}

	public void setTblIdList(List<String> tblIdList) {
		this.tblIdList = tblIdList;
	}
}