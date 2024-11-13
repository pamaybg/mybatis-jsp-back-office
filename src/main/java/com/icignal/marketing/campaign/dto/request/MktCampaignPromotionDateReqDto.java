package com.icignal.marketing.campaign.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * 캠페인 프로모션 시작&종료일시 조회 Req Dto
 * 
 * @name : infavor.marketing.campaign.dto.request.MktCampaignPromotionDateReqDto
 * @date : 2018. 1. 11.
 * @author : jh.kim
 * @description :
 */
public class MktCampaignPromotionDateReqDto extends MKTBaseReqDto {
    
    private String camId;   //캠페인ID
    
    public String getCamId() {
        return camId;
    }
    
    public void setCamId(String camId) {
        this.camId = camId;
    }
    
}
