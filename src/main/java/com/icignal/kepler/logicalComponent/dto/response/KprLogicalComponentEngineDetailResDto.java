package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentEngineDetailResponseDTO
 * 2. 파일명	: KPRLogicalComponentEngineDetailResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 이기오
 * 5. 작성일자	: 2018. 4. 11.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprLogicalComponentEngineDetailResDto extends StatusResDto {
	/* 로지컬 컴포넌트 - 테이블 관계 ID */
	private String tblRelId;
	/* 테이블 ID */
	private String tblId;

	/* 테이블 별칭 컬럼명 */
	private String tblAliasColNm;

	/* 스키마 테이블 명 */
	private String schmaTblNm;
	/* 테이블 별칭 */
	private String tblAlias;

	/* 조인 타입 코드 */
	private String joinTypeCode;
	/* 좌측 로지컬 컴포넌트 - 테이블 관계 ID */
	private String leftTblRelId;
	/* 좌측 테이블 ID */
	private String leftTblId;
	/* 좌측 스키마 테이블 명 */
	private String leftSchmaTblNm;
	/* 좌측 테이블 별칭 */
	private String leftTblAlias;
	/* 좌측 컬럼 ID */
	private String leftColId;
	/* 좌측 테이블 별칭 컬러 명 */
	private String leftTblAliasColNm;
	/* 좌측 그룹 컬럼 갯수 */
	private Integer leftGroupCnt;
	/* 조인 관계 코드 */
	private String joinOprtCode;
	/* 조인 관계 코드명 */
	private String joinOprtCodeName;
	/* 우측 로지컬 컴포넌트 - 테이블 관계 ID */
	private String rightTblRelId;
	/* 우측 테이블 ID */
	private String rightTblId;
	/* 우측 스키마 테이블 명 */
	private String rightSchmaTblNm;
	/* 우측 테이블 별칭 */
	private String rightTblAlias;
	/* 우측 컬럼 ID */
	private String rightColId;
	/* 우측 테이블 별칭 컬럼 명 */
	private String rightTblAliasColNm;
	/* 우측 그룹 컬럼 갯수 */
	private Integer rightGroupCnt;

	/* 그룹함수 코드명 */
	private String grpFuncTypeCode;
	/* 컬럼명 */
	private String colNm;

	public String getTblRelId() {
		return tblRelId;
	}

	public void setTblRelId(String tblRelId) {
		this.tblRelId = tblRelId;
	}

	public String getTblId() {
		return tblId;
	}

	public void setTblId(String tblId) {
		this.tblId = tblId;
	}

	public String getTblAliasColNm() {
		return tblAliasColNm;
	}

	public void setTblAliasColNm(String tblAliasColNm) {
		this.tblAliasColNm = tblAliasColNm;
	}

	public String getSchmaTblNm() {
		return schmaTblNm;
	}

	public void setSchmaTblNm(String schmaTblNm) {
		this.schmaTblNm = schmaTblNm;
	}

	public String getTblAlias() {
		return tblAlias;
	}

	public void setTblAlias(String tblAlias) {
		this.tblAlias = tblAlias;
	}

	public String getJoinTypeCode() {
		return joinTypeCode;
	}

	public void setJoinTypeCode(String joinTypeCode) {
		this.joinTypeCode = joinTypeCode;
	}

	public String getLeftTblRelId() {
		return leftTblRelId;
	}

	public void setLeftTblRelId(String leftTblRelId) {
		this.leftTblRelId = leftTblRelId;
	}

	public String getLeftTblId() {
		return leftTblId;
	}

	public void setLeftTblId(String leftTblId) {
		this.leftTblId = leftTblId;
	}

	public String getLeftSchmaTblNm() {
		return leftSchmaTblNm;
	}

	public void setLeftSchmaTblNm(String leftSchmaTblNm) {
		this.leftSchmaTblNm = leftSchmaTblNm;
	}

	public String getLeftTblAlias() {
		return leftTblAlias;
	}

	public void setLeftTblAlias(String leftTblAlias) {
		this.leftTblAlias = leftTblAlias;
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

	public Integer getLeftGroupCnt() {
		return leftGroupCnt;
	}

	public void setLeftGroupCnt(Integer leftGroupCnt) {
		this.leftGroupCnt = leftGroupCnt;
	}

	public String getJoinOprtCode() {
		return joinOprtCode;
	}

	public void setJoinOprtCode(String joinOprtCode) {
		this.joinOprtCode = joinOprtCode;
	}

	public String getJoinOprtCodeName() {
		return joinOprtCodeName;
	}

	public void setJoinOprtCodeName(String joinOprtCodeName) {
		this.joinOprtCodeName = joinOprtCodeName;
	}

	public String getRightTblRelId() {
		return rightTblRelId;
	}

	public void setRightTblRelId(String rightTblRelId) {
		this.rightTblRelId = rightTblRelId;
	}

	public String getRightTblId() {
		return rightTblId;
	}

	public void setRightTblId(String rightTblId) {
		this.rightTblId = rightTblId;
	}

	public String getRightSchmaTblNm() {
		return rightSchmaTblNm;
	}

	public void setRightSchmaTblNm(String rightSchmaTblNm) {
		this.rightSchmaTblNm = rightSchmaTblNm;
	}

	public String getRightTblAlias() {
		return rightTblAlias;
	}

	public void setRightTblAlias(String rightTblAlias) {
		this.rightTblAlias = rightTblAlias;
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

	public Integer getRightGroupCnt() {
		return rightGroupCnt;
	}

	public void setRightGroupCnt(Integer rightGroupCnt) {
		this.rightGroupCnt = rightGroupCnt;
	}

	public String getGrpFuncTypeCode() {
		return grpFuncTypeCode;
	}

	public void setGrpFuncTypeCode(String grpFuncTypeCode) {
		this.grpFuncTypeCode = grpFuncTypeCode;
	}

	public String getColNm() {
		return colNm;
	}

	public void setColNm(String colNm) {
		this.colNm = colNm;
	}
}