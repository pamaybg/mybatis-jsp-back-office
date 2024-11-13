package com.icignal.loyalty.promotion.campaign.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


@JsonIgnoreProperties(ignoreUnknown = true)
public class LoyCampaignROIReqDto extends CommonDataAuthReqDto {
    
    private String dataStatus;
	
    private String id;    //아이디
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String campaignId;    //캠페인 ID
    
    private List<LoyCampaignROIReturnReqDto> campaignROIReturnList;    //ROI Return 목록
    
    private List<LoyCampaignROICostReqDto> campaignROICostList;    //ROI Cost 목록
	
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

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public List<LoyCampaignROIReturnReqDto> getCampaignROIReturnList() {
        return campaignROIReturnList;
    }

    public void setCampaignROIReturnList(List<LoyCampaignROIReturnReqDto> campaignROIReturnList) {
        this.campaignROIReturnList = campaignROIReturnList;
    }

    public List<LoyCampaignROICostReqDto> getCampaignROICostList() {
        return campaignROICostList;
    }

    public void setCampaignROICostList(List<LoyCampaignROICostReqDto> campaignROICostList) {
        this.campaignROICostList = campaignROICostList;
    }

    public String getDataStatus() {
        return dataStatus;
    }

    public void setDataStatus(String dataStatus) {
        this.dataStatus = dataStatus;
    }

}
