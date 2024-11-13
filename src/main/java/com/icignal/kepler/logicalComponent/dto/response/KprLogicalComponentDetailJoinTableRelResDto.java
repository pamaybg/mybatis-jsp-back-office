package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentDetailJoinTableRelResponseDTO
 * 2. 파일명	: KPRLogicalComponentDetailJoinTableRelResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		상세 > 테이블 관계 반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentDetailJoinTableRelResDto extends StatusResDto {

	/** 테이블 관계 ID */	private String 	tblRelId	;
	/** X 좌표 */	private String 	offsetX	;
	/** Y 좌표 */	private String 	offsetY	;
	/** 테이블 ID */	private String 	tblMstId	;
	/** 테이블명 */	private String 	tblMstNm	;
	/** 테이블 스키마명 */	private String 	schmaTblNm	;
	/** 테이블 타입 */	private String 	tblTypeCd	;
	/** 테이블 Alias */	private String 	tblAlias	;
	
	public String getTblRelId() {
		return tblRelId;
	}
	public void setTblRelId(String tblRelId) {
		this.tblRelId = tblRelId;
	}
	public String getOffsetX() {
		return offsetX;
	}
	public void setOffsetX(String offsetX) {
		this.offsetX = offsetX;
	}
	public String getOffsetY() {
		return offsetY;
	}
	public void setOffsetY(String offsetY) {
		this.offsetY = offsetY;
	}
	public String getTblMstId() {
		return tblMstId;
	}
	public void setTblMstId(String tblMstId) {
		this.tblMstId = tblMstId;
	}
	public String getTblMstNm() {
		return tblMstNm;
	}
	public void setTblMstNm(String tblMstNm) {
		this.tblMstNm = tblMstNm;
	}
	public String getSchmaTblNm() {
		return schmaTblNm;
	}
	public void setSchmaTblNm(String schmaTblNm) {
		this.schmaTblNm = schmaTblNm;
	}
	public String getTblTypeCd() {
		return tblTypeCd;
	}
	public void setTblTypeCd(String tblTypeCd) {
		this.tblTypeCd = tblTypeCd;
	}
	public String getTblAlias() {
		return tblAlias;
	}
	public void setTblAlias(String tblAlias) {
		this.tblAlias = tblAlias;
	}

}