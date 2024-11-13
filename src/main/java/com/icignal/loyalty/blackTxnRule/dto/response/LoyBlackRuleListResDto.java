/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackRuleListResDto.java
 * 2. Package	: com.icignal.loyalty.blackTxnRule.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 5. 오전 11:09:46
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 5.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackTxnRule.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyBlackRuleListResDto
 * 2. 파일명	: LoyBlackRuleListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.blackTxnRule.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyBlackRuleListResDto extends GridPagingItemResDto{
	private String rid;
	private String baseType;
	@MarkName(groupCode="LOY_FRAUD_RULE_TYPE",codeField="baseType")
	private String baseTypeNm;
	private String gtOrEt;
	private String basDayCnt;
	private String basDayMmCd;
	@MarkName(groupCode="LOY_FRAUD_RANAGE_CD",codeField="basDayMmCd")
	private String basDayMmCdNm;
	private String blackTxnRid;
	private String createBy;
	private String createDate;
	private String calc;
	
	
	public String getCalc() {
		return calc;
	}
	public void setCalc(String calc) {
		this.calc = calc;
	}
	public String getBaseTypeNm() {
		return baseTypeNm;
	}
	public void setBaseTypeNm(String baseTypeNm) {
		this.baseTypeNm = baseTypeNm;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getBaseType() {
		return baseType;
	}
	public void setBaseType(String baseType) {
		this.baseType = baseType;
	}
	public String getGtOrEt() {
		return gtOrEt;
	}
	public void setGtOrEt(String gtOrEt) {
		this.gtOrEt = gtOrEt;
	}
	public String getBasDayCnt() {
		return basDayCnt;
	}
	public void setBasDayCnt(String basDayCnt) {
		this.basDayCnt = basDayCnt;
	}
	public String getBlackTxnRid() {
		return blackTxnRid;
	}
	public void setBlackTxnRid(String blackTxnRid) {
		this.blackTxnRid = blackTxnRid;
	}
	public String getBasDayMmCd() {
		return basDayMmCd;
	}
	public void setBasDayMmCd(String basDayMmCd) {
		this.basDayMmCd = basDayMmCd;
	}
	public String getBasDayMmCdNm() {
		return basDayMmCdNm;
	}
	public void setBasDayMmCdNm(String basDayMmCdNm) {
		this.basDayMmCdNm = basDayMmCdNm;
	}
	
	
}
