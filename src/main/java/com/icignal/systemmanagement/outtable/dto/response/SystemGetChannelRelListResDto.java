package com.icignal.systemmanagement.outtable.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: SystemGetChannelRelListResDto
 * 2. 파일명	: SystemGetChannelRelListResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.response
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		외부 채널 관계 테이블 조회
 * </PRE>
 */ 
@CommCode
public class SystemGetChannelRelListResDto extends GridPagingItemResDto {
	
	private String id;   
	private String colEngNm;
	private String colKorNm;
	
	@MarkName(codeField = "colTypeCdNm", groupCode = "MKT_SEG_COLUMN_TYPE")
	private String colTypeCd;
	
	private String colTypeCdNm;
	private String flagAtribVal;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getColEngNm() {
		return colEngNm;
	}
	public void setColEngNm(String colEngNm) {
		this.colEngNm = colEngNm;
	}
	public String getColKorNm() {
		return colKorNm;
	}
	public void setColKorNm(String colKorNm) {
		this.colKorNm = colKorNm;
	}
	public String getColTypeCd() {
		return colTypeCd;
	}
	public void setColTypeCd(String colTypeCd) {
		this.colTypeCd = colTypeCd;
	}
	public String getFlagAtribVal() {
		return flagAtribVal;
	}
	public void setFlagAtribVal(String flagAtribVal) {
		this.flagAtribVal = flagAtribVal;
	}
	public String getColTypeCdNm() {
		return colTypeCdNm;
	}
	public void setColTypeCdNm(String colTypeCdNm) {
		this.colTypeCdNm = colTypeCdNm;
	}
	
	
	
}
