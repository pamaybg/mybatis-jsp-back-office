/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionSa1RuleDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 1. 오후 6:13:20
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 1.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import java.util.ArrayList;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyPromotionSa1RuleDetailResDto
 * 2. 파일명	: LoyPromotionSa1RuleDetailResDto.java
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

public class LoyPromotionSa1RuleDetailResDto extends StatusResDto{
	private String rid;
	private String chnlTgtGrpRid;
	private String chnlTgtGrpNm;
	private String chnlTgtGrpNo;
	private String payMethTypeCd;
	private String prodTgtGrpRid;
	private String prodTgtGrpNm;
	private String prodTgtGrpNo;
	private String prodTgtGrpRid2;
	private String prodTgtGrpNm2;
	private String prodTgtGrpNo2;
	private String prodGrpAllYn;
	private String promRid;
	private String chnlConYn;
	private String payMethYn;
	private String prodConYn;
	private String sellAmtOfrYn;
	private String prulSa1GenRid;
	private String modifyDate;
	
	private ArrayList<LoyPromotionSa1XmRuleDetailResDto> promotionSalXmRuleDetail;

	
	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

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

	public String getChnlTgtGrpNm() {
		return chnlTgtGrpNm;
	}

	public void setChnlTgtGrpNm(String chnlTgtGrpNm) {
		this.chnlTgtGrpNm = chnlTgtGrpNm;
	}

	public String getChnlTgtGrpNo() {
		return chnlTgtGrpNo;
	}

	public void setChnlTgtGrpNo(String chnlTgtGrpNo) {
		this.chnlTgtGrpNo = chnlTgtGrpNo;
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

	public String getProdTgtGrpNm() {
		return prodTgtGrpNm;
	}

	public void setProdTgtGrpNm(String prodTgtGrpNm) {
		this.prodTgtGrpNm = prodTgtGrpNm;
	}

	public String getProdTgtGrpNo() {
		return prodTgtGrpNo;
	}

	public void setProdTgtGrpNo(String prodTgtGrpNo) {
		this.prodTgtGrpNo = prodTgtGrpNo;
	}

	public String getProdTgtGrpRid2() {
		return prodTgtGrpRid2;
	}

	public void setProdTgtGrpRid2(String prodTgtGrpRid2) {
		this.prodTgtGrpRid2 = prodTgtGrpRid2;
	}

	public String getProdTgtGrpNm2() {
		return prodTgtGrpNm2;
	}

	public void setProdTgtGrpNm2(String prodTgtGrpNm2) {
		this.prodTgtGrpNm2 = prodTgtGrpNm2;
	}

	public String getProdTgtGrpNo2() {
		return prodTgtGrpNo2;
	}

	public void setProdTgtGrpNo2(String prodTgtGrpNo2) {
		this.prodTgtGrpNo2 = prodTgtGrpNo2;
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

	public ArrayList<LoyPromotionSa1XmRuleDetailResDto> getPromotionSalXmRuleDetail() {
		return promotionSalXmRuleDetail;
	}

	public void setPromotionSalXmRuleDetail(ArrayList<LoyPromotionSa1XmRuleDetailResDto> promotionSalXmRuleDetail) {
		this.promotionSalXmRuleDetail = promotionSalXmRuleDetail;
	}

	public String getPrulSa1GenRid() {
		return prulSa1GenRid;
	}

	public void setPrulSa1GenRid(String prulSa1GenRid) {
		this.prulSa1GenRid = prulSa1GenRid;
	}
	
	
}
