package com.icignal.kepler.logicalComponent.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentDetailJoinColumnBaseResponseDTO
 * 2. 파일명	: KPRLogicalComponentDetailJoinColumnBaseResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		조인 칼럼 기본 정보 반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentDetailJoinColumnBaseResDto extends StatusResDto {

	/** 조인 타입 코드 */	private String 	joinTypeCd	;
	/** 왼쪽 노드 ID */	private String 	leftNodeId	;
	/** 왼쪽 테이블 관계 ID */	private String 	leftLgcCompTblRelId	;
	/** 왼쪽 테이블 ID */	private String 	leftTblId	;
	/** 왼쪽 테이블명 ID */	private String 	leftTblNm	;
	/** 왼쪽 테이블 Alias */	private String 	leftTblAlias	;
	/** 오른쪽 노드 ID */	private String 	rightNodeId	;
	/** 오른쪽 테이블 관계 ID */	private String 	rightLgcCompTblRelId	;
	/** 오른쪽 테이블 ID */	private String 	rightTblId	;
	/** 오른쪽 테이블명 ID */	private String 	rightTblNm	;
	/** 오른쪽 테이블 Alias */	private String 	rightTblAlias	;
	

	/** 조인 칼럼 리스트 */ private List<KprLogicalComponentDetailJoinColumnResDto> joinColumnList;

	public String getJoinTypeCd() {
		return joinTypeCd;
	}

	public void setJoinTypeCd(String joinTypeCd) {
		this.joinTypeCd = joinTypeCd;
	}

	public String getLeftNodeId() {
		return leftNodeId;
	}

	public void setLeftNodeId(String leftNodeId) {
		this.leftNodeId = leftNodeId;
	}

	public String getLeftLgcCompTblRelId() {
		return leftLgcCompTblRelId;
	}

	public void setLeftLgcCompTblRelId(String leftLgcCompTblRelId) {
		this.leftLgcCompTblRelId = leftLgcCompTblRelId;
	}

	public String getLeftTblId() {
		return leftTblId;
	}

	public void setLeftTblId(String leftTblId) {
		this.leftTblId = leftTblId;
	}

	public String getLeftTblNm() {
		return leftTblNm;
	}

	public void setLeftTblNm(String leftTblNm) {
		this.leftTblNm = leftTblNm;
	}

	public String getLeftTblAlias() {
		return leftTblAlias;
	}

	public void setLeftTblAlias(String leftTblAlias) {
		this.leftTblAlias = leftTblAlias;
	}

	public String getRightNodeId() {
		return rightNodeId;
	}

	public void setRightNodeId(String rightNodeId) {
		this.rightNodeId = rightNodeId;
	}

	public String getRightLgcCompTblRelId() {
		return rightLgcCompTblRelId;
	}

	public void setRightLgcCompTblRelId(String rightLgcCompTblRelId) {
		this.rightLgcCompTblRelId = rightLgcCompTblRelId;
	}

	public String getRightTblId() {
		return rightTblId;
	}

	public void setRightTblId(String rightTblId) {
		this.rightTblId = rightTblId;
	}

	public String getRightTblNm() {
		return rightTblNm;
	}

	public void setRightTblNm(String rightTblNm) {
		this.rightTblNm = rightTblNm;
	}

	public String getRightTblAlias() {
		return rightTblAlias;
	}

	public void setRightTblAlias(String rightTblAlias) {
		this.rightTblAlias = rightTblAlias;
	}

	public List<KprLogicalComponentDetailJoinColumnResDto> getJoinColumnList() {
		return joinColumnList;
	}

	public void setJoinColumnList(List<KprLogicalComponentDetailJoinColumnResDto> joinColumnList) {
		this.joinColumnList = joinColumnList;
	}

}