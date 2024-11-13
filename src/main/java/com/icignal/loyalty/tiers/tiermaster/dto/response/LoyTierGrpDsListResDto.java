/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierGrpDsListResDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 3. 오후 1:34:08
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 3.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: LoyTierGrpDsListResDto
 * 2. 파일명	: LoyTierGrpDsListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

/*
 * 1. 클래스명	: LoyTierGrpDsListResDto
 * 2. 파일명	: LoyTierGrpDsListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyTierGrpDsListResDto extends GridPagingItemResDto{
	private String rid;
	private String dsNm;
	private String dsRid;
	private String objNm;
	private String extRange;
	private String createBy;
	private String createDate;
	private String tierDataSetRid;
	private String dsItemRid;
	private String fieldNm;
	private String fieldDesc;
	
	
	public String getFieldDesc() {
		return fieldDesc;
	}
	public void setFieldDesc(String fieldDesc) {
		this.fieldDesc = fieldDesc;
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
	public String getDsRid() {
		return dsRid;
	}
	public void setDsRid(String dsRid) {
		this.dsRid = dsRid;
	}
	public String getObjNm() {
		return objNm;
	}
	public void setObjNm(String objNm) {
		this.objNm = objNm;
	}
	public String getExtRange() {
		return extRange;
	}
	public void setExtRange(String extRange) {
		this.extRange = extRange;
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
	public String getTierDataSetRid() {
		return tierDataSetRid;
	}
	public void setTierDataSetRid(String tierDataSetRid) {
		this.tierDataSetRid = tierDataSetRid;
	}
	public String getDsItemRid() {
		return dsItemRid;
	}
	public void setDsItemRid(String dsItemRid) {
		this.dsItemRid = dsItemRid;
	}
	public String getFieldNm() {
		return fieldNm;
	}
	public void setFieldNm(String fieldNm) {
		this.fieldNm = fieldNm;
	}

	
	
	
}
