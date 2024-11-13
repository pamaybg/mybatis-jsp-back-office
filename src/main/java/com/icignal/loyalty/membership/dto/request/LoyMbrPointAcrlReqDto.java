/*
 * Copyright 2016-2021 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrPointAcrlReqDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.request
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2021. 8. 2. 오전 9:23:34
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2021. 8. 2.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyMbrPointAcrlReqDto
 * 2. 파일명	: LoyMbrPointAcrlReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.request
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2021. 8. 2.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyMbrPointAcrlReqDto extends CommonDataAuthReqDto{
	private String acrlRid;
	private String validStartDate;
	private String validEndDate;
	private String acrlDesc;
	public String getAcrlRid() {
		return acrlRid;
	}
	public void setAcrlRid(String acrlRid) {
		this.acrlRid = acrlRid;
	}
	public String getValidStartDate() {
		return validStartDate;
	}
	public void setValidStartDate(String validStartDate) {
		this.validStartDate = validStartDate;
	}
	public String getValidEndDate() {
		return validEndDate;
	}
	public void setValidEndDate(String validEndDate) {
		this.validEndDate = validEndDate;
	}
	public String getAcrlDesc() {
		return acrlDesc;
	}
	public void setAcrlDesc(String acrlDesc) {
		this.acrlDesc = acrlDesc;
	}

	
}
