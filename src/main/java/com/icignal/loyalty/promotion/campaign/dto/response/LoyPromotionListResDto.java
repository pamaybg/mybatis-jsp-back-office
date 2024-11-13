/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionListResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 23. 오후 2:53:09
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 23.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyPromotionListResDto
 * 2. 파일명	: LoyPromotionListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 23.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyPromotionListResDto extends GridPagingItemResDto{
	private String rid;
	private String promNm;
	private String promNo;
	private String promStatCd;
    @MarkName(groupCode="MKT_CAM_STAT", codeField="promStatCd")
	private String promStatCdNm;
	private String promTypeLv1Cd;
	private String promTypeLv2Cd;
    @MarkName(groupCode="PROM_TYPE_LV1", codeField="promTypeLv1Cd")
	private String promTypeLv1CdNm;
    @MarkName(groupCode="PROM_TYPE_LV2", codeField="promTypeLv2Cd")
	private String promTypeLv2CdNm;
	private String validStartDate;
	private String validEndDate;
	private String name;
	private String createDate;
	private String ofrNm;
	private String ofrType;
    @MarkName(groupCode = "LOY_OFR_TYPE", codeField = "ofrType")
    private String ofrTypeNm;
    private String ofrNo;
    private String pgmNm;
    
    
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getOfrType() {
		return ofrType;
	}
	public void setOfrType(String ofrType) {
		this.ofrType = ofrType;
	}
	public String getOfrTypeNm() {
		return ofrTypeNm;
	}
	public void setOfrTypeNm(String ofrTypeNm) {
		this.ofrTypeNm = ofrTypeNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPromNm() {
		return promNm;
	}
	public void setPromNm(String promNm) {
		this.promNm = promNm;
	}
	public String getPromNo() {
		return promNo;
	}
	public void setPromNo(String promNo) {
		this.promNo = promNo;
	}
	public String getPromStatCd() {
		return promStatCd;
	}
	public void setPromStatCd(String promStatCd) {
		this.promStatCd = promStatCd;
	}
	public String getPromStatCdNm() {
		return promStatCdNm;
	}
	public void setPromStatCdNm(String promStatCdNm) {
		this.promStatCdNm = promStatCdNm;
	}
	public String getPromTypeLv1Cd() {
		return promTypeLv1Cd;
	}
	public void setPromTypeLv1Cd(String promTypeLv1Cd) {
		this.promTypeLv1Cd = promTypeLv1Cd;
	}
	public String getPromTypeLv2Cd() {
		return promTypeLv2Cd;
	}
	public void setPromTypeLv2Cd(String promTypeLv2Cd) {
		this.promTypeLv2Cd = promTypeLv2Cd;
	}
	public String getPromTypeLv1CdNm() {
		return promTypeLv1CdNm;
	}
	public void setPromTypeLv1CdNm(String promTypeLv1CdNm) {
		this.promTypeLv1CdNm = promTypeLv1CdNm;
	}
	public String getPromTypeLv2CdNm() {
		return promTypeLv2CdNm;
	}
	public void setPromTypeLv2CdNm(String promTypeLv2CdNm) {
		this.promTypeLv2CdNm = promTypeLv2CdNm;
	}
	public String getValidStartDate() {
		return validStartDate;
	}
	public void setValidStartDate(String validStartDate) {
		this.validStartDate = validStartDate;
	}
	public String getValidEndDate() {
		return validEndDate;
	}
	public void setValidEndDate(String validEndDate) {
		this.validEndDate = validEndDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	

}
