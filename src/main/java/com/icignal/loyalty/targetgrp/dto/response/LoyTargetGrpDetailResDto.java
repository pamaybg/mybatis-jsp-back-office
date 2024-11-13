/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTargetGrpDetailResDto.java
 * 2. Package	: com.icignal.loyalty.targetgrp.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 13. 오전 10:17:01
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 13.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.targetgrp.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: LoyTargetGrpDetailResDto
 * 2. 파일명	: LoyTargetGrpDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.targetgrp.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyTargetGrpDetailResDto extends GridPagingItemResDto{
	private String rid;
	private String tgtGrpNo;
	private String tgtGrpNm;
	private String descText;
	private String tgtTypeCd;
	private String statCd;
	private String srcTypeCd;
	private String conView;
	private String grpCnt;
	private String refVal;
	private String targetGroupRid;
	private String tgtGroupNm;
	private String dsRid;
	
	
	
	public String getDsRid() {
		return dsRid;
	}
	public void setDsRid(String dsRid) {
		this.dsRid = dsRid;
	}
	public String getTgtGroupNm() {
		return tgtGroupNm;
	}
	public void setTgtGroupNm(String tgtGroupNm) {
		this.tgtGroupNm = tgtGroupNm;
	}
	public String getTargetGroupRid() {
		return targetGroupRid;
	}
	public void setTargetGroupRid(String targetGroupRid) {
		this.targetGroupRid = targetGroupRid;
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
	public String getSrcTypeCd() {
		return srcTypeCd;
	}
	public void setSrcTypeCd(String srcTypeCd) {
		this.srcTypeCd = srcTypeCd;
	}
	public String getConView() {
		return conView;
	}
	public void setConView(String conView) {
		this.conView = conView;
	}
	public String getGrpCnt() {
		return grpCnt;
	}
	public void setGrpCnt(String grpCnt) {
		this.grpCnt = grpCnt;
	}
	public String getRefVal() {
		return refVal;
	}
	public void setRefVal(String refVal) {
		this.refVal = refVal;
	}
	
	
}
