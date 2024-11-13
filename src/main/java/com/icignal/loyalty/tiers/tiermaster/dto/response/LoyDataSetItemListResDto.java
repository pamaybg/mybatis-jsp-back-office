/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyDataSetItemListResDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 5. 오전 10:09:36
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 5.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyDataSetItemListResDto
 * 2. 파일명	: LoyDataSetItemListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyDataSetItemListResDto extends GridPagingItemResDto{
	private String rid;
	private String fieldNm;
	private String fieldDesc;
	private String dsNm;
	private String dataSetRid;
	private String tierDataSetRid;
	private String tierDataSetItemRid;
	private String fieldTypeCd;
	@MarkName(groupCode="LOY_DATASET_ITEM_TYPE", codeField="fieldTypeCd")
	private String fieldTypeCdNm;
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
	public String getDsNm() {
		return dsNm;
	}
	public void setDsNm(String dsNm) {
		this.dsNm = dsNm;
	}
	public String getDataSetRid() {
		return dataSetRid;
	}
	public void setDataSetRid(String dataSetRid) {
		this.dataSetRid = dataSetRid;
	}
	public String getTierDataSetRid() {
		return tierDataSetRid;
	}
	public void setTierDataSetRid(String tierDataSetRid) {
		this.tierDataSetRid = tierDataSetRid;
	}
	public String getFieldDesc() {
		return fieldDesc;
	}
	public void setFieldDesc(String fieldDesc) {
		this.fieldDesc = fieldDesc;
	}
	public String getTierDataSetItemRid() {
		return tierDataSetItemRid;
	}
	public void setTierDataSetItemRid(String tierDataSetItemRid) {
		this.tierDataSetItemRid = tierDataSetItemRid;
	}
	public String getFieldTypeCd() {
		return fieldTypeCd;
	}
	public void setFieldTypeCd(String fieldTypeCd) {
		this.fieldTypeCd = fieldTypeCd;
	}
	public String getFieldTypeCdNm() {
		return fieldTypeCdNm;
	}
	public void setFieldTypeCdNm(String fieldTypeCdNm) {
		this.fieldTypeCdNm = fieldTypeCdNm;
	}
	
	
}
