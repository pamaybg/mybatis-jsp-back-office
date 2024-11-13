package com.icignal.marketing.campaign.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktCampaignImpotTmpRemoveReqDto extends MKTBaseReqDto {

    private String camId; // 캠페인ID
    private List<MktCampaignImpotTmpDtlReqDto> memberList;

    public List<MktCampaignImpotTmpDtlReqDto> getMemberList() {
        return memberList;
    }

    public void setMemberList(List<MktCampaignImpotTmpDtlReqDto> memberList) {
        this.memberList = memberList;
    }

    public String getCamId() {
        return camId;
    }

    public void setCamId(String camId) {
        this.camId = camId;
    }

}
