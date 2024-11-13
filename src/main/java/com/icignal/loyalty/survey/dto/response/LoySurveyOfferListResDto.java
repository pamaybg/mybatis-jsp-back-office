package com.icignal.loyalty.survey.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoySurveyOfferListResDto extends GridPagingItemResDto {

    private String ridSurveyOffer;
    private String ridOffer;
    private String offerTitle;
    private String offerNo;
    private String offerName;
    private Integer offerCount;
    private String offerValidStartDate;
    private String createBy;
    private String createDate;

    public String getRidSurveyOffer() {
        return ridSurveyOffer;
    }

    public void setRidSurveyOffer(String ridSurveyOffer) {
        this.ridSurveyOffer = ridSurveyOffer;
    }

    public String getRidOffer() {
        return ridOffer;
    }

    public void setRidOffer(String ridOffer) {
        this.ridOffer = ridOffer;
    }

    public String getOfferTitle() {
        return offerTitle;
    }

    public void setOfferTitle(String offerTitle) {
        this.offerTitle = offerTitle;
    }

    public String getOfferNo() {
        return offerNo;
    }

    public void setOfferNo(String offerNo) {
        this.offerNo = offerNo;
    }

    public String getOfferName() {
        return offerName;
    }

    public void setOfferName(String offerName) {
        this.offerName = offerName;
    }

    public Integer getOfferCount() {
        return offerCount;
    }

    public void setOfferCount(Integer offerCount) {
        this.offerCount = offerCount;
    }

    public String getOfferValidStartDate() {
        return offerValidStartDate;
    }

    public void setOfferValidStartDate(String offerValidStartDate) {
        this.offerValidStartDate = offerValidStartDate;
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
}
