package com.icignal.common.base.dto.response;

import java.io.Serializable;



/*
 * 1. 클래스명	: CommCodeResDto
 * 2. 파일명	: CommCodeResDto.java
 * 3. 패키지명	: com.icignal.common.base.dto.response
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 3. 4.
 */
/**
 * <PRE>
 * 1. 설명
 * 공통코드 저장 Dto
 * </PRE>
 */ 
public class CommCodeResDto implements Serializable{

	private static final long serialVersionUID = 5844928692650424792L;

	private String codeName;
	
	private String groupCode;
	
	private String markName;
	
	private String lang;
	
	private TYPE jobType;
	
	
	 public static enum TYPE {
			CODENAME_ADD,
			CODENAME_EDIT,
			CODENAME_DEL,
			GROUPCODE_DEL
	 }	
	
	
	

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	/**
	 * @return the serialversionuid
	 */
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	/**
	 * @return the groupCode
	 */
	public String getGroupCode() {
		return groupCode;
	}

	/**
	 * @return the markName
	 */
	public String getMarkName() {
		return markName;
	}

	/**
	 * @return the lang
	 */
	public String getLang() {
		return lang;
	}

	/**
	 * @param groupCode the groupCode to set
	 */
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}

	/**
	 * @param markName the markName to set
	 */
	public void setMarkName(String markName) {
		this.markName = markName;
	}

	/**
	 * @param lang the lang to set
	 */
	public void setLang(String lang) {
		this.lang = lang;
	}

	/**
	 * @return the jobType
	 */
	public TYPE getJobType() {
		return jobType;
	}

	/**
	 * @param jobType the jobType to set
	 */
	public void setJobType(TYPE jobType) {
		this.jobType = jobType;
	}

	
	
}


