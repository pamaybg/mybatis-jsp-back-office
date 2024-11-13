/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionAc2ConDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 2. 오후 3:23:33
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 2.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

/*
 * 1. 클래스명	: LoyPromotionAc2ConDetailResDto
 * 2. 파일명	: LoyPromotionAc2ConDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 2.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionAc2ConDetailResDto {
	private String rid;
	private String hhpYn;
	private String emailYn;
	private String addrYn;
	private String promRid;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getHhpYn() {
		return hhpYn;
	}
	public void setHhpYn(String hhpYn) {
		this.hhpYn = hhpYn;
	}
	public String getEmailYn() {
		return emailYn;
	}
	public void setEmailYn(String emailYn) {
		this.emailYn = emailYn;
	}
	public String getAddrYn() {
		return addrYn;
	}
	public void setAddrYn(String addrYn) {
		this.addrYn = addrYn;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	
	
}
