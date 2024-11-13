/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrEventHistListResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 10. 오후 7:01:36
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 10.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyMbrEventHistListResDto
 * 2. 파일명	: LoyMbrEventHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyMbrEventHistListResDto extends GridPagingItemResDto{
	private String rid;
	private String evtNm;
	private String evtTypeCd;
	@MarkName(groupCode="EVT_TYPE_CD",codeField="evtTypeCd")
	private String evtTypeCdNm;
	private String applctDt;
	private String winYn;
	private String bnfNo;
	private String applyStartDt;
	private String applyEndDt;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getEvtNm() {
		return evtNm;
	}
	public void setEvtNm(String evtNm) {
		this.evtNm = evtNm;
	}
	public String getEvtTypeCd() {
		return evtTypeCd;
	}
	public void setEvtTypeCd(String evtTypeCd) {
		this.evtTypeCd = evtTypeCd;
	}
	public String getApplctDt() {
		return applctDt;
	}
	public void setApplctDt(String applctDt) {
		this.applctDt = applctDt;
	}
	public String getWinYn() {
		return winYn;
	}
	public void setWinYn(String winYn) {
		this.winYn = winYn;
	}
	public String getBnfNo() {
		return bnfNo;
	}
	public void setBnfNo(String bnfNo) {
		this.bnfNo = bnfNo;
	}
	public String getEvtTypeCdNm() {
		return evtTypeCdNm;
	}
	public void setEvtTypeCdNm(String evtTypeCdNm) {
		this.evtTypeCdNm = evtTypeCdNm;
	}
	public String getApplyStartDt() {
		return applyStartDt;
	}
	public void setApplyStartDt(String applyStartDt) {
		this.applyStartDt = applyStartDt;
	}
	public String getApplyEndDt() {
		return applyEndDt;
	}
	public void setApplyEndDt(String applyEndDt) {
		this.applyEndDt = applyEndDt;
	}
	

}
