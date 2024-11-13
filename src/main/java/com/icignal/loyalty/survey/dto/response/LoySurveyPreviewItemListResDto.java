package com.icignal.loyalty.survey.dto.response;

public class LoySurveyPreviewItemListResDto {

    private String ridSurveySection;
    private String ridSurveyItem;
    private Integer itemNo;
    private String itemTitle;
    private String fieldTypeCode;
    private String imageContents;
    private String imagePath;

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

    public Integer getItemNo() {
        return itemNo;
    }

    public void setItemNo(Integer itemNo) {
        this.itemNo = itemNo;
    }

    public String getItemTitle() {
        return itemTitle;
    }

    public void setItemTitle(String itemTitle) {
        this.itemTitle = itemTitle;
    }

    public String getFieldTypeCode() {
        return fieldTypeCode;
    }

    public void setFieldTypeCode(String fieldTypeCode) {
        this.fieldTypeCode = fieldTypeCode;
    }

    public String getImageContents() {
        return imageContents;
    }

    public void setImageContents(String imageContents) {
        this.imageContents = imageContents;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}