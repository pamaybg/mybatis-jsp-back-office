/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionTierActionReqDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 29. 오후 6:53:05
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 29.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyPromotionTierActionReqDto
 * 2. 파일명	: LoyPromotionTierActionReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 29.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionTierActionReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String tierGroupRid;
	private String tierRid;
	private String ofrAmtType;
	private Integer ofrAmt;
	private String seqNum;
	private String promActRid;
	private String tierEffStrtDayCnt;
	private String promRid;
	
	

	public String getTierEffStrtDayCnt() {
		return tierEffStrtDayCnt;
	}
	public void setTierEffStrtDayCnt(String tierEffStrtDayCnt) {
		this.tierEffStrtDayCnt = tierEffStrtDayCnt;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTierGroupRid() {
		return tierGroupRid;
	}
	public void setTierGroupRid(String tierGroupRid) {
		this.tierGroupRid = tierGroupRid;
	}
	public String getTierRid() {
		return tierRid;
	}
	public void setTierRid(String tierRid) {
		this.tierRid = tierRid;
	}
	
	public Integer getOfrAmt() {
		return ofrAmt;
	}
	public void setOfrAmt(Integer ofrAmt) {
		this.ofrAmt = ofrAmt;
	}
	public String getSeqNum() {
		return seqNum;
	}
	public void setSeqNum(String seqNum) {
		this.seqNum = seqNum;
	}
	public String getPromActRid() {
		return promActRid;
	}
	public void setPromActRid(String promActRid) {
		this.promActRid = promActRid;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getOfrAmtType() {
		return ofrAmtType;
	}
	public void setOfrAmtType(String ofrAmtType) {
		this.ofrAmtType = ofrAmtType;
	}
	
	
	
}
