/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProdGrpResDto.java
 * 2. Package	: com.icignal.loyalty.prodgrp.dto.response
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 12. 28. 오후 3:08:12
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 12. 28.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.prodgrp.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyProdGrpResDto
 * 2. 파일명	: LoyProdGrpResDto.java
 * 3. 패키지명	: com.icignal.loyalty.prodgrp.dto.response
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 12. 28.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyProdGrpResDto extends StatusResDto{
	private String rid;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}
	
	
}
