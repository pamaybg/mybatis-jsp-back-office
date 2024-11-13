/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackRuleDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.blackTxnRule.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 5. 오후 4:50:22
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 5.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackTxnRule.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyBlackRuleDetailReqDto
 * 2. 파일명	: LoyBlackRuleDetailReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.blackTxnRule.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyBlackRuleDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String basType;
	private String gtOrEt;
	private String basDayCnt;
	private String basDayMmCd;
	private String basDayMmCdNm;
	private String blackRuleRid;
	private String blackMstRid;
	private String basTypeNm;
	private String ofrNo;
	private String dsRid;
	private String dsItemRid;
	
	
	public String getBasDayMmCdNm() {
		return basDayMmCdNm;
	}
	public void setBasDayMmCdNm(String basDayMmCdNm) {
		this.basDayMmCdNm = basDayMmCdNm;
	}
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
	public String getDsRid() {
		return dsRid;
	}
	public void setDsRid(String dsRid) {
		this.dsRid = dsRid;
	}
	public String getDsItemRid() {
		return dsItemRid;
	}
	public void setDsItemRid(String dsItemRid) {
		this.dsItemRid = dsItemRid;
	}
	public String getBasTypeNm() {
		return basTypeNm;
	}
	public void setBasTypeNm(String basTypeNm) {
		this.basTypeNm = basTypeNm;
	}
	public String getBlackMstRid() {
		return blackMstRid;
	}
	public void setBlackMstRid(String blackMstRid) {
		this.blackMstRid = blackMstRid;
	}
	public String getBlackRuleRid() {
		return blackRuleRid;
	}
	public void setBlackRuleRid(String blackRuleRid) {
		this.blackRuleRid = blackRuleRid;
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
