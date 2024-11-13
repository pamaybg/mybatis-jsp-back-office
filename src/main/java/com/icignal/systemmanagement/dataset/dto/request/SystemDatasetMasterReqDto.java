/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemDatasetMasterReqDto.java
 * 2. Package	: com.icignal.systemmanagement.dataset.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 16. 오전 10:33:34
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 16.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.dataset.dto.request;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: SystemDatasetMasterReqDto
 * 2. 파일명	: SystemDatasetMasterReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.dataset.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public class SystemDatasetMasterReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String dataSetRid;
	private String cateCd;
	private String objectName;
	
	private String tblNm;
	
	
	public String getObjectName() {
		return objectName;
	}
	public void setObjectName(String objectName) {
		this.objectName = objectName;
	}
	public String getCateCd() {
		return cateCd;
	}
	public void setCateCd(String cateCd) {
		this.cateCd = cateCd;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getDataSetRid() {
		return dataSetRid;
	}
	public void setDataSetRid(String dataSetRid) {
		this.dataSetRid = dataSetRid;
	}
	
	public String getTblNm() {
		return tblNm;
	}
	public void setTblNm(String tblNm) {
		this.tblNm = tblNm;
	}
	
	
}
