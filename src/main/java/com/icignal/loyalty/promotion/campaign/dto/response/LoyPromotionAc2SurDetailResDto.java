/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionAc2SurDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 2. 오후 4:22:30
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 2.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyPromotionAc2SurDetailResDto
 * 2. 파일명	: LoyPromotionAc2SurDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 2.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionAc2SurDetailResDto extends StatusResDto{
	private String rid;
	private String surveyNo;
	private String surveyNm;
	private String surveyRid;
	
	
	public String getSurveyNm() {
		return surveyNm;
	}
	public void setSurveyNm(String surveyNm) {
		this.surveyNm = surveyNm;
	}
	public String getSurveyRid() {
		return surveyRid;
	}
	public void setSurveyRid(String surveyRid) {
		this.surveyRid = surveyRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSurveyNo() {
		return surveyNo;
	}
	public void setSurveyNo(String surveyNo) {
		this.surveyNo = surveyNo;
	}
	
	
}
