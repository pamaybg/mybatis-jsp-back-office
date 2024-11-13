/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionRuleDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 1. 오후 3:26:48
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 1.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyPromotionRuleDetailReqDto
 * 2. 파일명	: LoyPromotionRuleDetailReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 1.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionRuleDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String promRid;
	private String promTypeLv1Cd;
	private String promTypeLv2Cd;
	private String ofrRid;
	private String promOfferAmtDefCd;
	private String tgtGrpRid;
	private String expectTgtGrpRid;
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
	public String getTgtGrpRid() {
		return tgtGrpRid;
	}
	public void setTgtGrpRid(String tgtGrpRid) {
		this.tgtGrpRid = tgtGrpRid;
	}
	public String getExpectTgtGrpRid() {
		return expectTgtGrpRid;
	}
	public void setExpectTgtGrpRid(String expectTgtGrpRid) {
		this.expectTgtGrpRid = expectTgtGrpRid;
	}

	
	
}
