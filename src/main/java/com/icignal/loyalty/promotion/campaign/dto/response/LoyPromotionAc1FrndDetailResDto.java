/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionAc1FrndDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 3. 오전 2:57:28
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 3.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyPromotionAc1FrndDetailResDto
 * 2. 파일명	: LoyPromotionAc1FrndDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionAc1FrndDetailResDto extends StatusResDto{
	private String rid;
	private String prulJoinChnlCd;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPrulJoinChnlCd() {
		return prulJoinChnlCd;
	}
	public void setPrulJoinChnlCd(String prulJoinChnlCd) {
		this.prulJoinChnlCd = prulJoinChnlCd;
	}
	
	
}
