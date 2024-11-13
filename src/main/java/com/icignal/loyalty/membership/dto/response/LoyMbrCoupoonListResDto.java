/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrTxnHistListResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 11. 오후 5:50:13
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 11.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyMbrTxnHistListResDto
 * 2. 파일명	: LoyMbrTxnHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 11.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyMbrCoupoonListResDto extends GridPagingItemResDto{
	private String rid;
	private String sellDate;
	
	private String intDomTypeCd;
	@MarkName(groupCode="INT_DOM_TYPE_CD",codeField="intDomTypeCd")
	private String intDomTypeCdNm;
	
	private String sellTypeCd;
	@MarkName(groupCode="AIR_SELL_TYPE_CD",codeField="sellTypeCd")
	private String sellTypeCdNm;
	
	private String dirPasTypeCd;
	@MarkName(groupCode="DIR_PAS_TYPE_CD",codeField="dirPasTypeCd")
	private String dirPasTypeCdNm;
	
	private String routeTypeCd;
	private String flightNo;
	private String onbrdDate;
	private String seatNo;
	private String sellAmt;
	private String tickNo;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSellDate() {
		return sellDate;
	}
	public void setSellDate(String sellDate) {
		this.sellDate = sellDate;
	}
	public String getIntDomTypeCd() {
		return intDomTypeCd;
	}
	public void setIntDomTypeCd(String intDomTypeCd) {
		this.intDomTypeCd = intDomTypeCd;
	}
	public String getIntDomTypeCdNm() {
		return intDomTypeCdNm;
	}
	public void setIntDomTypeCdNm(String intDomTypeCdNm) {
		this.intDomTypeCdNm = intDomTypeCdNm;
	}
	public String getSellTypeCd() {
		return sellTypeCd;
	}
	public void setSellTypeCd(String sellTypeCd) {
		this.sellTypeCd = sellTypeCd;
	}
	public String getSellTypeCdNm() {
		return sellTypeCdNm;
	}
	public void setSellTypeCdNm(String sellTypeCdNm) {
		this.sellTypeCdNm = sellTypeCdNm;
	}
	public String getDirPasTypeCd() {
		return dirPasTypeCd;
	}
	public void setDirPasTypeCd(String dirPasTypeCd) {
		this.dirPasTypeCd = dirPasTypeCd;
	}
	public String getDirPasTypeCdNm() {
		return dirPasTypeCdNm;
	}
	public void setDirPasTypeCdNm(String dirPasTypeCdNm) {
		this.dirPasTypeCdNm = dirPasTypeCdNm;
	}
	public String getRouteTypeCd() {
		return routeTypeCd;
	}
	public void setRouteTypeCd(String routeTypeCd) {
		this.routeTypeCd = routeTypeCd;
	}
	public String getFlightNo() {
		return flightNo;
	}
	public void setFlightNo(String flightNo) {
		this.flightNo = flightNo;
	}
	public String getOnbrdDate() {
		return onbrdDate;
	}
	public void setOnbrdDate(String onbrdDate) {
		this.onbrdDate = onbrdDate;
	}
	public String getSeatNo() {
		return seatNo;
	}
	public void setSeatNo(String seatNo) {
		this.seatNo = seatNo;
	}
	public String getSellAmt() {
		return sellAmt;
	}
	public void setSellAmt(String sellAmt) {
		this.sellAmt = sellAmt;
	}
	public String getTickNo() {
		return tickNo;
	}
	public void setTickNo(String tickNo) {
		this.tickNo = tickNo;
	}
	
	
	
}
