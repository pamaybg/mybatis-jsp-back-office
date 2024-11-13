/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionKpiDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 26. 오전 8:58:23
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 26.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyPromotionKpiDetailReqDto
 * 2. 파일명	: LoyPromotionKpiDetailReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionKpiDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String promRid;
	private String promKpiCd;
	private String cntrlGrpCd;
	private String tgtGrpCntrlRid;
	private String kpiDateTypeCd;
	private String dateVal;
	private String kpiOfrCostCd;
	private Integer kpiOfrCostAmt;
	private Integer etcCostAmt;
	private String etcCostDesc;
	private String manProfitCd;
	private Integer manProfitAmt;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getPromKpiCd() {
		return promKpiCd;
	}
	public void setPromKpiCd(String promKpiCd) {
		this.promKpiCd = promKpiCd;
	}
	public String getCntrlGrpCd() {
		return cntrlGrpCd;
	}
	public void setCntrlGrpCd(String cntrlGrpCd) {
		this.cntrlGrpCd = cntrlGrpCd;
	}
	public String getTgtGrpCntrlRid() {
		return tgtGrpCntrlRid;
	}
	public void setTgtGrpCntrlRid(String tgtGrpCntrlRid) {
		this.tgtGrpCntrlRid = tgtGrpCntrlRid;
	}
	public String getKpiDateTypeCd() {
		return kpiDateTypeCd;
	}
	public void setKpiDateTypeCd(String kpiDateTypeCd) {
		this.kpiDateTypeCd = kpiDateTypeCd;
	}
	public String getDateVal() {
		return dateVal;
	}
	public void setDateVal(String dateVal) {
		this.dateVal = dateVal;
	}
	public String getKpiOfrCostCd() {
		return kpiOfrCostCd;
	}
	public void setKpiOfrCostCd(String kpiOfrCostCd) {
		this.kpiOfrCostCd = kpiOfrCostCd;
	}
	public String getEtcCostDesc() {
		return etcCostDesc;
	}
	public void setEtcCostDesc(String etcCostDesc) {
		this.etcCostDesc = etcCostDesc;
	}
	public String getManProfitCd() {
		return manProfitCd;
	}
	public void setManProfitCd(String manProfitCd) {
		this.manProfitCd = manProfitCd;
	}
	public Integer getKpiOfrCostAmt() {
		return kpiOfrCostAmt;
	}
	public void setKpiOfrCostAmt(Integer kpiOfrCostAmt) {
		this.kpiOfrCostAmt = kpiOfrCostAmt;
	}
	public Integer getEtcCostAmt() {
		return etcCostAmt;
	}
	public void setEtcCostAmt(Integer etcCostAmt) {
		this.etcCostAmt = etcCostAmt;
	}
	public Integer getManProfitAmt() {
		return manProfitAmt;
	}
	public void setManProfitAmt(Integer manProfitAmt) {
		this.manProfitAmt = manProfitAmt;
	}
	
	
}
