/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackTxnRuleListResDto.java
 * 2. Package	: com.icignal.loyalty.blackTxnRule.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 4. 오후 4:53:22
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 4.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackTxnRule.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyBlackTxnRuleListResDto
 * 2. 파일명	: LoyBlackTxnRuleListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.blackTxnRule.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyBlackTxnRuleListResDto extends GridPagingItemResDto{
	private String rid;
	private String pgmNm;
	private String blCd;
	private String blNm;
	private String statCd;
	@MarkName(groupCode="LOY_ACTIVE_CD",codeField="statCd")
	private String statCdNm;
	private String createBy;
	private String createDate;
	private String fraudTypeCd;
	@MarkName(groupCode="LOY_FRAUD_TYPE_CD",codeField="fraudTypeCd")
	private String fraudTypeCdNm;
	private String fraudSubTypeCd;
	@MarkName(groupCode="LOY_FRAUD_SUB_TYPE_CD",codeField="fraudSubTypeCd")
	private String fraudSubTypeCdNm;
	
	
	public String getFraudTypeCdNm() {
		return fraudTypeCdNm;
	}
	public void setFraudTypeCdNm(String fraudTypeCdNm) {
		this.fraudTypeCdNm = fraudTypeCdNm;
	}
	public String getFraudSubTypeCdNm() {
		return fraudSubTypeCdNm;
	}
	public void setFraudSubTypeCdNm(String fraudSubTypeCdNm) {
		this.fraudSubTypeCdNm = fraudSubTypeCdNm;
	}
	public String getFraudTypeCd() {
		return fraudTypeCd;
	}
	public void setFraudTypeCd(String fraudTypeCd) {
		this.fraudTypeCd = fraudTypeCd;
	}
	public String getFraudSubTypeCd() {
		return fraudSubTypeCd;
	}
	public void setFraudSubTypeCd(String fraudSubTypeCd) {
		this.fraudSubTypeCd = fraudSubTypeCd;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getBlCd() {
		return blCd;
	}
	public void setBlCd(String blCd) {
		this.blCd = blCd;
	}
	public String getBlNm() {
		return blNm;
	}
	public void setBlNm(String blNm) {
		this.blNm = blNm;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
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
	
	
	
}
