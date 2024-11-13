/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromMbrCalcExcelListResDto.java
 * 2. Package	: com.icignal.loyalty.promreaction.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 15. 오후 1:28:30
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promreaction.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyPromMbrCalcExcelListResDto
 * 2. 파일명	: LoyPromMbrCalcExcelListResDto.java
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
@PersonalData
@CommCode
public class LoyPromMbrCalcExcelListResDto extends GridPagingItemResDto{
	private String rid;
	private String mbrNo;
	private String custNo;
	@Decrypted(masked="none")
	private String custNm;
	private String calcDate;
	private String ofrRid;
	private String ofrNm;
	private String ofrAmtType;
	@MarkName(groupCode="PROM_ACT_AMT_TYPE", codeField="ofrAmtType")
	private String ofrAmtTypeNm;
	private String ofrAmt;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getCalcDate() {
		return calcDate;
	}
	public void setCalcDate(String calcDate) {
		this.calcDate = calcDate;
	}
	public String getOfrRid() {
		return ofrRid;
	}
	public void setOfrRid(String ofrRid) {
		this.ofrRid = ofrRid;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getOfrAmtType() {
		return ofrAmtType;
	}
	public void setOfrAmtType(String ofrAmtType) {
		this.ofrAmtType = ofrAmtType;
	}
	public String getOfrAmt() {
		return ofrAmt;
	}
	public void setOfrAmt(String ofrAmt) {
		this.ofrAmt = ofrAmt;
	}
	public String getOfrAmtTypeNm() {
		return ofrAmtTypeNm;
	}
	public void setOfrAmtTypeNm(String ofrAmtTypeNm) {
		this.ofrAmtTypeNm = ofrAmtTypeNm;
	}
	
	
}
