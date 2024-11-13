/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**
 * 1. FileName	: LoySurveyDetailResDto.java
 * 2. Package	: com.icignal.loyalty.survey.dto.response
 * 3. Comments	:
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 23. 오후 1:21:07
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 23.		 | iticd			|	최초작성
 * -----------------------------------------------------------------
 */
package com.icignal.loyalty.survey.dto.response;

/*
 * 1. 클래스명	: LoySurveyDetailResDto
 * 2. 파일명	: LoySurveyDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.survey.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 23.
 */

import com.icignal.common.base.dto.response.StatusResDto;

import java.util.ArrayList;
import java.util.List;

/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoySurveyDetailResDto extends StatusResDto {
    private String ridSurvey;
    private String surveyNo;
    private String surveyName;
    private String statusCode;
    private String validStartDate;
    private String validEndDate;


    private String usrTypeCd;

    private String createBy;
    private String createDate;

    private String contents;
    private String urlWeb;

    private String startMessage;
    private String endMessage;

    private String ridImage;

    private String imageFolder;
    private String imageFileName;
    private String imageFileType;


    //Survey Detail (이미지 업로드 두개)
    private String ridStartImage;
    private String ridEndImage;
    private String startImageFolder;
    private String startImageFileName;
    private String startImageFileType;
    private String endImageFolder;
    private String endImageFileName;
    private String endImageFileType;

    private List<LoySurveyPreviewSectionListResDto> sectionList = new ArrayList<>();
    private List<LoySurveyPreviewItemListResDto> itemList = new ArrayList<>();
    private List<LoySurveyPreviewItemAttrListResDto> itemAttrList = new ArrayList<>();

    public LoySurveyDetailResDto() {

    }

    public LoySurveyDetailResDto(boolean success, String message) {
        super(success, message);
    }

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

    public List<LoySurveyPreviewSectionListResDto> getSectionList() {
        return sectionList;
    }

    public void setSectionList(List<LoySurveyPreviewSectionListResDto> sectionList) {
        this.sectionList = sectionList;
    }

    public List<LoySurveyPreviewItemListResDto> getItemList() {
        return itemList;
    }

    public void setItemList(List<LoySurveyPreviewItemListResDto> itemList) {
        this.itemList = itemList;
    }

    public List<LoySurveyPreviewItemAttrListResDto> getItemAttrList() {
        return itemAttrList;
    }

    public void setItemAttrList(List<LoySurveyPreviewItemAttrListResDto> itemAttrList) {
        this.itemAttrList = itemAttrList;
    }

    public String getRidImage() {return ridImage;}

    public void setRidImage(String ridImage) {this.ridImage = ridImage;}

    public String getImageFolder() {return imageFolder;}

    public void setImageFolder(String imageFolder) {this.imageFolder = imageFolder;}

    public String getImageFileName() {return imageFileName;}

    public void setImageFileName(String imageFileName) {this.imageFileName = imageFileName;}

    public String getImageFileType() {return imageFileType;}

    public void setImageFileType(String imageFileType) {this.imageFileType = imageFileType;}

    public String getRidStartImage() {return ridStartImage;}

    public void setRidStartImage(String ridStartImage) {this.ridStartImage = ridStartImage;}

    public String getRidEndImage() {return ridEndImage;}

    public void setRidEndImage(String ridEndImage) {this.ridEndImage = ridEndImage;}

    public String getStartImageFolder() {return startImageFolder;}

    public void setStartImageFolder(String startImageFolder) {this.startImageFolder = startImageFolder;}

    public String getStartImageFileName() {return startImageFileName;}

    public void setStartImageFileName(String startImageFileName) {this.startImageFileName = startImageFileName;}

    public String getStartImageFileType() {return startImageFileType;}

    public void setStartImageFileType(String startImageFileType) {this.startImageFileType = startImageFileType;}

    public String getEndImageFolder() {return endImageFolder;}

    public void setEndImageFolder(String endImageFolder) {this.endImageFolder = endImageFolder;}

    public String getEndImageFileName() {return endImageFileName;}

    public void setEndImageFileName(String endImageFileName) {this.endImageFileName = endImageFileName;}

    public String getEndImageFileType() {return endImageFileType;}

    public void setEndImageFileType(String endImageFileType) {this.endImageFileType = endImageFileType;}


    public String getUsrTypeCd() {return usrTypeCd;}

    public void setUsrTypeCd(String usrTypeCd) {this.usrTypeCd = usrTypeCd;}

}
