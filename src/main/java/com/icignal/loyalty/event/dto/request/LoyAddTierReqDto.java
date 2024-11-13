/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyAddTierReqDto.java
 * 2. Package	: com.icignal.loyalty.event.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 10. 7. 오전 9:45:46
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 10. 7.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.event.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyAddTierReqDto
 * 2. 파일명	: LoyAddTierReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.event.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 10. 7.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyAddTierReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String tierRid;
	private String eventRid;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTierRid() {
		return tierRid;
	}
	public void setTierRid(String tierRid) {
		this.tierRid = tierRid;
	}
	public String getEventRid() {
		return eventRid;
	}
	public void setEventRid(String eventRid) {
		this.eventRid = eventRid;
	}
	
	
}
