/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemDatasetItemListResDto.java
 * 2. Package	: com.icignal.systemmanagement.dataset.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 16. 오후 1:40:42
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 16.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.dataset.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: SystemDatasetItemListResDto
 * 2. 파일명	: SystemDatasetItemListResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.dataset.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class SystemDatasetItemListResDto extends GridPagingItemResDto{
	private String rid;
	private String dataSetRid;
	private String fieldNm;
	private String fieldDesc;
	private String createDate;
	private String name;
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
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
	
}
