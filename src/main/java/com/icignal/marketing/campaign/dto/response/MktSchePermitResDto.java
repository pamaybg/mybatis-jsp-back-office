package com.icignal.marketing.campaign.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MktSchePermitResDto extends GridPagingItemResDto {
    private String chnlNm;
    private String campaignExecPermitStartTime;
    private String campaignExecPermitEndTime;


    public String getChnlNm() {
        return chnlNm;
    }

    public void setChnlNm(String chnlNm) {
        this.chnlNm = chnlNm;
    }

    public String getCampaignExecPermitStartTime() {
        return campaignExecPermitStartTime;
    }

    public void setCampaignExecPermitStartTime(String campaignExecPermitStartTime) {
        this.campaignExecPermitStartTime = campaignExecPermitStartTime;
    }

    public String getCampaignExecPermitEndTime() {
        return campaignExecPermitEndTime;
    }

    public void setCampaignExecPermitEndTime(String campaignExecPermitEndTime) {
        this.campaignExecPermitEndTime = campaignExecPermitEndTime;
    }
}
