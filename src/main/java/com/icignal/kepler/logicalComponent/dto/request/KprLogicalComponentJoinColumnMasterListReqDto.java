package com.icignal.kepler.logicalComponent.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentJoinColumnMasterListRequestDTO
 * 2. 파일명	: KPRLogicalComponentJoinColumnMasterListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		테이블 관계 노드내 칼럼 마스터 요청  DTO
 * </PRE>
 */ 
public class KprLogicalComponentJoinColumnMasterListReqDto extends CommonDataAuthReqDto {
	
	/** 테이블 마스터 ID */ private String tblMstId;

	public String getTblMstId() {
		return tblMstId;
	}

	public void setTblMstId(String tblMstId) {
		this.tblMstId = tblMstId;
	}
}