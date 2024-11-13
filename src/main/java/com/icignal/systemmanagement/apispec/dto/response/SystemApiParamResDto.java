/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemApiParamResDto.java
 * 2. Package	: com.icignal.systemmanagement.apispec.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 9. 23. 오후 2:49:21
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 9. 23.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.apispec.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: SystemApiParamResDto
 * 2. 파일명	: SystemApiParamResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.apispec.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 9. 23.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class SystemApiParamResDto extends GridPagingItemResDto{
	private String rid;
	private String createDate;
	private String createBy;
	private String apiRid;
	private String parRid;
	private String paramTypeCd;
	@MarkName(groupCode = "API_PARAM_TYPE_CD", codeField = "paramTypeCd")
	private String paramTypeCdNm;
	private String seqNo;
	private String paramNm;
	private String dataTypeCd;
	@MarkName(groupCode = "API_PARAM_DATA_TYPE_CD", codeField = "dataTypeCd")
	private String dataTypeCdNm;
	private String dataFormat;
	private String requriedYn;
	private String paramDesc;
	private String addDesc;
	private String parParamNm;
	private String paramSubTypeCd;
	@MarkName(groupCode = "API_PARAM_SUB_TYPE_CD", codeField = "paramSubTypeCd")
	private String paramSubTypeCdNm;
	
	
	public String getParamSubTypeCd() {
		return paramSubTypeCd;
	}
	public void setParamSubTypeCd(String paramSubTypeCd) {
		this.paramSubTypeCd = paramSubTypeCd;
	}
	public String getParamSubTypeCdNm() {
		return paramSubTypeCdNm;
	}
	public void setParamSubTypeCdNm(String paramSubTypeCdNm) {
		this.paramSubTypeCdNm = paramSubTypeCdNm;
	}
	public String getParamTypeCdNm() {
		return paramTypeCdNm;
	}
	public void setParamTypeCdNm(String paramTypeCdNm) {
		this.paramTypeCdNm = paramTypeCdNm;
	}
	public String getDataTypeCdNm() {
		return dataTypeCdNm;
	}
	public void setDataTypeCdNm(String dataTypeCdNm) {
		this.dataTypeCdNm = dataTypeCdNm;
	}
	public String getParParamNm() {
		return parParamNm;
	}
	public void setParParamNm(String parParamNm) {
		this.parParamNm = parParamNm;
	}
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getApiRid() {
		return apiRid;
	}
	public void setApiRid(String apiRid) {
		this.apiRid = apiRid;
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
	
	
}
