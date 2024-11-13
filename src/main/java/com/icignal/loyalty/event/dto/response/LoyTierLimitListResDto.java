/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierLimitListResDto.java
 * 2. Package	: com.icignal.loyalty.event.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 27. 오후 4:01:42
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 27.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: LoyTierLimitListResDto
 * 2. 파일명	: LoyTierLimitListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.event.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyTierLimitListResDto extends GridPagingItemResDto{
	private String rid;
	private String tierCd;
	private String tierNm;
	private String createDate;
	private String createByNm;
	private String tiersGrpNm;
	
	
	public String getTiersGrpNm() {
		return tiersGrpNm;
	}
	public void setTiersGrpNm(String tiersGrpNm) {
		this.tiersGrpNm = tiersGrpNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTierCd() {
		return tierCd;
	}
	public void setTierCd(String tierCd) {
		this.tierCd = tierCd;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateByNm() {
		return createByNm;
	}
	public void setCreateByNm(String createByNm) {
		this.createByNm = createByNm;
	}
	
	
}
