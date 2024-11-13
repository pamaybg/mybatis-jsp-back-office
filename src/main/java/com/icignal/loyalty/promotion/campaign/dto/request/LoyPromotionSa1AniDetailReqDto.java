/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionSa1AniDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 2. 오전 9:56:58
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
 * 1. 클래스명	: LoyPromotionSa1AniDetailReqDto
 * 2. 파일명	: LoyPromotionSa1AniDetailReqDto.java
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

public class LoyPromotionSa1AniDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String promRid;
	private String conditionCd;
	private String operCd;
	private Integer dayVal;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getConditionCd() {
		return conditionCd;
	}
	public void setConditionCd(String conditionCd) {
		this.conditionCd = conditionCd;
	}
	public String getOperCd() {
		return operCd;
	}
	public void setOperCd(String operCd) {
		this.operCd = operCd;
	}
	public Integer getDayVal() {
		return dayVal;
	}
	public void setDayVal(Integer dayVal) {
		this.dayVal = dayVal;
	}
	
	
	
}
