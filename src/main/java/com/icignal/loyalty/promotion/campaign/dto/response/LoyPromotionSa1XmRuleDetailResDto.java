/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionSa1XmRuleDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 1. 오후 6:14:56
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 1.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyPromotionSa1XmRuleDetailResDto
 * 2. 파일명	: LoyPromotionSa1XmRuleDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 1.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionSa1XmRuleDetailResDto extends StatusResDto{
	private String rid;
	private Integer startVal;
	private Integer endVal;
	private Integer effStrtDayCnt;
	private Integer ofrAmt;
	private String ofrAmtType;
	private String seqNo;
	private String promRid;
	private String paulSa1genRid;
	private String ofrRid;
	private String ofrNo;
	private String ofrNm;
	private String cpnYn;
	
	
	public String getCpnYn() {
		return cpnYn;
	}
	public void setCpnYn(String cpnYn) {
		this.cpnYn = cpnYn;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public Integer getStartVal() {
		return startVal;
	}
	public void setStartVal(Integer startVal) {
		this.startVal = startVal;
	}
	public Integer getEndVal() {
		return endVal;
	}
	public void setEndVal(Integer endVal) {
		this.endVal = endVal;
	}
	public Integer getEffStrtDayCnt() {
		return effStrtDayCnt;
	}
	public void setEffStrtDayCnt(Integer effStrtDayCnt) {
		this.effStrtDayCnt = effStrtDayCnt;
	}
	public Integer getOfrAmt() {
		return ofrAmt;
	}
	public void setOfrAmt(Integer ofrAmt) {
		this.ofrAmt = ofrAmt;
	}
	public String getOfrAmtType() {
		return ofrAmtType;
	}
	public void setOfrAmtType(String ofrAmtType) {
		this.ofrAmtType = ofrAmtType;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getPaulSa1genRid() {
		return paulSa1genRid;
	}
	public void setPaulSa1genRid(String paulSa1genRid) {
		this.paulSa1genRid = paulSa1genRid;
	}
	public String getOfrRid() {
		return ofrRid;
	}
	public void setOfrRid(String ofrRid) {
		this.ofrRid = ofrRid;
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
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	
	
}
