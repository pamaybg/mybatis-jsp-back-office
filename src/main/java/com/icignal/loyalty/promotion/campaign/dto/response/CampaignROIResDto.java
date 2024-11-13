package com.icignal.loyalty.promotion.campaign.dto.response;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.response.StatusResDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class CampaignROIResDto extends StatusResDto {
	
    private String id;    //아이디
    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String campaignId;    //캠페인 ID
    
    private List<CampaignROIReturnListResDto> campaignROIReturnList;    //ROI Return 목록
    
    private List<CampaignROICostListResDto> campaignROICostList;    //ROI Cost 목록
	
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

    public List<CampaignROIReturnListResDto> getCampaignROIReturnList() {
        return campaignROIReturnList;
    }

    public void setCampaignROIReturnList(List<CampaignROIReturnListResDto> campaignROIReturnList) {
        this.campaignROIReturnList = campaignROIReturnList;
    }

    public List<CampaignROICostListResDto> getCampaignROICostList() {
        return campaignROICostList;
    }

    public void setCampaignROICostList(List<CampaignROICostListResDto> campaignROICostList) {
        this.campaignROICostList = campaignROICostList;
    }

}
