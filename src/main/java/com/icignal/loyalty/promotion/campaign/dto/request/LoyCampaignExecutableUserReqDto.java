package com.icignal.loyalty.promotion.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 실행 가능 사용자인지 확인 Request DTO
 * 
 * @name : infavor.marketing.campaign.dto.request.MKTCampaignExecutableUserRequestDTO
 * @date : 2018. 1. 22.
 * @author : jh.kim
 * @description :
 */
public class LoyCampaignExecutableUserReqDto extends CommonDataAuthReqDto {
    
    private String camId;       //캠페인 ID
    
    public String getCamId() {
        return camId;
    }
    
    public void setCamId(String camId) {
        this.camId = camId;
    }
    
}
