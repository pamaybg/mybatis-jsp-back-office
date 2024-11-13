package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.marketing.campaign.dto.request
 * @date : 2015. 10. 27.
 * @author : 류동균
 * @description : 캠페인 프로그램
 */
public class MktCampaignProgramReqDto extends CommonDataAuthReqDto {
    
    private String id;    //아이디
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String campaignProgramNo;    //캠페인프로그램번호
    private String campaignProgramName;    //캠페인프로그램명
    private String campaignProgramDesc;    //캠페인프로그램설명

	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getCampaignProgramNo() {
        return campaignProgramNo;
    }

    public void setCampaignProgramNo(String campaignProgramNo) {
        this.campaignProgramNo = campaignProgramNo;
    }

    public String getCampaignProgramName() {
        return campaignProgramName;
    }

    public void setCampaignProgramName(String campaignProgramName) {
        this.campaignProgramName = campaignProgramName;
    }

    public String getCampaignProgramDesc() {
        return campaignProgramDesc;
    }

    public void setCampaignProgramDesc(String campaignProgramDesc) {
        this.campaignProgramDesc = campaignProgramDesc;
    }
	
}
