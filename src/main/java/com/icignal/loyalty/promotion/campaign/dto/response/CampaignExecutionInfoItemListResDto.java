package com.icignal.loyalty.promotion.campaign.dto.response;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.response.GridPagingItemResDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class CampaignExecutionInfoItemListResDto extends GridPagingItemResDto{
	
    private String id;    //아이디
    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String campaignId;    //캠페인ID
    private String camContsChnlRelId;    //캠페인콘텐츠채널관계아이디
    private String exeSeq;    //실행 순차
    private String exeInfoName;    //실행정보 명
    private String exeTargetAmt;    //실행대상 수
    
    private String exeTargetUnitCode;    //발송 건수 단위
    private String exeTargetUnitCodeName;    //발송 건수 단위
    
    private String exeTargetSendCount;    //실행대상 최종 발송 건수
    
    private String exeInfoStatusCode;    //실행정보상태코드
    private String exeInfoStatusCodeName;    //실행정보상태코드명
    
    private String exeDate;    //실행일시
    
    private String exeInfoDesc;    //설명
    
    private String exeCycleTypeCode;    //반복주기유형코드
    private String exeCycleTypeCodeName;    //반복주기유형코드
    
    private String exeMonthTypeCode;    //월유형코드
    
    private String exeSunYn;    //일요일 실해여부
    private String exeMonYn;    //월요일 실행여부
    private String exeTueYn;    //화요일 실행여부
    private String exeWedYn;    //수요일 실행여부
    private String exeThuYn;    //목요일 실행여부
    private String exeFriYn;    //금요일 실행여부
    private String exeSatYn;    //토요일 실행여부
    private String exeDd;    //실행 일자
    private String exeDay;    //실행 일
    private String exeHour;    //실행 시간
    private String exeMinute;    //실행 분
    private String exeStartDate;    //실행 시작일자
    private String exeEndDate;    //실행 종료일자
    
    private String exeInfoId;    //실행정보 ID
    
    private List<CampaignROIReturnListResDto> exeResponseCountList;    //실행반응수 목록

	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getCamContsChnlRelId() {
        return camContsChnlRelId;
    }

    public void setCamContsChnlRelId(String camContsChnlRelId) {
        this.camContsChnlRelId = camContsChnlRelId;
    }

    public String getExeSeq() {
        return exeSeq;
    }

    public void setExeSeq(String exeSeq) {
        this.exeSeq = exeSeq;
    }

    public String getExeInfoName() {
        return exeInfoName;
    }

    public void setExeInfoName(String exeInfoName) {
        this.exeInfoName = exeInfoName;
    }

    public String getExeTargetAmt() {
        return exeTargetAmt;
    }

    public void setExeTargetAmt(String exeTargetAmt) {
        this.exeTargetAmt = exeTargetAmt;
    }

    public String getExeTargetUnitCode() {
        return exeTargetUnitCode;
    }

    public void setExeTargetUnitCode(String exeTargetUnitCode) {
        this.exeTargetUnitCode = exeTargetUnitCode;
    }

    public String getExeTargetUnitCodeName() {
        return exeTargetUnitCodeName;
    }

    public void setExeTargetUnitCodeName(String exeTargetUnitCodeName) {
        this.exeTargetUnitCodeName = exeTargetUnitCodeName;
    }

    public String getExeTargetSendCount() {
        return exeTargetSendCount;
    }

    public void setExeTargetSendCount(String exeTargetSendCount) {
        this.exeTargetSendCount = exeTargetSendCount;
    }

    public String getExeInfoStatusCode() {
        return exeInfoStatusCode;
    }

    public void setExeInfoStatusCode(String exeInfoStatusCode) {
        this.exeInfoStatusCode = exeInfoStatusCode;
    }

    public String getExeInfoStatusCodeName() {
        return exeInfoStatusCodeName;
    }

    public void setExeInfoStatusCodeName(String exeInfoStatusCodeName) {
        this.exeInfoStatusCodeName = exeInfoStatusCodeName;
    }

    public String getExeInfoDesc() {
        return exeInfoDesc;
    }

    public void setExeInfoDesc(String exeInfoDesc) {
        this.exeInfoDesc = exeInfoDesc;
    }

    public String getExeCycleTypeCode() {
        return exeCycleTypeCode;
    }

    public void setExeCycleTypeCode(String exeCycleTypeCode) {
        this.exeCycleTypeCode = exeCycleTypeCode;
    }

    public String getExeCycleTypeCodeName() {
        return exeCycleTypeCodeName;
    }

    public void setExeCycleTypeCodeName(String exeCycleTypeCodeName) {
        this.exeCycleTypeCodeName = exeCycleTypeCodeName;
    }

    public String getExeSunYn() {
        return exeSunYn;
    }

    public void setExeSunYn(String exeSunYn) {
        this.exeSunYn = exeSunYn;
    }

    public String getExeMonYn() {
        return exeMonYn;
    }

    public void setExeMonYn(String exeMonYn) {
        this.exeMonYn = exeMonYn;
    }

    public String getExeTueYn() {
        return exeTueYn;
    }

    public void setExeTueYn(String exeTueYn) {
        this.exeTueYn = exeTueYn;
    }

    public String getExeWedYn() {
        return exeWedYn;
    }

    public void setExeWedYn(String exeWedYn) {
        this.exeWedYn = exeWedYn;
    }

    public String getExeThuYn() {
        return exeThuYn;
    }

    public void setExeThuYn(String exeThuYn) {
        this.exeThuYn = exeThuYn;
    }

    public String getExeFriYn() {
        return exeFriYn;
    }

    public void setExeFriYn(String exeFriYn) {
        this.exeFriYn = exeFriYn;
    }

    public String getExeSatYn() {
        return exeSatYn;
    }

    public void setExeSatYn(String exeSatYn) {
        this.exeSatYn = exeSatYn;
    }

    public String getExeDd() {
        return exeDd;
    }

    public void setExeDd(String exeDd) {
        this.exeDd = exeDd;
    }

    public String getExeDay() {
        return exeDay;
    }

    public void setExeDay(String exeDay) {
        this.exeDay = exeDay;
    }

    public String getExeHour() {
        return exeHour;
    }

    public void setExeHour(String exeHour) {
        this.exeHour = exeHour;
    }

    public String getExeMinute() {
        return exeMinute;
    }

    public void setExeMinute(String exeMinute) {
        this.exeMinute = exeMinute;
    }

    public String getExeStartDate() {
        return exeStartDate;
    }

    public void setExeStartDate(String exeStartDate) {
        this.exeStartDate = exeStartDate;
    }

    public String getExeEndDate() {
        return exeEndDate;
    }

    public void setExeEndDate(String exeEndDate) {
        this.exeEndDate = exeEndDate;
    }

    public String getExeInfoId() {
        return exeInfoId;
    }

    public void setExeInfoId(String exeInfoId) {
        this.exeInfoId = exeInfoId;
    }

    public String getExeDate() {
        return exeDate;
    }

    public void setExeDate(String exeDate) {
        this.exeDate = exeDate;
    }

    public String getExeMonthTypeCode() {
        return exeMonthTypeCode;
    }

    public void setExeMonthTypeCode(String exeMonthTypeCode) {
        this.exeMonthTypeCode = exeMonthTypeCode;
    }

    public List<CampaignROIReturnListResDto> getExeResponseCountList() {
        return exeResponseCountList;
    }

    public void setExeResponseCountList(List<CampaignROIReturnListResDto> exeResponseCountList) {
        this.exeResponseCountList = exeResponseCountList;
    }
	
}
