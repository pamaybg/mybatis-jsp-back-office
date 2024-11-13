/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBalckMbrDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.blackTxnRule.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 6. 오전 10:26:18
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 6.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackTxnRule.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyBalckMbrDetailReqDto
 * 2. 파일명	: LoyBalckMbrDetailReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.blackTxnRule.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyBalckMbrDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String mbrRid;
	private String contents;
	private String statCd;
	private String blackMstRid;
	private int periodMm;
	private String blackTxnRid;
	
	
	public String getBlackTxnRid() {
		return blackTxnRid;
	}
	public void setBlackTxnRid(String blackTxnRid) {
		this.blackTxnRid = blackTxnRid;
	}
	
	public int getPeriodMm() {
		return periodMm;
	}
	public void setPeriodMm(int periodMm) {
		this.periodMm = periodMm;
	}
	public String getBlackMstRid() {
		return blackMstRid;
	}
	public void setBlackMstRid(String blackMstRid) {
		this.blackMstRid = blackMstRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	
	
}
