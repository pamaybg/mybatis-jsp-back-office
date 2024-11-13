/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCategoryListResDto.java
 * 2. Package	: com.icignal.loyalty.prodgrp.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 15. 오후 5:05:17
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.prodgrp.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: LoyCategoryListResDto
 * 2. 파일명	: LoyCategoryListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.prodgrp.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyCategoryListResDto extends GridPagingItemResDto{
	private String catId;
	private String catNm;
	private String createDate;
	private String name;
	private String rid;

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
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCatId() {
		return catId;
	}
	public void setCatId(String catId) {
		this.catId = catId;
	}
	public String getCatNm() {
		return catNm;
	}
	public void setCatNm(String catNm) {
		this.catNm = catNm;
	}
	
}
