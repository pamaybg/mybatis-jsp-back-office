/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: MktEventTriggerCustNmResDto.java
 * 2. Package	: com.icignal.marketing.common.eventTrigger.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 9. 22. 오전 11:34:16
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 9. 22.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.marketing.common.eventTrigger.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: MktEventTriggerCustNmResDto
 * 2. 파일명	: MktEventTriggerCustNmResDto.java
 * 3. 패키지명	: com.icignal.marketing.common.eventTrigger.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 9. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@PersonalData
public class MktEventTriggerCustNmResDto extends GridPagingItemResDto{
	@Decrypted(masked="none")
	private String custNm;

	public String getCustNm() {
		return custNm;
	}

	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	
}
