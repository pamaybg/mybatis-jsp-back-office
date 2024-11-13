package com.icignal.kepler.logicalComponent.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentJoinAccordionListRequestDTO
 * 2. 파일명	: KPRLogicalComponentJoinAccordionListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		조인설정 > 왼쪽 어코디언 리스트 요청 DTO
 * </PRE>
 */ 
public class KprLogicalComponentJoinAccordionListReqDto extends CommonDataAuthReqDto {

	/** DB 서비스 ID */
	private String dbInformId = "";
	/** 로지컬 컴포넌트 ID */
	private String lgcCompId;
	/* 테이블 ID 리스트 */
	private List<String> tblIdList;

	public String getDbInformId() {
		return dbInformId;
	}

	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}

	public String getLgcCompId() {
		return lgcCompId;
	}

	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}

	public List<String> getTblIdList() {
		return tblIdList;
	}

	public void setTblIdList(List<String> tblIdList) {
		this.tblIdList = tblIdList;
	}
}