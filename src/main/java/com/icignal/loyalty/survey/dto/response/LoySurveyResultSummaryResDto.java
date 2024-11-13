package com.icignal.loyalty.survey.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

import java.math.BigDecimal;

public class LoySurveyResultSummaryResDto extends StatusResDto {

    private BigDecimal totalCount;
    private BigDecimal enterCount;
    private BigDecimal enterRate;

    public BigDecimal getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(BigDecimal totalCount) {
        this.totalCount = totalCount;
    }

    public BigDecimal getEnterCount() {
        return enterCount;
    }

    public void setEnterCount(BigDecimal enterCount) {
        this.enterCount = enterCount;
    }

    public BigDecimal getEnterRate() {
        return enterRate;
    }

    public void setEnterRate(BigDecimal enterRate) {
        this.enterRate = enterRate;
    }
}