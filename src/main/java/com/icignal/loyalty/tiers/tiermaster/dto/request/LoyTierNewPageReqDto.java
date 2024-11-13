/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierNewPageReqDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 1. 오후 2:58:34
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 1.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyTierNewPageReqDto
 * 2. 파일명	: LoyTierNewPageReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 1.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyTierNewPageReqDto extends CommonDataAuthReqDto {
	private String rid;
	private String tierGroupRid;
	private String tierNm;
	private String tierTypeCd;
	private String seqNo;
	private String baseTierYn;
	private String tierRid;
	private Integer tiersUpKeepMm;
	private String pgmRid;
	private String tierGrpRid;
	private String execCycle;
	
	
	

	public String getExecCycle() {
		return execCycle;
	}

	public void setExecCycle(String execCycle) {
		this.execCycle = execCycle;
	}

	public String getTierGrpRid() {
		return tierGrpRid;
	}

	public void setTierGrpRid(String tierGrpRid) {
		this.tierGrpRid = tierGrpRid;
	}

	public String getPgmRid() {
		return pgmRid;
	}

	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getTierGroupRid() {
		return tierGroupRid;
	}

	public void setTierGroupRid(String tierGroupRid) {
		this.tierGroupRid = tierGroupRid;
	}

	public String getTierNm() {
		return tierNm;
	}

	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}

	public String getTierTypeCd() {
		return tierTypeCd;
	}

	public void setTierTypeCd(String tierTypeCd) {
		this.tierTypeCd = tierTypeCd;
	}

	public String getSeqNo() {
		return seqNo;
	}

	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}

	public String getBaseTierYn() {
		return baseTierYn;
	}

	public void setBaseTierYn(String baseTierYn) {
		this.baseTierYn = baseTierYn;
	}

	public String getTierRid() {
		return tierRid;
	}

	public void setTierRid(String tierRid) {
		this.tierRid = tierRid;
	}

	public Integer getTiersUpKeepMm() {
		return tiersUpKeepMm;
	}

	public void setTiersUpKeepMm(Integer tiersUpKeepMm) {
		this.tiersUpKeepMm = tiersUpKeepMm;
	}

	

}
