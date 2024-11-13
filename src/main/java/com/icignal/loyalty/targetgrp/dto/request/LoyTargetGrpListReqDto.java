/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTargetGrpListReqDto.java
 * 2. Package	: com.icignal.loyalty.targetgrp.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 9. 오후 3:34:44
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 9.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.targetgrp.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyTargetGrpListReqDto
 * 2. 파일명	: LoyTargetGrpListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.targetgrp.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyTargetGrpListReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String tgtGrpRid;

	
	
	public String getTgtGrpRid() {
		return tgtGrpRid;
	}

	public void setTgtGrpRid(String tgtGrpRid) {
		this.tgtGrpRid = tgtGrpRid;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}
	
	
}
