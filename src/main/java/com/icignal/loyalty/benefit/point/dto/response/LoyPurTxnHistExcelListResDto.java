/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPurTxnHistExcelListResDto.java
 * 2. Package	: com.icignal.loyalty.benefit.point.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 9. 오후 1:48:01
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 9.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.benefit.point.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyPurTxnHistExcelListResDto
 * 2. 파일명	: LoyPurTxnHistExcelListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.benefit.point.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

@CommCode
@PersonalData
public class LoyPurTxnHistExcelListResDto extends GridPagingItemResDto{
	private String rid;
	private String sellDate;
	
	private String intDomTypeCd;
	@MarkName(groupCode="INT_DOM_TYPE_CD",codeField="intDomTypeCd")
	private String intDomTypeCdNm;
	
	private String sellTypeCd;
	@MarkName(groupCode="SELL_TYPE_CD",codeField="sellTypeCd")
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
	@Decrypted(masked = "none")
	private String custNm;
	@Decrypted(masked = "none")
	private String hhp;
	@Decrypted(masked = "none")
	private String unMaskCustNm;
	@Decrypted(masked = "none")
	private String unMaskHhp;
	private String ridMbr;
	
	private String chnlNm;
	private String rcptNo;
	private String createDate;
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
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getUnMaskCustNm() {
		return unMaskCustNm;
	}
	public void setUnMaskCustNm(String unMaskCustNm) {
		this.unMaskCustNm = unMaskCustNm;
	}
	public String getUnMaskHhp() {
		return unMaskHhp;
	}
	public void setUnMaskHhp(String unMaskHhp) {
		this.unMaskHhp = unMaskHhp;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getRcptNo() {
		return rcptNo;
	}
	public void setRcptNo(String rcptNo) {
		this.rcptNo = rcptNo;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	
}
