/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustNewReqDto.java
 * 2. Package	: com.icignal.loyalty.customer.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 4. 23. 오전 9:59:02
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 23.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyCustNewReqDto
 * 2. 파일명	: LoyCustNewReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.customer.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 4. 23.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyCustNewReqDto extends CommonDataAuthReqDto {
	/* RID */
	private String rid;
	private String custNo;
	private String userId;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getCustNo() {
		return custNo;
	}

	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}


	
	
}
