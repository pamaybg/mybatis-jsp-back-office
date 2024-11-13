package com.icignal.kepler.common.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRCommonCodeResponseDTO
 * 2. 파일명	: KPRCommonCodeResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.response
 * 4. 작성자명	: 류동균
 * 5. 작성일자	: 2015. 9. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *		공통코드
 * </PRE>
 */ 
public class KprCommonCodeResDto extends GridPagingItemResDto {

	private String codeId;
	private String codeName;
	private String markName;
	private String attrib01;
	private String attrib02;
	private String attrib03;
	private String attrib04;
	private String attrib05;
	private String schemaNm;
	private String tblEngNm;
	private String dateValue;

	public String getCodeId() {
		return codeId;
	}

	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	public String getMarkName() {
		return markName;
	}

	public void setMarkName(String markName) {
		this.markName = markName;
	}

	public String getAttrib01() {
		return attrib01;
	}

	public void setAttrib01(String attrib01) {
		this.attrib01 = attrib01;
	}

	public String getAttrib02() {
		return attrib02;
	}

	public void setAttrib02(String attrib02) {
		this.attrib02 = attrib02;
	}

	public String getAttrib03() {
		return attrib03;
	}

	public void setAttrib03(String attrib03) {
		this.attrib03 = attrib03;
	}

	public String getAttrib04() {
		return attrib04;
	}

	public void setAttrib04(String attrib04) {
		this.attrib04 = attrib04;
	}

	public String getAttrib05() {
		return attrib05;
	}

	public void setAttrib05(String attrib05) {
		this.attrib05 = attrib05;
	}

	public String getSchemaNm() {
		return schemaNm;
	}

	public void setSchemaNm(String schemaNm) {
		this.schemaNm = schemaNm;
	}

	public String getTblEngNm() {
		return tblEngNm;
	}

	public void setTblEngNm(String tblEngNm) {
		this.tblEngNm = tblEngNm;
	}

	public String getDateValue() {
		return dateValue;
	}

	public void setDateValue(String dateValue) {
		this.dateValue = dateValue;
	}
}