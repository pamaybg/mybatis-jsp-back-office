/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierGrpDsMasterReqDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 3. 오후 1:42:09
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 3.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyTierGrpDsMasterReqDto
 * 2. 파일명	: LoyTierGrpDsMasterReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyTierGrpDsMasterReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String tierGrpJobRid;
	private String dsRid;
	private String extRange;
	private String dsItemRid;
	private String tierBatchJobCd;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTierGrpJobRid() {
		return tierGrpJobRid;
	}
	public void setTierGrpJobRid(String tierGrpJobRid) {
		this.tierGrpJobRid = tierGrpJobRid;
	}
	public String getDsRid() {
		return dsRid;
	}
	public void setDsRid(String dsRid) {
		this.dsRid = dsRid;
	}
	public String getExtRange() {
		return extRange;
	}
	public void setExtRange(String extRange) {
		this.extRange = extRange;
	}
	public String getDsItemRid() {
		return dsItemRid;
	}
	public void setDsItemRid(String dsItemRid) {
		this.dsItemRid = dsItemRid;
	}
	public String getTierBatchJobCd() {
		return tierBatchJobCd;
	}
	public void setTierBatchJobCd(String tierBatchJobCd) {
		this.tierBatchJobCd = tierBatchJobCd;
	}
	
	
}
