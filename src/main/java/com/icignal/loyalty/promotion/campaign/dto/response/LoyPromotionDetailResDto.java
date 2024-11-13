/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 1. 오전 9:45:26
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 1.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyPromotionDetailResDto
 * 2. 파일명	: LoyPromotionDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 1.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionDetailResDto extends StatusResDto{
	private String rid;
	private String promTypeLv1Cd;
	private String promTypeLv2Cd;
	private String ofrNo;
	private String ofrNm;
	private String ofrRid;
	private String promOfferAmtDefCd;
	private String tgtGrpNo;
	private String tgtGrpNm;
	private String expectTgtGrpNo;
	private String expectTgtGrpNm;
	private String tgtRuleGrpRid;
	private String expectTgtRuleGrpRid;
	private String promStatCd;
	
	
	public String getPromStatCd() {
		return promStatCd;
	}
	public void setPromStatCd(String promStatCd) {
		this.promStatCd = promStatCd;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getOfrRid() {
		return ofrRid;
	}
	public void setOfrRid(String ofrRid) {
		this.ofrRid = ofrRid;
	}
	public String getPromOfferAmtDefCd() {
		return promOfferAmtDefCd;
	}
	public void setPromOfferAmtDefCd(String promOfferAmtDefCd) {
		this.promOfferAmtDefCd = promOfferAmtDefCd;
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
	public String getExpectTgtGrpNo() {
		return expectTgtGrpNo;
	}
	public void setExpectTgtGrpNo(String expectTgtGrpNo) {
		this.expectTgtGrpNo = expectTgtGrpNo;
	}
	public String getExpectTgtGrpNm() {
		return expectTgtGrpNm;
	}
	public void setExpectTgtGrpNm(String expectTgtGrpNm) {
		this.expectTgtGrpNm = expectTgtGrpNm;
	}
	public String getTgtRuleGrpRid() {
		return tgtRuleGrpRid;
	}
	public void setTgtRuleGrpRid(String tgtRuleGrpRid) {
		this.tgtRuleGrpRid = tgtRuleGrpRid;
	}
	public String getExpectTgtRuleGrpRid() {
		return expectTgtRuleGrpRid;
	}
	public void setExpectTgtRuleGrpRid(String expectTgtRuleGrpRid) {
		this.expectTgtRuleGrpRid = expectTgtRuleGrpRid;
	}
	
	
}
