package com.icignal.loyalty.survey.dto.response;

public class LoySurveyPreviewItemAttrListResDto {

    private String ridSurveyItem;
    private String ridSurveyItemAttr;
    private String itemAttrNo;
    private String itemValue;
    private Integer targetSectionNo;

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

    public String getItemAttrNo() {
        return itemAttrNo;
    }

    public void setItemAttrNo(String itemAttrNo) {
        this.itemAttrNo = itemAttrNo;
    }

    public String getItemValue() {
        return itemValue;
    }

    public void setItemValue(String itemValue) {
        this.itemValue = itemValue;
    }

    public Integer getTargetSectionNo() {
        return targetSectionNo;
    }

    public void setTargetSectionNo(Integer targetSectionNo) {
        this.targetSectionNo = targetSectionNo;
    }
}