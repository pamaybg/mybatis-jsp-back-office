/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlGrpDetailResDto.java
 * 2. Package	: com.icignal.loyalty.chnlgrp.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 14. 오후 5:31:44
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 14.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.chnlgrp.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyChnlGrpDetailResDto
 * 2. 파일명	: LoyChnlGrpDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.chnlgrp.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 14.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyChnlGrpDetailResDto extends StatusResDto{
	private String rid;
	private String tgtGrpNo;
	private String tgtGrpNm;
	private String descText;
	private String tgtTypeCd;
	private String statCd;
	private String conVal;
	private String conFld;
	private String grpCnt;
	private String dsRid;
	private String dsNm;
	
	
	public String getDsRid() {
		return dsRid;
	}
	public void setDsRid(String dsRid) {
		this.dsRid = dsRid;
	}
	public String getDsNm() {
		return dsNm;
	}
	public void setDsNm(String dsNm) {
		this.dsNm = dsNm;
	}
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
	public String getConVal() {
		return conVal;
	}
	public void setConVal(String conVal) {
		this.conVal = conVal;
	}
	public String getConFld() {
		return conFld;
	}
	public void setConFld(String conFld) {
		this.conFld = conFld;
	}
	public String getGrpCnt() {
		return grpCnt;
	}
	public void setGrpCnt(String grpCnt) {
		this.grpCnt = grpCnt;
	}
	
	
}
