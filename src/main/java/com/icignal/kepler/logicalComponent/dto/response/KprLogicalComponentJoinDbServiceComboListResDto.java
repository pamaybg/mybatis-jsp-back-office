package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentJoinDbServiceComboListResponseDTO
 * 2. 파일명	: KPRLogicalComponentJoinDbServiceComboListResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		DB 서비스 콤보리스트 반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentJoinDbServiceComboListResDto extends StatusResDto {

	/**    Combo Id    */ private String id;
	/**    Combo Name    */ private String text;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}

}