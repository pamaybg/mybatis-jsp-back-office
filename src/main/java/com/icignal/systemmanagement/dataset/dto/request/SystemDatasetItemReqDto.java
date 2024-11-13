/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemDatasetItemReqDto.java
 * 2. Package	: com.icignal.systemmanagement.dataset.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 16. 오후 3:23:31
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
 * 1. 클래스명	: SystemDatasetItemReqDto
 * 2. 파일명	: SystemDatasetItemReqDto.java
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

public class SystemDatasetItemReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String fieldNm;
	private String fieldDesc;
	private String dataSetRid;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getFieldNm() {
		return fieldNm;
	}
	public void setFieldNm(String fieldNm) {
		this.fieldNm = fieldNm;
	}
	public String getFieldDesc() {
		return fieldDesc;
	}
	public void setFieldDesc(String fieldDesc) {
		this.fieldDesc = fieldDesc;
	}
	public String getDataSetRid() {
		return dataSetRid;
	}
	public void setDataSetRid(String dataSetRid) {
		this.dataSetRid = dataSetRid;
	}
	
	
}
