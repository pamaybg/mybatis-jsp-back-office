package com.icignal.marketing.campaign.dto.response;

public class MktCampaignImpotTmpCntResDto {

    private Integer count = 0;

    public Integer getCount() {
        if (count == null) {
            return 0;
        }
        else {
            return count;
        }
    }

    public void setCount(Integer count) {
        this.count = count;
    }

}
