package com.icignal.marketing.common.checker.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : infavor.marketing.common.checker.dto.response
 * @date : 2015. 11. 10.
 * @author : 류동균
 * @description : 
 */
public class MktFatigueResDto extends StatusResDto {
    
    private String id;    //아이디
    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String customerGradeCode;    //고객등급
    private String customerGradeCodeName;    //고객등급
    
    private String channelTypeCode;    //채널유형코드
    private String channelTypeCodeName;    //채널유형코드
    
    private String periodDivCode;    //기간구분
    private String periodDivCodeName;    //기간구분
    
    private String maxRstrtnTmscnt;    //최대제한횟수
    private String startDd;    //시작일자
    private String endDd;    //종료일자
    private String fatigueDesc;    //설명
    private String accountId;    //Account ID

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

    public String getCustomerGradeCode() {
        return customerGradeCode;
    }

    public void setCustomerGradeCode(String customerGradeCode) {
        this.customerGradeCode = customerGradeCode;
    }

    public String getCustomerGradeCodeName() {
        return customerGradeCodeName;
    }

    public void setCustomerGradeCodeName(String customerGradeCodeName) {
        this.customerGradeCodeName = customerGradeCodeName;
    }

    public String getChannelTypeCode() {
        return channelTypeCode;
    }

    public void setChannelTypeCode(String channelTypeCode) {
        this.channelTypeCode = channelTypeCode;
    }

    public String getChannelTypeCodeName() {
        return channelTypeCodeName;
    }

    public void setChannelTypeCodeName(String channelTypeCodeName) {
        this.channelTypeCodeName = channelTypeCodeName;
    }

    public String getPeriodDivCode() {
        return periodDivCode;
    }

    public void setPeriodDivCode(String periodDivCode) {
        this.periodDivCode = periodDivCode;
    }

    public String getPeriodDivCodeName() {
        return periodDivCodeName;
    }

    public void setPeriodDivCodeName(String periodDivCodeName) {
        this.periodDivCodeName = periodDivCodeName;
    }

    public String getMaxRstrtnTmscnt() {
        return maxRstrtnTmscnt;
    }

    public void setMaxRstrtnTmscnt(String maxRstrtnTmscnt) {
        this.maxRstrtnTmscnt = maxRstrtnTmscnt;
    }

    public String getStartDd() {
        return startDd;
    }

    public void setStartDd(String startDd) {
        this.startDd = startDd;
    }

    public String getEndDd() {
        return endDd;
    }

    public void setEndDd(String endDd) {
        this.endDd = endDd;
    }

    public String getFatigueDesc() {
        return fatigueDesc;
    }

    public void setFatigueDesc(String fatigueDesc) {
        this.fatigueDesc = fatigueDesc;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }
    

}
