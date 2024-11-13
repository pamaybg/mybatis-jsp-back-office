/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierGrpJobDetailResDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 2. 오후 6:32:12
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 2.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyTierGrpJobDetailResDto
 * 2. 파일명	: LoyTierGrpJobDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 2.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyTierGrpJobDetailResDto extends StatusResDto{
	private String rid;
	private String tierBatchJobCd;
	private String execMm;
	private String useYn;
	private String execCycle;
	
	
	public String getExecCycle() {
		return execCycle;
	}
	public void setExecCycle(String execCycle) {
		this.execCycle = execCycle;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTierBatchJobCd() {
		return tierBatchJobCd;
	}
	public void setTierBatchJobCd(String tierBatchJobCd) {
		this.tierBatchJobCd = tierBatchJobCd;
	}
	public String getExecMm() {
		return execMm;
	}
	public void setExecMm(String execMm) {
		this.execMm = execMm;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	
}
