package com.icignal.systemmanagement.program.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: SystemProgRelExcelDnReqDto
 * 2. 파일명	: SystemProgRelExcelDnReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.program.dto.request
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 4. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *		프로그램 상,하위 관계 메타데이터를 이용한 엑셀 다운로드 DTO
 * </PRE>
 */ 
public class SystemProgRelExcelDnReqDto extends CommonDataAuthReqDto {

	private String programPath;
	private String progType;
	private String progTypeCd;
	private String topPgmId;
	private String parPgmId;
	private String pgmNm;
	private String pgmNo;
	private String LEVEL;
	
	public String getProgramPath() {
		return programPath;
	}
	public void setProgramPath(String programPath) {
		this.programPath = programPath;
	}
	public String getProgType() {
		return progType;
	}
	public void setProgType(String progType) {
		this.progType = progType;
	}
	public String getProgTypeCd() {
		return progTypeCd;
	}
	public void setProgTypeCd(String progTypeCd) {
		this.progTypeCd = progTypeCd;
	}
	public String getTopPgmId() {
		return topPgmId;
	}
	public void setTopPgmId(String topPgmId) {
		this.topPgmId = topPgmId;
	}
	public String getParPgmId() {
		return parPgmId;
	}
	public void setParPgmId(String parPgmId) {
		this.parPgmId = parPgmId;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getPgmNo() {
		return pgmNo;
	}
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}
	public String getLEVEL() {
		return LEVEL;
	}
	public void setLEVEL(String lEVEL) {
		LEVEL = lEVEL;
	}
	
	
}
