/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustAgreHistListReqDto.java
 * 2. Package	: com.icignal.loyalty.customer.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 6. 오전 10:06:31
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 6.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyCustAgreHistListReqDto
 * 2. 파일명	: LoyCustAgreHistListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.customer.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyCustAgreHistListReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String agreTypeCd;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getAgreTypeCd() {
		return agreTypeCd;
	}
	public void setAgreTypeCd(String agreTypeCd) {
		this.agreTypeCd = agreTypeCd;
	}
	
	
}
