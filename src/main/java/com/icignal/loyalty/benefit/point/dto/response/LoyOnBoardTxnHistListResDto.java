/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyOnBoardTxnHistListResDto.java
 * 2. Package	: com.icignal.loyalty.benefit.point.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 12. 오전 11:16:15
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 12.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.benefit.point.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyOnBoardTxnHistListResDto
 * 2. 파일명	: LoyOnBoardTxnHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.benefit.point.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 12.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyOnBoardTxnHistListResDto extends GridPagingItemResDto{
	private String rid;
	private String Bdate;
	private String airType;
	@MarkName(groupCode="INT_DOM_TYPE_CD ",codeField="airType")
	private String airTypeNm;
	private String desti;
	private String flight;
	private String seatclass;
	private String mile;
	private String b_cnt;
	private String ticket;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getBdate() {
		return Bdate;
	}
	public void setBdate(String bdate) {
		Bdate = bdate;
	}
	public String getAirType() {
		return airType;
	}
	public void setAirType(String airType) {
		this.airType = airType;
	}
	public String getDesti() {
		return desti;
	}
	public void setDesti(String desti) {
		this.desti = desti;
	}
	public String getFlight() {
		return flight;
	}
	public void setFlight(String flight) {
		this.flight = flight;
	}
	public String getSeatclass() {
		return seatclass;
	}
	public void setSeatclass(String seatclass) {
		this.seatclass = seatclass;
	}
	public String getMile() {
		return mile;
	}
	public void setMile(String mile) {
		this.mile = mile;
	}
	public String getB_cnt() {
		return b_cnt;
	}
	public void setB_cnt(String b_cnt) {
		this.b_cnt = b_cnt;
	}
	public String getTicket() {
		return ticket;
	}
	public void setTicket(String ticket) {
		this.ticket = ticket;
	}
	
	

}
