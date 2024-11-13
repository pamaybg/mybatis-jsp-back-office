package com.icignal.kepler.logicalComponent.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRLogicalComponentAttributeGroupLeftAccordionListRequestDTO
 * 2. 파일명	: KPRLogicalComponentAttributeGroupLeftAccordionListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		어트리뷰트 그룹 설정 > 왼쪽 어코디언 리스트 조회 요청  DTO
 * </PRE>
 */ 
public class KprLogicalComponentAttributeGroupLeftAccordionListReqDto extends CommonDataAuthReqDto {
	
	/**    로지컬 컴포넌트 ID    */    private String  lgcCompId= "";

	public String getLgcCompId() {
		return lgcCompId;
	}

	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}

}
