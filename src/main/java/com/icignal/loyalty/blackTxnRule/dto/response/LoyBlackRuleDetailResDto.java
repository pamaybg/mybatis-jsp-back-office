/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackRuleDetailResDto.java
 * 2. Package	: com.icignal.loyalty.blackTxnRule.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 5. 오후 4:42:14
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 5.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackTxnRule.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyBlackRuleDetailResDto
 * 2. 파일명	: LoyBlackRuleDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.blackTxnRule.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyBlackRuleDetailResDto extends StatusResDto{
	private String rid;
	private String basType;
	private String gtOrEt;
	private String basDayCnt;
	private String basDayMmCd;
	private String dsItemRid;
	private String dsRid;
	private String ofrRid;
	private String ofrNm;
	private String ofrNo;
	private String dsNm;
	private String dsItemNm;
	
	
	public String getDsNm() {
		return dsNm;
	}
	public void setDsNm(String dsNm) {
		this.dsNm = dsNm;
	}
	public String getDsItemNm() {
		return dsItemNm;
	}
	public void setDsItemNm(String dsItemNm) {
		this.dsItemNm = dsItemNm;
	}
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getDsItemRid() {
		return dsItemRid;
	}
	public void setDsItemRid(String dsItemRid) {
		this.dsItemRid = dsItemRid;
	}
	public String getOfrRid() {
		return ofrRid;
	}
	public void setOfrRid(String ofrRid) {
		this.ofrRid = ofrRid;
	}
	public String getDsRid() {
		return dsRid;
	}
	public void setDsRid(String dsRid) {
		this.dsRid = dsRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getBasType() {
		return basType;
	}
	public void setBasType(String basType) {
		this.basType = basType;
	}
	public String getGtOrEt() {
		return gtOrEt;
	}
	public void setGtOrEt(String gtOrEt) {
		this.gtOrEt = gtOrEt;
	}
	public String getBasDayCnt() {
		return basDayCnt;
	}
	public void setBasDayCnt(String basDayCnt) {
		this.basDayCnt = basDayCnt;
	}
	public String getBasDayMmCd() {
		return basDayMmCd;
	}
	public void setBasDayMmCd(String basDayMmCd) {
		this.basDayMmCd = basDayMmCd;
	}
	
	
}
