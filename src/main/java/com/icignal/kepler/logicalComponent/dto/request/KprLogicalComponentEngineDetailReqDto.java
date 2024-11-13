package com.icignal.kepler.logicalComponent.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentEngineDetailRequestDTO
 * 2. 파일명	: KPRLogicalComponentEngineDetailRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 이기오
 * 5. 작성일자	: 2018. 4. 11.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprLogicalComponentEngineDetailReqDto extends MKTBaseReqDto {
	/* 컬럼 추가 여부 */
	private Boolean apdColFlag;

	/* 로지컬 컴포넌트 ID */
	private String lgcCompId;

	/* 로지컬 컴포넌트 - 테이블 관계 ID */
	private String tblRelId;

	/* 스키마 테이블명 */
	private String schmaTblNm;

	public Boolean getApdColFlag() {
		return apdColFlag;
	}

	public void setApdColFlag(Boolean apdColFlag) {
		this.apdColFlag = apdColFlag;
	}

	public String getLgcCompId() {
		return lgcCompId;
	}

	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}

	public String getTblRelId() {
		return tblRelId;
	}

	public void setTblRelId(String tblRelId) {
		this.tblRelId = tblRelId;
	}

	public String getSchmaTblNm() {
		return schmaTblNm;
	}

	public void setSchmaTblNm(String schmaTblNm) {
		this.schmaTblNm = schmaTblNm;
	}
}