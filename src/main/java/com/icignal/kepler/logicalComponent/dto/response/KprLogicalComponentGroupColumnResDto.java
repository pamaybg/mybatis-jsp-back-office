package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentGroupColumnResponseDTO
 * 2. 파일명	: KPRLogicalComponentGroupColumnResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 이기오
 * 5. 작성일자	: 2018. 4. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprLogicalComponentGroupColumnResDto extends StatusResDto {
	private String grpColId;
	private String colId;
	private String colDpNm;
	private String grpFuncTypeCd;

	public String getGrpColId() {
		return grpColId;
	}

	public void setGrpColId(String grpColId) {
		this.grpColId = grpColId;
	}

	public String getColId() {
		return colId;
	}

	public void setColId(String colId) {
		this.colId = colId;
	}

	public String getColDpNm() {
		return colDpNm;
	}

	public void setColDpNm(String colDpNm) {
		this.colDpNm = colDpNm;
	}

	public String getGrpFuncTypeCd() {
		return grpFuncTypeCd;
	}

	public void setGrpFuncTypeCd(String grpFuncTypeCd) {
		this.grpFuncTypeCd = grpFuncTypeCd;
	}
}