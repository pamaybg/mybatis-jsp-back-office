/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**
 * 1. FileName	: LoySurveyDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.survey.dto.request
 * 3. Comments	:
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 23. 오후 1:30:44
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 23.		 | iticd			|	최초작성
 * -----------------------------------------------------------------
 */
package com.icignal.loyalty.survey.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.loyalty.survey.dto.vo.LoySurveyCopyVo;

import java.util.ArrayList;
import java.util.List;

/*
 * 1. 클래스명	: LoySurveyDetailReqDto
 * 2. 파일명	: LoySurveyDetailReqDto.java
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

public class LoySurveyDetailReqDto extends CommonDataAuthReqDto {

    private String empId;
    private String ridSurvey;
    private String ridSurveySection;
    private String ridSurveyItem;
    private String ridSurveyItemAttr;
    private String ridSurveyOffer;

    // Survey
    private String surveyNo;
    private String surveyName;
    private String statusCode;
    private String validStartDate;
    private String validEndDate;
    private String contents;
    private String urlWeb;


    private String usrTypeCd;

    private String startMessage;
    private String endMessage;

    //Survey Section
    private Integer sectionNo;
    private String sectionContents;
    private String lastFlag;

    //Survey Item
    private String itemNo;
    private String itemTitle;
    private String fieldTypeCode;
    private String itemContents;
    private String naFlag;
    private Integer startNum;
    private Integer endNum;
    private String ridImage;
    private MultiUploadReqDto imageData;
    private String imageContents;
    private String lastSectionFlag;

    private String giveOfferFlag;
    private String optionalFlag;


    //Survey Detail (이미지 업로드 두개)
    private String ridStartImage;
    private String ridEndImage;
    private MultiUploadReqDto startImageData;
    private MultiUploadReqDto endImageData;

    //surveyItemAttr
    private String itemAttrNo;
    private String itemAttrValue;
    private Integer targetSectionNo;

    //surveyOffer
    private String ridOffer;
    private String offerTitle;
    private String offerCount;
    private String offerValidStartDate;

    // Survey Copy
    private String ridSurveyCopy;
    private List<LoySurveyCopyVo> ridSurveySectionCopyList = new ArrayList<>();
    private List<LoySurveyCopyVo> ridSurveyItemCopyList = new ArrayList<>();

    //Survey Text Item
    private String ridTextItem;
    private String textItemNm;

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

    public String getRidSurveyOffer() {
        return ridSurveyOffer;
    }

    public void setRidSurveyOffer(String ridSurveyOffer) {
        this.ridSurveyOffer = ridSurveyOffer;
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

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
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

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getUrlWeb() {
        return urlWeb;
    }

    public void setUrlWeb(String urlWeb) {
        this.urlWeb = urlWeb;
    }

    public String getStartMessage() {
        return startMessage;
    }

    public void setStartMessage(String startMessage) {
        this.startMessage = startMessage;
    }

    public String getEndMessage() {
        return endMessage;
    }

    public void setEndMessage(String endMessage) {
        this.endMessage = endMessage;
    }

    public Integer getSectionNo() {
        return sectionNo;
    }

    public void setSectionNo(Integer sectionNo) {
        this.sectionNo = sectionNo;
    }

    public String getSectionContents() {
        return sectionContents;
    }

    public void setSectionContents(String sectionContents) {
        this.sectionContents = sectionContents;
    }

    public String getLastFlag() {
        return lastFlag;
    }

    public void setLastFlag(String lastFlag) {
        this.lastFlag = lastFlag;
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

    public String getFieldTypeCode() {
        return fieldTypeCode;
    }

    public void setFieldTypeCode(String fieldTypeCode) {
        this.fieldTypeCode = fieldTypeCode;
    }

    public String getItemContents() {
        return itemContents;
    }

    public void setItemContents(String itemContents) {
        this.itemContents = itemContents;
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

    public MultiUploadReqDto getImageData() {
        return imageData;
    }

    public void setImageData(MultiUploadReqDto imageData) {
        this.imageData = imageData;
    }

    public String getImageContents() {
        return imageContents;
    }

    public void setImageContents(String imageContents) {
        this.imageContents = imageContents;
    }

    public String getLastSectionFlag() {
        return lastSectionFlag;
    }

    public void setLastSectionFlag(String lastSectionFlag) {
        this.lastSectionFlag = lastSectionFlag;
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

    public String getOfferCount() {
        return offerCount;
    }

    public void setOfferCount(String offerCount) {
        this.offerCount = offerCount;
    }

    public String getOfferValidStartDate() {
        return offerValidStartDate;
    }

    public void setOfferValidStartDate(String offerValidStartDate) {
        this.offerValidStartDate = offerValidStartDate;
    }

    public String getRidSurveyCopy() {
        return ridSurveyCopy;
    }

    public void setRidSurveyCopy(String ridSurveyCopy) {
        this.ridSurveyCopy = ridSurveyCopy;
    }

    public List<LoySurveyCopyVo> getRidSurveySectionCopyList() {
        return ridSurveySectionCopyList;
    }

    public void setRidSurveySectionCopyList(List<LoySurveyCopyVo> ridSurveySectionCopyList) {this.ridSurveySectionCopyList = ridSurveySectionCopyList;}

    public List<LoySurveyCopyVo> getRidSurveyItemCopyList() {
        return ridSurveyItemCopyList;
    }

    public void setRidSurveyItemCopyList(List<LoySurveyCopyVo> ridSurveyItemCopyList) {this.ridSurveyItemCopyList = ridSurveyItemCopyList;}

    public String getRidStartImage() {return ridStartImage;}

    public void setRidStartImage(String ridStartImage) {this.ridStartImage = ridStartImage;}

    public String getRidEndImage() {return ridEndImage;}

    public void setRidEndImage(String ridEndImage) {this.ridEndImage = ridEndImage;}

    public MultiUploadReqDto getStartImageData() {return startImageData;}

    public void setStartImageData(MultiUploadReqDto startImageData) {this.startImageData = startImageData;}

    public MultiUploadReqDto getEndImageData() {return endImageData;}

    public void setEndImageData(MultiUploadReqDto endImageData) {this.endImageData = endImageData;}

    public String getUsrTypeCd() {return usrTypeCd;}

    public void setUsrTypeCd(String usrTypeCd) {this.usrTypeCd = usrTypeCd;}

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
}
