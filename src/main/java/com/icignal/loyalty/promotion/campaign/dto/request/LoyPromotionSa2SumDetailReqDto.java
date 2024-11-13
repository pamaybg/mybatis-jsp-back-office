/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionSa2SumDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 2. 오후 5:34:45
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 2.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyPromotionSa2SumDetailReqDto
 * 2. 파일명	: LoyPromotionSa2SumDetailReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 2.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionSa2SumDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private Integer startVal;
	private Integer endVal;
	private Integer effStrtDayCnt;
	private Integer ofrAmt;
	private String ofrAmtType;
	private String seqNum;
	private String promRid;
	private String ofrRid;
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
	public String getSeqNum() {
		return seqNum;
	}
	public void setSeqNum(String seqNum) {
		this.seqNum = seqNum;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getOfrRid() {
		return ofrRid;
	}
	public void setOfrRid(String ofrRid) {
		this.ofrRid = ofrRid;
	}
	
	
}
