/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionAc1ClbDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 3. 오전 4:33:35
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
 * 1. 클래스명	: LoyPromotionAc1ClbDetailResDto
 * 2. 파일명	: LoyPromotionAc1ClbDetailResDto.java
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

public class LoyPromotionAc1ClbDetailResDto extends StatusResDto{
	private String rid;
	private String clubNo;
	private String clubNm;
	private String promRid;
	private String clubRid;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getClubNo() {
		return clubNo;
	}
	public void setClubNo(String clubNo) {
		this.clubNo = clubNo;
	}
	public String getClubNm() {
		return clubNm;
	}
	public void setClubNm(String clubNm) {
		this.clubNm = clubNm;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getClubRid() {
		return clubRid;
	}
	public void setClubRid(String clubRid) {
		this.clubRid = clubRid;
	}
	
	
}
