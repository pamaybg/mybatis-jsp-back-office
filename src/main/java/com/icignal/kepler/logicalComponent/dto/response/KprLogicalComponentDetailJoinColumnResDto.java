package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentDetailJoinColumnResponseDTO
 * 2. 파일명	: KPRLogicalComponentDetailJoinColumnResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		 상세 > 조인 칼럼 반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentDetailJoinColumnResDto extends StatusResDto {

	/** 조인 컬럼 ID */	private String 	joinColumnId	;
	/** 임시 조인 컬럼 ID */	private String 	tempJoinColumnId	;
	/** 순번 */	private String 	seq	;
	/** 조인 타입 코드 */	private String 	joinTypeCd	;
	/** 왼쪽 테이블 관계 ID */	private String 	leftLgcCompTblRelId	;
	/** 왼쪽 칼럼 ID */	private String 	leftColId	;
	/** 왼쪽 테이블 Alias 칼럼명 */	private String 	leftTblAliasColNm	;
	/** 조인 관계 코드 */	private String 	joinOprtCd	;
	/** 오른쪽 테이블 관계 ID */	private String 	rightLgcCompTblRelId	;
	/** 오른쪽 칼럼 ID */	private String 	rightColId	;
	/** 오른쪽 테이블 Alias 칼럼명 */	private String 	rightTblAliasColNm	;
	
	public String getTempJoinColumnId() {
		return tempJoinColumnId;
	}
	public void setTempJoinColumnId(String tempJoinColumnId) {
		this.tempJoinColumnId = tempJoinColumnId;
	}
	public String getJoinColumnId() {
		return joinColumnId;
	}
	public void setJoinColumnId(String joinColumnId) {
		this.joinColumnId = joinColumnId;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getJoinTypeCd() {
		return joinTypeCd;
	}
	public void setJoinTypeCd(String joinTypeCd) {
		this.joinTypeCd = joinTypeCd;
	}
	public String getLeftLgcCompTblRelId() {
		return leftLgcCompTblRelId;
	}
	public void setLeftLgcCompTblRelId(String leftLgcCompTblRelId) {
		this.leftLgcCompTblRelId = leftLgcCompTblRelId;
	}
	public String getLeftColId() {
		return leftColId;
	}
	public void setLeftColId(String leftColId) {
		this.leftColId = leftColId;
	}
	public String getLeftTblAliasColNm() {
		return leftTblAliasColNm;
	}
	public void setLeftTblAliasColNm(String leftTblAliasColNm) {
		this.leftTblAliasColNm = leftTblAliasColNm;
	}
	public String getJoinOprtCd() {
		return joinOprtCd;
	}
	public void setJoinOprtCd(String joinOprtCd) {
		this.joinOprtCd = joinOprtCd;
	}
	public String getRightLgcCompTblRelId() {
		return rightLgcCompTblRelId;
	}
	public void setRightLgcCompTblRelId(String rightLgcCompTblRelId) {
		this.rightLgcCompTblRelId = rightLgcCompTblRelId;
	}
	public String getRightColId() {
		return rightColId;
	}
	public void setRightColId(String rightColId) {
		this.rightColId = rightColId;
	}
	public String getRightTblAliasColNm() {
		return rightTblAliasColNm;
	}
	public void setRightTblAliasColNm(String rightTblAliasColNm) {
		this.rightTblAliasColNm = rightTblAliasColNm;
	}
	
}