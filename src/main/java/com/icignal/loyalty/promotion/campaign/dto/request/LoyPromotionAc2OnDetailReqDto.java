/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionAc2OnDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 2. 오후 7:29:45
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
 * 1. 클래스명	: LoyPromotionAc2OnDetailReqDto
 * 2. 파일명	: LoyPromotionAc2OnDetailReqDto.java
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

public class LoyPromotionAc2OnDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private Integer effStrtDayCnt;
	private Integer ofrAmt;
	private String onlActCd;
	private String seqNum;
	private String promRid;
	private String ofrRid;
	private String ofrAmtType;
	
	
	public String getOfrAmtType() {
		return ofrAmtType;
	}
	public void setOfrAmtType(String ofrAmtType) {
		this.ofrAmtType = ofrAmtType;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getOnlActCd() {
		return onlActCd;
	}
	public void setOnlActCd(String onlActCd) {
		this.onlActCd = onlActCd;
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
