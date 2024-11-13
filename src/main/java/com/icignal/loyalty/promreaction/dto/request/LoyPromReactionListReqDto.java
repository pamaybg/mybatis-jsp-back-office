/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromReactionListReqDto.java
 * 2. Package	: com.icignal.loyalty.promreaction.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 15. 오전 10:23:55
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promreaction.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyPromReactionListReqDto
 * 2. 파일명	: LoyPromReactionListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.promreaction.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

/*
 * 1. 클래스명	: LoyPromReactionListReqDto
 * 2. 파일명	: LoyPromReactionListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.promreaction.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyPromReactionListReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String promRid;

	
	public String getPromRid() {
		return promRid;
	}

	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}
	
	
}
