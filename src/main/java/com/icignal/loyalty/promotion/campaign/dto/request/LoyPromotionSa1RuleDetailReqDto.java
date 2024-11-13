/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionSa1RuleDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 1. 오후 3:30:53
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 1.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.request;

import java.util.ArrayList;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyPromotionSa1RuleDetailReqDto
 * 2. 파일명	: LoyPromotionSa1RuleDetailReqDto.java
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

public class LoyPromotionSa1RuleDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String chnlTgtGrpRid;
	private String payMethTypeCd;
	private String prodTgtGrpRid;
	private String prodTgtGrpRid2;
	private String prodGrpAllYn;
	private String promRid;
	private String chnlConYn;
	private String payMethYn;
	private String prodConYn;
	private String sellAmtOfrYn;
	private String prulSa1GenRid;
	private String promTypeLv2Cd;
	private String promTypeLv1Cd;
	private String prePromTypeLv1Cd;
	private String prePromTypeLv2Cd;
	
	private ArrayList<LoyPromotionSa1XmRuleDetailReqDto> promotionSalXmRuleDetail;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlTgtGrpRid() {
		return chnlTgtGrpRid;
	}
	public void setChnlTgtGrpRid(String chnlTgtGrpRid) {
		this.chnlTgtGrpRid = chnlTgtGrpRid;
	}
	public String getPayMethTypeCd() {
		return payMethTypeCd;
	}
	public void setPayMethTypeCd(String payMethTypeCd) {
		this.payMethTypeCd = payMethTypeCd;
	}
	public String getProdTgtGrpRid() {
		return prodTgtGrpRid;
	}
	public void setProdTgtGrpRid(String prodTgtGrpRid) {
		this.prodTgtGrpRid = prodTgtGrpRid;
	}
	public String getProdTgtGrpRid2() {
		return prodTgtGrpRid2;
	}
	public void setProdTgtGrpRid2(String prodTgtGrpRid2) {
		this.prodTgtGrpRid2 = prodTgtGrpRid2;
	}
	public String getProdGrpAllYn() {
		return prodGrpAllYn;
	}
	public void setProdGrpAllYn(String prodGrpAllYn) {
		this.prodGrpAllYn = prodGrpAllYn;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getChnlConYn() {
		return chnlConYn;
	}
	public void setChnlConYn(String chnlConYn) {
		this.chnlConYn = chnlConYn;
	}
	public String getPayMethYn() {
		return payMethYn;
	}
	public void setPayMethYn(String payMethYn) {
		this.payMethYn = payMethYn;
	}
	public String getProdConYn() {
		return prodConYn;
	}
	public void setProdConYn(String prodConYn) {
		this.prodConYn = prodConYn;
	}
	public String getSellAmtOfrYn() {
		return sellAmtOfrYn;
	}
	public void setSellAmtOfrYn(String sellAmtOfrYn) {
		this.sellAmtOfrYn = sellAmtOfrYn;
	}
	public ArrayList<LoyPromotionSa1XmRuleDetailReqDto> getPromotionSalXmRuleDetail() {
		return promotionSalXmRuleDetail;
	}
	public void setPromotionSalXmRuleDetail(ArrayList<LoyPromotionSa1XmRuleDetailReqDto> promotionSalXmRuleDetail) {
		this.promotionSalXmRuleDetail = promotionSalXmRuleDetail;
	}
	public String getPrulSa1GenRid() {
		return prulSa1GenRid;
	}
	public void setPrulSa1GenRid(String prulSa1GenRid) {
		this.prulSa1GenRid = prulSa1GenRid;
	}
	public String getPromTypeLv2Cd() {
		return promTypeLv2Cd;
	}
	public void setPromTypeLv2Cd(String promTypeLv2Cd) {
		this.promTypeLv2Cd = promTypeLv2Cd;
	}
	public String getPromTypeLv1Cd() {
		return promTypeLv1Cd;
	}
	public void setPromTypeLv1Cd(String promTypeLv1Cd) {
		this.promTypeLv1Cd = promTypeLv1Cd;
	}
	public String getPrePromTypeLv1Cd() {
		return prePromTypeLv1Cd;
	}
	public void setPrePromTypeLv1Cd(String prePromTypeLv1Cd) {
		this.prePromTypeLv1Cd = prePromTypeLv1Cd;
	}
	public String getPrePromTypeLv2Cd() {
		return prePromTypeLv2Cd;
	}
	public void setPrePromTypeLv2Cd(String prePromTypeLv2Cd) {
		this.prePromTypeLv2Cd = prePromTypeLv2Cd;
	}
	
	
	
}
