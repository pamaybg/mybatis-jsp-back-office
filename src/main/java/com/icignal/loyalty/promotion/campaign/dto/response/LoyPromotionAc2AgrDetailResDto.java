/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionAc2AgrDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 2. 오후 3:54:47
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 2.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyPromotionAc2AgrDetailResDto
 * 2. 파일명	: LoyPromotionAc2AgrDetailResDto.java
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

public class LoyPromotionAc2AgrDetailResDto extends StatusResDto{
	private String rid;
	private String textYn;
	private String emailYn;
	private String tmYn;
	private String dmYn;
	private String pushYn;
	private String kkfYn;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTextYn() {
		return textYn;
	}
	public void setTextYn(String textYn) {
		this.textYn = textYn;
	}
	public String getEmailYn() {
		return emailYn;
	}
	public void setEmailYn(String emailYn) {
		this.emailYn = emailYn;
	}
	public String getTmYn() {
		return tmYn;
	}
	public void setTmYn(String tmYn) {
		this.tmYn = tmYn;
	}
	public String getDmYn() {
		return dmYn;
	}
	public void setDmYn(String dmYn) {
		this.dmYn = dmYn;
	}
	public String getPushYn() {
		return pushYn;
	}
	public void setPushYn(String pushYn) {
		this.pushYn = pushYn;
	}
	public String getKkfYn() {
		return kkfYn;
	}
	public void setKkfYn(String kkfYn) {
		this.kkfYn = kkfYn;
	}
	
	
}
