package com.icignal.systemmanagement.outtable.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: SystemGetTableIdResDto
 * 2. 파일명	: SystemGetTableIdResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.response
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명	
 *		외부 타겟 레벨 리스트 조회
 * </PRE>
 */ 
public class SystemGetTableIdResDto extends GridPagingItemResDto {
	
	private String id;   

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	
}
