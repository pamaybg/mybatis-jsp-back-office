/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromReactionDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promreaction.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 15. 오전 10:19:38
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promreaction.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyPromReactionDetailResDto
 * 2. 파일명	: LoyPromReactionDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promreaction.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyPromReactionDetailResDto extends StatusResDto{
	private String rid;
	private String promNo;
	private String promNm;
	private String descText;
	private String promTypeLv1Cd;
	@MarkName(groupCode="PROM_TYPE_LV1", codeField="promTypeLv1Cd")
	private String promTypeLv1CdNm;
	private String promTypeLv2Cd;
	@MarkName(groupCode="PROM_TYPE_LV2", codeField="promTypeLv2Cd")
	private String promTypeLv2CdNm;
	private String validStartDate;
	private String validEndDate;
	private String ofrNm;
	private String ofrNo;
	private String ofrRid;
	private String kpiDateTypeCd;
	@MarkName(groupCode="PROM_KPI_TYPE", codeField="kpiDateTypeCd")
	private String kpiDateTypeCdNm;
	private String respAmt;
	private String respLastDate;
	private String respCtrlAmt;
	private String respTotCost;
	private String respTotSales;
	private String respTotTgt;
	private String respTotResp;
	private String promRid;
	
	
	public String getPromTypeLv1CdNm() {
		return promTypeLv1CdNm;
	}
	public void setPromTypeLv1CdNm(String promTypeLv1CdNm) {
		this.promTypeLv1CdNm = promTypeLv1CdNm;
	}
	public String getPromTypeLv2CdNm() {
		return promTypeLv2CdNm;
	}
	public void setPromTypeLv2CdNm(String promTypeLv2CdNm) {
		this.promTypeLv2CdNm = promTypeLv2CdNm;
	}
	public String getKpiDateTypeCdNm() {
		return kpiDateTypeCdNm;
	}
	public void setKpiDateTypeCdNm(String kpiDateTypeCdNm) {
		this.kpiDateTypeCdNm = kpiDateTypeCdNm;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPromNo() {
		return promNo;
	}
	public void setPromNo(String promNo) {
		this.promNo = promNo;
	}
	public String getPromNm() {
		return promNm;
	}
	public void setPromNm(String promNm) {
		this.promNm = promNm;
	}
	public String getDescText() {
		return descText;
	}
	public void setDescText(String descText) {
		this.descText = descText;
	}
	public String getPromTypeLv1Cd() {
		return promTypeLv1Cd;
	}
	public void setPromTypeLv1Cd(String promTypeLv1Cd) {
		this.promTypeLv1Cd = promTypeLv1Cd;
	}
	public String getPromTypeLv2Cd() {
		return promTypeLv2Cd;
	}
	public void setPromTypeLv2Cd(String promTypeLv2Cd) {
		this.promTypeLv2Cd = promTypeLv2Cd;
	}
	public String getValidStartDate() {
		return validStartDate;
	}
	public void setValidStartDate(String validStartDate) {
		this.validStartDate = validStartDate;
	}
	public String getValidEndDate() {
		return validEndDate;
	}
	public void setValidEndDate(String validEndDate) {
		this.validEndDate = validEndDate;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
	public String getOfrRid() {
		return ofrRid;
	}
	public void setOfrRid(String ofrRid) {
		this.ofrRid = ofrRid;
	}
	public String getKpiDateTypeCd() {
		return kpiDateTypeCd;
	}
	public void setKpiDateTypeCd(String kpiDateTypeCd) {
		this.kpiDateTypeCd = kpiDateTypeCd;
	}
	public String getRespAmt() {
		return respAmt;
	}
	public void setRespAmt(String respAmt) {
		this.respAmt = respAmt;
	}
	public String getRespLastDate() {
		return respLastDate;
	}
	public void setRespLastDate(String respLastDate) {
		this.respLastDate = respLastDate;
	}
	public String getRespCtrlAmt() {
		return respCtrlAmt;
	}
	public void setRespCtrlAmt(String respCtrlAmt) {
		this.respCtrlAmt = respCtrlAmt;
	}
	public String getRespTotCost() {
		return respTotCost;
	}
	public void setRespTotCost(String respTotCost) {
		this.respTotCost = respTotCost;
	}
	public String getRespTotSales() {
		return respTotSales;
	}
	public void setRespTotSales(String respTotSales) {
		this.respTotSales = respTotSales;
	}
	public String getRespTotTgt() {
		return respTotTgt;
	}
	public void setRespTotTgt(String respTotTgt) {
		this.respTotTgt = respTotTgt;
	}
	public String getRespTotResp() {
		return respTotResp;
	}
	public void setRespTotResp(String respTotResp) {
		this.respTotResp = respTotResp;
	}
	
	
}
