/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBalckTxnRuleListReqDto.java
 * 2. Package	: com.icignal.loyalty.blackTxnRule.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 4. 오후 4:52:50
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 4.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackTxnRule.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyBalckTxnRuleListReqDto
 * 2. 파일명	: LoyBalckTxnRuleListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.blackTxnRule.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyBalckTxnRuleListReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String blackTxnRid;
	
	
	public String getBlackTxnRid() {
		return blackTxnRid;
	}

	public void setBlackTxnRid(String blackTxnRid) {
		this.blackTxnRid = blackTxnRid;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}
	
	
}
