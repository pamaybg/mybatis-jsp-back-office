package com.icignal.loyalty.promotion.campaign.dto.request;


import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class LoyCampaignOfferReqDto extends CommonDataAuthReqDto {

    private String dataStatus;
    
	private String id;             //아이디
	private String campaignId;     //캠페인 ID
	private String offerId;        //오퍼아이디
	
	private List<LoyCampaignOfferReqDto> offerList;
	
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getOfferId() {
        return offerId;
    }

    public void setOfferId(String offerId) {
        this.offerId = offerId;
    }

    public List<LoyCampaignOfferReqDto> getOfferList() {
        return offerList;
    }

    public void setOfferList(List<LoyCampaignOfferReqDto> offerList) {
        this.offerList = offerList;
    }

    public String getDataStatus() {
        return dataStatus;
    }

    public void setDataStatus(String dataStatus) {
        this.dataStatus = dataStatus;
    }

}
