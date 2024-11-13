/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**
 * 1. FileName	: LoySurveyListResDto.java
 * 2. Package	: com.icignal.loyalty.survey.dto.response
 * 3. Comments	:
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 23. 오전 10:37:51
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 23.		 | iticd			|	최초작성
 * -----------------------------------------------------------------
 */
package com.icignal.loyalty.survey.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoySurveyListResDto
 * 2. 파일명	: LoySurveyListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.survey.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 23.
 */

/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoySurveyListResDto extends GridPagingItemResDto {

    private String ridSurvey;
    private String surveyNo;
    private String surveyName;
    private String validStartDate;
    private String validEndDate;
    private String validDate;

    private String statusCode;
    @MarkName(groupCode = "LOY_SURV_STAT_TYPE_CD", codeField = "statusCode")
    private String statusCodeName;

    private Integer targetCount;
    private Integer surveyCount;
    private String createBy;
    private String createDate;
    private String createById;

    public String getRidSurvey() {
        return ridSurvey;
    }

    public void setRidSurvey(String ridSurvey) {
        this.ridSurvey = ridSurvey;
    }

    public String getSurveyNo() {
        return surveyNo;
    }

    public void setSurveyNo(String surveyNo) {
        this.surveyNo = surveyNo;
    }

    public String getSurveyName() {
        return surveyName;
    }

    public void setSurveyName(String surveyName) {
        this.surveyName = surveyName;
    }

    public String getValidStartDate() {
        return validStartDate;
    }

    public void setValidStartDate(String validStartDate) {
        this.validStartDate = validStartDate;
    }

    public String getValidEndDate() {
        return validEndDate;
    }

    public void setValidEndDate(String validEndDate) {
        this.validEndDate = validEndDate;
    }

    public String getValidDate() {
        return validDate;
    }

    public void setValidDate(String validDate) {
        this.validDate = validDate;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusCodeName() {
        return statusCodeName;
    }

    public void setStatusCodeName(String statusCodeName) {
        this.statusCodeName = statusCodeName;
    }

    public Integer getTargetCount() {
        return targetCount;
    }

    public void setTargetCount(Integer targetCount) {
        this.targetCount = targetCount;
    }

    public Integer getSurveyCount() {
        return surveyCount;
    }

    public void setSurveyCount(Integer surveyCount) {
        this.surveyCount = surveyCount;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getCreateById() {
        return createById;
    }

    public void setCreateById(String createById) {
        this.createById = createById;
    }
}
