/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionRuleInfoResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 6. 오전 10:10:14
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 6.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyPromotionRuleInfoResDto
 * 2. 파일명	: LoyPromotionRuleInfoResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionRuleInfoResDto extends StatusResDto{
	private LoyPromotionAc1CardDetailResDto loyPrulAc1CardInfo;
	private LoyPromotionAc1ClbDetailResDto loyPrulAc1ClbInfo;
	private LoyPromotionAc1FamDetailResDto loyPrulAc1FamInfo;
	private LoyPromotionAc1FrndDetailResDto loyPrulAc1FrndInfo;
	private LoyPromotionAc1JoinDetailResDto loyPrulAc1JoinInfo;
	private LoyPromotionAc2AddDetailResDto loyPrulAc2AddInfo;
	private LoyPromotionAc2AgrDetailResDto loyPrulAc2AgrInfo;
	private LoyPromotionAc2ConDetailResDto loyPrulAc2ConInfo;
	private LoyPromotionAc2OnDetailResDto loyPrulAc2OnInfo;
	private LoyPromotionAc2SurDetailResDto loyPrulAc2SurInfo;
	private LoyPromotionSa1AniDetailResDto loyPrulSa1AniInfo;
	private LoyPromotionSa1RuleDetailResDto loyPrulSa1GenInfo;
	private LoyPromotionSa2SumDetailResDto loyPrulSa1SumInfo;
	public LoyPromotionAc1CardDetailResDto getLoyPrulAc1CardInfo() {
		return loyPrulAc1CardInfo;
	}
	public void setLoyPrulAc1CardInfo(LoyPromotionAc1CardDetailResDto loyPrulAc1CardInfo) {
		this.loyPrulAc1CardInfo = loyPrulAc1CardInfo;
	}
	public LoyPromotionAc1ClbDetailResDto getLoyPrulAc1ClbInfo() {
		return loyPrulAc1ClbInfo;
	}
	public void setLoyPrulAc1ClbInfo(LoyPromotionAc1ClbDetailResDto loyPrulAc1ClbInfo) {
		this.loyPrulAc1ClbInfo = loyPrulAc1ClbInfo;
	}
	public LoyPromotionAc1FrndDetailResDto getLoyPrulAc1FrndInfo() {
		return loyPrulAc1FrndInfo;
	}
	public void setLoyPrulAc1FrndInfo(LoyPromotionAc1FrndDetailResDto loyPrulAc1FrndInfo) {
		this.loyPrulAc1FrndInfo = loyPrulAc1FrndInfo;
	}
	public LoyPromotionAc1JoinDetailResDto getLoyPrulAc1JoinInfo() {
		return loyPrulAc1JoinInfo;
	}
	public void setLoyPrulAc1JoinInfo(LoyPromotionAc1JoinDetailResDto loyPrulAc1JoinInfo) {
		this.loyPrulAc1JoinInfo = loyPrulAc1JoinInfo;
	}
	public LoyPromotionAc2AddDetailResDto getLoyPrulAc2AddInfo() {
		return loyPrulAc2AddInfo;
	}
	public void setLoyPrulAc2AddInfo(LoyPromotionAc2AddDetailResDto loyPrulAc2AddInfo) {
		this.loyPrulAc2AddInfo = loyPrulAc2AddInfo;
	}
	public LoyPromotionAc2AgrDetailResDto getLoyPrulAc2AgrInfo() {
		return loyPrulAc2AgrInfo;
	}
	public void setLoyPrulAc2AgrInfo(LoyPromotionAc2AgrDetailResDto loyPrulAc2AgrInfo) {
		this.loyPrulAc2AgrInfo = loyPrulAc2AgrInfo;
	}
	public LoyPromotionAc2ConDetailResDto getLoyPrulAc2ConInfo() {
		return loyPrulAc2ConInfo;
	}
	public void setLoyPrulAc2ConInfo(LoyPromotionAc2ConDetailResDto loyPrulAc2ConInfo) {
		this.loyPrulAc2ConInfo = loyPrulAc2ConInfo;
	}
	public LoyPromotionAc2OnDetailResDto getLoyPrulAc2OnInfo() {
		return loyPrulAc2OnInfo;
	}
	public void setLoyPrulAc2OnInfo(LoyPromotionAc2OnDetailResDto loyPrulAc2OnInfo) {
		this.loyPrulAc2OnInfo = loyPrulAc2OnInfo;
	}
	public LoyPromotionAc2SurDetailResDto getLoyPrulAc2SurInfo() {
		return loyPrulAc2SurInfo;
	}
	public void setLoyPrulAc2SurInfo(LoyPromotionAc2SurDetailResDto loyPrulAc2SurInfo) {
		this.loyPrulAc2SurInfo = loyPrulAc2SurInfo;
	}
	public LoyPromotionSa1AniDetailResDto getLoyPrulSa1AniInfo() {
		return loyPrulSa1AniInfo;
	}
	public void setLoyPrulSa1AniInfo(LoyPromotionSa1AniDetailResDto loyPrulSa1AniInfo) {
		this.loyPrulSa1AniInfo = loyPrulSa1AniInfo;
	}
	public LoyPromotionSa1RuleDetailResDto getLoyPrulSa1GenInfo() {
		return loyPrulSa1GenInfo;
	}
	public void setLoyPrulSa1GenInfo(LoyPromotionSa1RuleDetailResDto loyPrulSa1GenInfo) {
		this.loyPrulSa1GenInfo = loyPrulSa1GenInfo;
	}
	public LoyPromotionSa2SumDetailResDto getLoyPrulSa1SumInfo() {
		return loyPrulSa1SumInfo;
	}
	public void setLoyPrulSa1SumInfo(LoyPromotionSa2SumDetailResDto loyPrulSa1SumInfo) {
		this.loyPrulSa1SumInfo = loyPrulSa1SumInfo;
	}
	public LoyPromotionAc1FamDetailResDto getLoyPrulAc1FamInfo() {
		return loyPrulAc1FamInfo;
	}
	public void setLoyPrulAc1FamInfo(LoyPromotionAc1FamDetailResDto loyPrulAc1FamInfo) {
		this.loyPrulAc1FamInfo = loyPrulAc1FamInfo;
	}
	
	
}
