/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrTiersDetailResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 28. 오후 7:18:51
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 28.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyMbrTiersDetailResDto
 * 2. 파일명	: LoyMbrTiersDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 28.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyMbrTiersDetailResDto extends StatusResDto{
	private String tierMnlReasonDesc;
	private String reqNm;
	private String createDate;
	private String resNm;
	private String lastApvDd;
	
	
	public String getLastApvDd() {
		return lastApvDd;
	}

	public void setLastApvDd(String lastApvDd) {
		this.lastApvDd = lastApvDd;
	}

	public String getReqNm() {
		return reqNm;
	}

	public void setReqNm(String reqNm) {
		this.reqNm = reqNm;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getResNm() {
		return resNm;
	}

	public void setResNm(String resNm) {
		this.resNm = resNm;
	}

	private LoyMbrApprovalDetailResDto aprResDto;

	public String getTierMnlReasonDesc() {
		return tierMnlReasonDesc;
	}

	public void setTierMnlReasonDesc(String tierMnlReasonDesc) {
		this.tierMnlReasonDesc = tierMnlReasonDesc;
	}

	public LoyMbrApprovalDetailResDto getAprResDto() {
		return aprResDto;
	}

	public void setAprResDto(LoyMbrApprovalDetailResDto aprResDto) {
		this.aprResDto = aprResDto;
	}
	
	
	
}
