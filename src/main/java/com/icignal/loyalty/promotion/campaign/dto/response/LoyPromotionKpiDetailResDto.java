/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionKpiDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 26. 오전 9:41:19
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 26.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyPromotionKpiDetailResDto
 * 2. 파일명	: LoyPromotionKpiDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionKpiDetailResDto extends StatusResDto{
	private String rid;
	private String promRid;
	private String promKpiCd;
	private String cntrlGrpCd;
	private String tgtGrpCntrlRid;
	private String kpiDateTypeCd;
	private String dateVal;
	private String kpiOfrCostCd;
	private String kpiOfrCostAmt;
	private String etcCostAmt;
	private String etcCostDesc;
	private String manProfitCd;
	private String manProfitAmt;
	private String tgtGrpNo;
	private String tgtGrpNm;
	
	
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
	public String getKpiOfrCostAmt() {
		return kpiOfrCostAmt;
	}
	public void setKpiOfrCostAmt(String kpiOfrCostAmt) {
		this.kpiOfrCostAmt = kpiOfrCostAmt;
	}
	public String getEtcCostAmt() {
		return etcCostAmt;
	}
	public void setEtcCostAmt(String etcCostAmt) {
		this.etcCostAmt = etcCostAmt;
	}
	public String getManProfitAmt() {
		return manProfitAmt;
	}
	public void setManProfitAmt(String manProfitAmt) {
		this.manProfitAmt = manProfitAmt;
	}
	
}	
