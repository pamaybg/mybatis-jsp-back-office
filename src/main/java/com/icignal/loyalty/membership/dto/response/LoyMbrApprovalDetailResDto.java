/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrApprovalDetailResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 28. 오후 7:21:28
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
 * 1. 클래스명	: LoyMbrApprovalDetailResDto
 * 2. 파일명	: LoyMbrApprovalDetailResDto.java
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

public class LoyMbrApprovalDetailResDto extends StatusResDto{
	private String approvalResNm;
	private String approvalResDate;
	private String approvalReqNm;
	private String approvalReqDate;
	public String getApprovalResNm() {
		return approvalResNm;
	}
	public void setApprovalResNm(String approvalResNm) {
		this.approvalResNm = approvalResNm;
	}
	public String getApprovalResDate() {
		return approvalResDate;
	}
	public void setApprovalResDate(String approvalResDate) {
		this.approvalResDate = approvalResDate;
	}
	public String getApprovalReqNm() {
		return approvalReqNm;
	}
	public void setApprovalReqNm(String approvalReqNm) {
		this.approvalReqNm = approvalReqNm;
	}
	public String getApprovalReqDate() {
		return approvalReqDate;
	}
	public void setApprovalReqDate(String approvalReqDate) {
		this.approvalReqDate = approvalReqDate;
	}
	
	
}
