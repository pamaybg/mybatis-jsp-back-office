package com.icignal.loyalty.survey.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoySurveyItemListResDto extends GridPagingItemResDto {

    private String ridSurveyItem;
    private String empId;
    private String itemNo;
    private String itemTitle;

    @MarkName(groupCode = "LOY_SURV_FIELD_CD", codeField = "fieldTypeCode")
    private String fieldTypeCodeName;
    private String fieldTypeCode;

    private String giveOfferFlag;
    private String optionalFlag;

    private String naFlag;
    private Integer startNum;
    private Integer endNum;

    private String ridImage;
    private String imageContents;

    private String imageFolder;
    private String imageFileName;
    private String imageFileType;

    private String modifyBy;
    private String modifyDate;

    private String ridSurvSect;
    private String ridSurvItem;
//    private int itemNo;
//    private String itemTitle;
    private String fieldTypeCd;
    private String imageDesc;
    private String imagePath;
    private String isOpt;

    public String getRidSurveyItem() {
        return ridSurveyItem;
    }

    public void setRidSurveyItem(String ridSurveyItem) {
        this.ridSurveyItem = ridSurveyItem;
    }

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }

    public String getItemNo() {
        return itemNo;
    }

    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }

    public String getItemTitle() {
        return itemTitle;
    }

    public void setItemTitle(String itemTitle) {
        this.itemTitle = itemTitle;
    }

    public String getFieldTypeCodeName() {
        return fieldTypeCodeName;
    }

    public void setFieldTypeCodeName(String fieldTypeCodeName) {
        this.fieldTypeCodeName = fieldTypeCodeName;
    }

    public String getFieldTypeCode() {
        return fieldTypeCode;
    }

    public void setFieldTypeCode(String fieldTypeCode) {
        this.fieldTypeCode = fieldTypeCode;
    }

    public String getGiveOfferFlag() {
        return giveOfferFlag;
    }

    public void setGiveOfferFlag(String giveOfferFlag) {
        this.giveOfferFlag = giveOfferFlag;
    }

    public String getOptionalFlag() {
        return optionalFlag;
    }

    public void setOptionalFlag(String optionalFlag) {
        this.optionalFlag = optionalFlag;
    }

    public String getNaFlag() {
        return naFlag;
    }

    public void setNaFlag(String naFlag) {
        this.naFlag = naFlag;
    }

    public Integer getStartNum() {
        return startNum;
    }

    public void setStartNum(Integer startNum) {
        this.startNum = startNum;
    }

    public Integer getEndNum() {
        return endNum;
    }

    public void setEndNum(Integer endNum) {
        this.endNum = endNum;
    }

    public String getRidImage() {
        return ridImage;
    }

    public void setRidImage(String ridImage) {
        this.ridImage = ridImage;
    }

    public String getImageContents() {
        return imageContents;
    }

    public void setImageContents(String imageContents) {
        this.imageContents = imageContents;
    }

    public String getImageFolder() {
        return imageFolder;
    }

    public void setImageFolder(String imageFolder) {
        this.imageFolder = imageFolder;
    }

    public String getImageFileName() {
        return imageFileName;
    }

    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }

    public String getImageFileType() {
        return imageFileType;
    }

    public void setImageFileType(String imageFileType) {
        this.imageFileType = imageFileType;
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

    public String getRidSurvSect() {
        return ridSurvSect;
    }

    public void setRidSurvSect(String ridSurvSect) {
        this.ridSurvSect = ridSurvSect;
    }

    public String getRidSurvItem() {
        return ridSurvItem;
    }

    public void setRidSurvItem(String ridSurvItem) {
        this.ridSurvItem = ridSurvItem;
    }

    public String getFieldTypeCd() {
        return fieldTypeCd;
    }

    public void setFieldTypeCd(String fieldTypeCd) {
        this.fieldTypeCd = fieldTypeCd;
    }

    public String getImageDesc() {
        return imageDesc;
    }

    public void setImageDesc(String imageDesc) {
        this.imageDesc = imageDesc;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getIsOpt() {
        return isOpt;
    }

    public void setIsOpt(String isOpt) {
        this.isOpt = isOpt;
    }
}
