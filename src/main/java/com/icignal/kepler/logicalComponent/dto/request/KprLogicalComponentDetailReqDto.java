package com.icignal.kepler.logicalComponent.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentDetailRequestDTO
 * 2. 파일명	: KPRLogicalComponentDetailRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		로지컬 컴포넌트상세 요청  DTO
 * </PRE>
 */ 
public class KprLogicalComponentDetailReqDto extends CommonDataAuthReqDto {
	
	/**    아이디    */    private String  lgcCompId= "";
	
	/**    좌측_로지컬컴포넌트_테이블_REL_ID    */    private String  leftLgcCompTblRelId= "";
	/**    우측_로지컬컴포넌트_테이블_REL_ID    */    private String  rightLgcCompTblRelId= "";
	
	public String getLgcCompId() {
		return lgcCompId;
	}
	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}
	public String getLeftLgcCompTblRelId() {
		return leftLgcCompTblRelId;
	}
	public void setLeftLgcCompTblRelId(String leftLgcCompTblRelId) {
		this.leftLgcCompTblRelId = leftLgcCompTblRelId;
	}
	public String getRightLgcCompTblRelId() {
		return rightLgcCompTblRelId;
	}
	public void setRightLgcCompTblRelId(String rightLgcCompTblRelId) {
		this.rightLgcCompTblRelId = rightLgcCompTblRelId;
	}

}