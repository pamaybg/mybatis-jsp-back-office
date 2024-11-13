/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemApiParamDetailReqDto.java
 * 2. Package	: com.icignal.systemmanagement.apispec.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 9. 23. 오후 4:20:19
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 9. 23.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.apispec.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: SystemApiParamDetailReqDto
 * 2. 파일명	: SystemApiParamDetailReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.apispec.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 9. 23.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class SystemApiParamDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String apiRid;
	private String parRid;
	private String paramTypeCd;
	private String seqNo;
	private String paramNm;
	private String dataTypeCd;
	private String dataFormat;
	private String requriedYn;
	private String paramDesc;
	private String addDesc;
	private String parParamNm;
	private String requiredYn;
	private String grpYn;
	private String paramSubTypeCd;
	
	
	public String getParamSubTypeCd() {
		return paramSubTypeCd;
	}
	public void setParamSubTypeCd(String paramSubTypeCd) {
		this.paramSubTypeCd = paramSubTypeCd;
	}
	public String getGrpYn() {
		return grpYn;
	}
	public void setGrpYn(String grpYn) {
		this.grpYn = grpYn;
	}
	public String getRequiredYn() {
		return requiredYn;
	}
	public void setRequiredYn(String requiredYn) {
		this.requiredYn = requiredYn;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getApiRid() {
		return apiRid;
	}
	public void setApiRid(String apiRid) {
		this.apiRid = apiRid;
	}
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getParamTypeCd() {
		return paramTypeCd;
	}
	public void setParamTypeCd(String paramTypeCd) {
		this.paramTypeCd = paramTypeCd;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	public String getParamNm() {
		return paramNm;
	}
	public void setParamNm(String paramNm) {
		this.paramNm = paramNm;
	}
	public String getDataTypeCd() {
		return dataTypeCd;
	}
	public void setDataTypeCd(String dataTypeCd) {
		this.dataTypeCd = dataTypeCd;
	}
	public String getDataFormat() {
		return dataFormat;
	}
	public void setDataFormat(String dataFormat) {
		this.dataFormat = dataFormat;
	}
	public String getRequriedYn() {
		return requriedYn;
	}
	public void setRequriedYn(String requriedYn) {
		this.requriedYn = requriedYn;
	}
	public String getParamDesc() {
		return paramDesc;
	}
	public void setParamDesc(String paramDesc) {
		this.paramDesc = paramDesc;
	}
	public String getAddDesc() {
		return addDesc;
	}
	public void setAddDesc(String addDesc) {
		this.addDesc = addDesc;
	}
	public String getParParamNm() {
		return parParamNm;
	}
	public void setParParamNm(String parParamNm) {
		this.parParamNm = parParamNm;
	}
	
	
}
