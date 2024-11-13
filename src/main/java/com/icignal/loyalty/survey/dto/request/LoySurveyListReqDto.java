/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**
 * 1. FileName	: LoySurveyListReqDto.java
 * 2. Package	: com.icignal.loyalty.survey.dto.request
 * 3. Comments	:
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 23. 오전 10:37:41
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 23.		 | iticd			|	최초작성
 * -----------------------------------------------------------------
 */
package com.icignal.loyalty.survey.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.loyalty.survey.dto.vo.LoySurveyResultDetailHeaderVo;

import java.util.ArrayList;
import java.util.List;

/*
 * 1. 클래스명	: LoySurveyListReqDto
 * 2. 파일명	: LoySurveyListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.survey.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 23.
 */

/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoySurveyListReqDto extends CommonDataAuthReqDto {

    private String empId;
    private String ridSurvey;
    private String ridSurveySection;
    private String ridSurveyItem;
    private String ridSurveyItemAttr;
    private String ridSurveyMember;
    private String ridMember;
    private String ridSurveyOffer;
    private String itemNo;

    private String offerType;

//    private Boolean activeFlag = false;
    private String existsCheckType;

    private List<LoySurveyResultDetailHeaderVo> headerList = new ArrayList<>();

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }

    public String getRidSurvey() {
        return ridSurvey;
    }

    public void setRidSurvey(String ridSurvey) {
        this.ridSurvey = ridSurvey;
    }

    public String getRidSurveySection() {
        return ridSurveySection;
    }

    public void setRidSurveySection(String ridSurveySection) {
        this.ridSurveySection = ridSurveySection;
    }

    public String getRidSurveyItem() {
        return ridSurveyItem;
    }

    public void setRidSurveyItem(String ridSurveyItem) {
        this.ridSurveyItem = ridSurveyItem;
    }

    public String getRidSurveyItemAttr() {
        return ridSurveyItemAttr;
    }

    public void setRidSurveyItemAttr(String ridSurveyItemAttr) {
        this.ridSurveyItemAttr = ridSurveyItemAttr;
    }

    public String getRidSurveyMember() {
        return ridSurveyMember;
    }

    public void setRidSurveyMember(String ridSurveyMember) {
        this.ridSurveyMember = ridSurveyMember;
    }

    public String getRidMember() {
        return ridMember;
    }

    public void setRidMember(String ridMember) {
        this.ridMember = ridMember;
    }

    public String getRidSurveyOffer() {
        return ridSurveyOffer;
    }

    public void setRidSurveyOffer(String ridSurveyOffer) {
        this.ridSurveyOffer = ridSurveyOffer;
    }

    public String getItemNo() {
        return itemNo;
    }

    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }

    public String getOfferType() {
        return offerType;
    }

    public void setOfferType(String offerType) {
        this.offerType = offerType;
    }

    public String getExistsCheckType() {
        return existsCheckType;
    }

    public void setExistsCheckType(String existsCheckType) {
        this.existsCheckType = existsCheckType;
    }

    public List<LoySurveyResultDetailHeaderVo> getHeaderList() {
        return headerList;
    }

    public void setHeaderList(List<LoySurveyResultDetailHeaderVo> headerList) {
        this.headerList = headerList;
    }
}
