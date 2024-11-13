package com.icignal.systemmanagement.commcode.dto.request;

import java.util.List;

import javax.validation.constraints.NotNull;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;


/**
 * @name : MKTCommonCodeRequestDTO.java
 * @date : 2015. 9. 22.
 * @author : 류동균
 * @description : 공통코드
 */
public class MKTCommonCodeRequestDTO extends MKTGridPagingReqDto {

	@NotNull
	private String groupCode;
	private Boolean enableNA;
	private String schemas;
	private String parCodeId;
	private String codeName;
	private List<String> codeIdList;

	private String attrib01;
	private String attrib02;
	private String attrib03;
	private String attrib04;
	private String attrib05;

	private String overSeq;

	private String parCode;

	private String pagingFlag;
	private String type;

	public String getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}

	public Boolean getEnableNA() {
		if (this.enableNA == null)
			this.enableNA = false;
		return enableNA;
	}

	public void setEnableNA(Boolean enableNA) {
		this.enableNA = enableNA;
	}

	public String getSchemas() {
		if (schemas == null)
			schemas = "com";
		return schemas;
	}

	public void setSchemas(String schemas) {
		this.schemas = schemas;
	}

	public String getParCodeId() {
		return parCodeId;
	}

	public void setParCodeId(String parCodeId) {
		this.parCodeId = parCodeId;
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

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	/**
	 * @return the overSeq
	 */
	public String getOverSeq() {
		return overSeq;
	}

	/**
	 * @param overSeq
	 *            the overSeq to set
	 */
	public void setOverSeq(String overSeq) {
		this.overSeq = overSeq;
	}

	public String getParCode() {
		return parCode;
	}

	public void setParCode(String parCode) {
		this.parCode = parCode;
	}

	public String getPagingFlag() {
		return pagingFlag;
	}

	public void setPagingFlag(String pagingFlag) {
		this.pagingFlag = pagingFlag;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<String> getCodeIdList() {
		return codeIdList;
	}

	public void setCodeIdList(List<String> codeIdList) {
		this.codeIdList = codeIdList;
	}
}