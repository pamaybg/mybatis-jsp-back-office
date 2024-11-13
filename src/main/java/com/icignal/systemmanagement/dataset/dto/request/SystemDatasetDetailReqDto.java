/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemDatasetDetailReqDto.java
 * 2. Package	: com.icignal.systemmanagement.dataset.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 16. 오후 1:55:56
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 16.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.dataset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: SystemDatasetDetailReqDto
 * 2. 파일명	: SystemDatasetDetailReqDto.java
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

public class SystemDatasetDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String dsNm;
	private String objNm;
	private String cateCd;
	
	
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
	public String getDsNm() {
		return dsNm;
	}
	public void setDsNm(String dsNm) {
		this.dsNm = dsNm;
	}
	public String getObjNm() {
		return objNm;
	}
	public void setObjNm(String objNm) {
		this.objNm = objNm;
	}
	
	
}
