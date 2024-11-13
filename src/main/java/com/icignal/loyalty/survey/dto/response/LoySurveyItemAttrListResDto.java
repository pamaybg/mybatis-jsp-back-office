package com.icignal.loyalty.survey.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoySurveyItemAttrListResDto extends GridPagingItemResDto {

    private String ridSurveyItemAttr;

    private String itemAttrNo;
    private String itemAttrValue;

    private Integer targetSectionNo;

    private String readonlyFlag;

    private String modifyBy;
    private String modifyDate;

    private String ridSurvItem;
    private String ridSurvItemAttr;
    //    private int itemAttrNo;
    private String itemValue;
    private int tgtSectNo;

    //Survey Text Item
    private String ridTextItem;
    private String textItemNm;

    private String ridControlSource;

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

    public String getItemAttrValue() {
        return itemAttrValue;
    }

    public void setItemAttrValue(String itemAttrValue) {
        this.itemAttrValue = itemAttrValue;
    }

    public Integer getTargetSectionNo() {
        return targetSectionNo;
    }

    public void setTargetSectionNo(Integer targetSectionNo) {
        this.targetSectionNo = targetSectionNo;
    }

    public String getReadonlyFlag() {
        return readonlyFlag;
    }

    public void setReadonlyFlag(String readonlyFlag) {
        this.readonlyFlag = readonlyFlag;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }

    public String getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
    }

    public String getRidSurvItem() {
        return ridSurvItem;
    }

    public void setRidSurvItem(String ridSurvItem) {
        this.ridSurvItem = ridSurvItem;
    }

    public String getRidSurvItemAttr() {
        return ridSurvItemAttr;
    }

    public void setRidSurvItemAttr(String ridSurvItemAttr) {
        this.ridSurvItemAttr = ridSurvItemAttr;
    }

    public String getItemValue() {
        return itemValue;
    }

    public void setItemValue(String itemValue) {
        this.itemValue = itemValue;
    }

    public int getTgtSectNo() {
        return tgtSectNo;
    }

    public void setTgtSectNo(int tgtSectNo) {
        this.tgtSectNo = tgtSectNo;
    }

    public String getRidTextItem() {
        return ridTextItem;
    }

    public void setRidTextItem(String ridTextItem) {
        this.ridTextItem = ridTextItem;
    }

    public String getTextItemNm() {
        return textItemNm;
    }

    public void setTextItemNm(String textItemNm) {
        this.textItemNm = textItemNm;
    }

    public String getRidControlSource() {
        return ridControlSource;
    }

    public void setRidControlSource(String ridControlSource) {
        this.ridControlSource = ridControlSource;
    }
}
