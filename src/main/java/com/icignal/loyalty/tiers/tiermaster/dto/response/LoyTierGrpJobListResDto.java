/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierGrpJobListResDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 2. 오후 4:27:46
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 2.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyTierGrpJobListResDto
 * 2. 파일명	: LoyTierGrpJobListResDto.java
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
@CommCode
public class LoyTierGrpJobListResDto extends GridPagingItemResDto{
	private String rid;
	private String tierBatchJobCd;
	@MarkName(groupCode="LOY_TIER_BATCH_JOB_CD",codeField="tierBatchJobCd")
	private String tierBatchJobCdNm;
	private String execMm;
	private String useYn;
	private String createDate;
	private String name;
	private String execCycleCd;
	@MarkName(groupCode="LOY_TIER_BATCH_JOB_EXEC_CYLE_CD",codeField="execCycle")
	private String execCycle;
	
	
	public String getExecCycleCd() {
		return execCycleCd;
	}
	public void setExecCycleCd(String execCycleCd) {
		this.execCycleCd = execCycleCd;
	}
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
	public String getTierBatchJobCdNm() {
		return tierBatchJobCdNm;
	}
	public void setTierBatchJobCdNm(String tierBatchJobCdNm) {
		this.tierBatchJobCdNm = tierBatchJobCdNm;
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
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	

}
