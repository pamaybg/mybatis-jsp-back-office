package com.icignal.systemmanagement.outtable.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: SystemGetChannelListResDto
 * 2. 파일명	: SystemGetChannelListResDto.java
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
public class SystemGetChannelListResDto extends GridPagingItemResDto {
	
	private String id;   
	private String markNm;  //타겟레벨명
	private String codeNm;  //코드명

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMarkNm() {
		return markNm;
	}
	public void setMarkNm(String markNm) {
		this.markNm = markNm;
	}
    public String getCodeNm() {
        return codeNm;
    }
    public void setCodeNm(String codeNm) {
        this.codeNm = codeNm;
    }
	
	
}
