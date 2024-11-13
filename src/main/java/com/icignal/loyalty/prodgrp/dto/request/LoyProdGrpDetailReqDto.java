/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProdGrpDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.prodgrp.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 13. 오후 6:01:38
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 13.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.prodgrp.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyProdGrpDetailReqDto
 * 2. 파일명	: LoyProdGrpDetailReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.prodgrp.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyProdGrpDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String tgtGrpNo;
	private String tgtGrpNm;
	private String descText;
	private String tgtTypeCd;
	private String statCd;
	private String grpCnt;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTgtGrpNo() {
		return tgtGrpNo;
	}
	public void setTgtGrpNo(String tgtGrpNo) {
		this.tgtGrpNo = tgtGrpNo;
	}
	public String getTgtGrpNm() {
		return tgtGrpNm;
	}
	public void setTgtGrpNm(String tgtGrpNm) {
		this.tgtGrpNm = tgtGrpNm;
	}
	public String getDescText() {
		return descText;
	}
	public void setDescText(String descText) {
		this.descText = descText;
	}
	public String getTgtTypeCd() {
		return tgtTypeCd;
	}
	public void setTgtTypeCd(String tgtTypeCd) {
		this.tgtTypeCd = tgtTypeCd;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getGrpCnt() {
		return grpCnt;
	}
	public void setGrpCnt(String grpCnt) {
		this.grpCnt = grpCnt;
	}
	
	
}
