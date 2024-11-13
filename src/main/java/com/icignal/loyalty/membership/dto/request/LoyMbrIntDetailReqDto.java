/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrIntDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 12. 오전 10:47:38
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 12.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyMbrIntDetailReqDto
 * 2. 파일명	: LoyMbrIntDetailReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 12.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyMbrIntDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String intRidMbr;
	private String prevMbrRid;
	private String mbrIntCode;
	private String p_Rst;
	private String p_RstMsg;
	private String p_RstCd;
	private String repYn;
	private String ridMbr;
	
	
	
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRepYn() {
		return repYn;
	}
	public void setRepYn(String repYn) {
		this.repYn = repYn;
	}
	public String getPrevMbrRid() {
		return prevMbrRid;
	}
	public void setPrevMbrRid(String prevMbrRid) {
		this.prevMbrRid = prevMbrRid;
	}
	public String getMbrIntCode() {
		return mbrIntCode;
	}
	public void setMbrIntCode(String mbrIntCode) {
		this.mbrIntCode = mbrIntCode;
	}
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getIntRidMbr() {
		return intRidMbr;
	}
	public void setIntRidMbr(String intRidMbr) {
		this.intRidMbr = intRidMbr;
	}
	public String getP_Rst() {
		return p_Rst;
	}
	public void setP_Rst(String p_Rst) {
		this.p_Rst = p_Rst;
	}
	public String getP_RstMsg() {
		return p_RstMsg;
	}
	public void setP_RstMsg(String p_RstMsg) {
		this.p_RstMsg = p_RstMsg;
	}
	public String getP_RstCd() {
		return p_RstCd;
	}
	public void setP_RstCd(String p_RstCd) {
		this.p_RstCd = p_RstCd;
	}
	
	
}
